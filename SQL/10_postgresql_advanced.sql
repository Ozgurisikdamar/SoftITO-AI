-- PostgreSQL only: JSONB, UPSERT, time aggregation
CREATE TABLE IF NOT EXISTS app_events_demo(
 event_id TEXT PRIMARY KEY,user_id BIGINT NOT NULL,event_type TEXT NOT NULL,
 payload JSONB NOT NULL DEFAULT '{}'::jsonb,occurred_at TIMESTAMPTZ NOT NULL,
 updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
INSERT INTO app_events_demo(event_id,user_id,event_type,payload,occurred_at)
VALUES('evt-001',42,'purchase','{"currency":"TRY","amount":249.90}'::jsonb,NOW())
ON CONFLICT(event_id) DO UPDATE SET payload=EXCLUDED.payload,event_type=EXCLUDED.event_type,occurred_at=EXCLUDED.occurred_at,updated_at=NOW();
SELECT event_id,payload->>'currency' AS currency,(payload->>'amount')::numeric AS amount
FROM app_events_demo WHERE payload->>'currency'='TRY';
SELECT DATE_TRUNC('day',occurred_at) AS event_day,event_type,COUNT(*) AS event_count
FROM app_events_demo GROUP BY 1,2 ORDER BY 1,2;
SELECT * FROM (
 SELECT e.*,ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY occurred_at DESC) AS rn FROM app_events_demo e
) ranked WHERE rn=1;
