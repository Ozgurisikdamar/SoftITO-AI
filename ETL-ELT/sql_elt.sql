-- PostgreSQL ELT example.
-- Source table assumption: raw_events(event_id, event_time_text, country, amount_text).
-- Load raw rows first, then run this script repeatedly. event_id makes the load idempotent.

CREATE TABLE IF NOT EXISTS analytics_events (
    event_id       text PRIMARY KEY,
    country        text,
    event_time     timestamptz,
    amount         numeric(18, 2),
    transformed_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO analytics_events (event_id, country, event_time, amount, transformed_at)
SELECT
    BTRIM(event_id),
    NULLIF(UPPER(BTRIM(country)), ''),
    NULLIF(BTRIM(event_time_text), '')::timestamptz,
    NULLIF(BTRIM(amount_text), '')::numeric(18, 2),
    CURRENT_TIMESTAMP
FROM raw_events
WHERE NULLIF(BTRIM(event_id), '') IS NOT NULL
  AND NULLIF(BTRIM(event_time_text), '') IS NOT NULL
  AND NULLIF(BTRIM(amount_text), '') ~ '^[0-9]+(\\.[0-9]+)?$'
ON CONFLICT (event_id) DO UPDATE SET
    country = EXCLUDED.country,
    event_time = EXCLUDED.event_time,
    amount = EXCLUDED.amount,
    transformed_at = CURRENT_TIMESTAMP;
