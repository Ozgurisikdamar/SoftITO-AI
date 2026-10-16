-- Example ELT transformation (PostgreSQL syntax).
-- Assumption: raw_events(event_id, event_time_text, country, amount_text)

CREATE TABLE IF NOT EXISTS analytics_events AS
SELECT
    event_id,
    NULLIF(BTRIM(country), '') AS country,
    NULLIF(BTRIM(event_time_text), '')::timestamptz AS event_time,
    NULLIF(BTRIM(amount_text), '')::numeric(18, 2) AS amount,
    CURRENT_TIMESTAMP AS transformed_at
FROM raw_events
WHERE NULLIF(BTRIM(event_id), '') IS NOT NULL
  AND NULLIF(BTRIM(event_time_text), '') IS NOT NULL
  AND NULLIF(BTRIM(amount_text), '') ~ '^[0-9]+(\.[0-9]+)?$'
ON CONFLICT DO NOTHING;

-- For recurring production loads, prefer an explicit target table with a
-- primary/unique key and INSERT ... ON CONFLICT (...) DO UPDATE.
