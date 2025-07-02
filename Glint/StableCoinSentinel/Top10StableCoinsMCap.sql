WITH
-- 1) Determine the latest date we have in prices
latest_day AS (
  SELECT
    MAX(date::date) AS day
  FROM prices
),

-- 2) Snapshot: for that date, get each token’s max market-cap
daily_snapshot AS (
  SELECT
    p.token_id,
    t.symbol,
    MAX(p.usd_market_cap) AS usd_market_cap
  FROM prices p
  JOIN tokens t
    ON p.token_id = t.token_id
  WHERE date(p.date) = (SELECT day FROM latest_day)
  GROUP BY p.token_id, t.symbol
),

-- 3) Filter to only those in the Stablecoins category
stable_snapshot AS (
  SELECT
    ds.symbol,
    ds.usd_market_cap
  FROM daily_snapshot ds
  JOIN token_categories tc
    ON ds.token_id = tc.token_id
  JOIN categories c
    ON tc.category_id = c.category_id
  WHERE c.category_name = 'Stablecoins'
)

-- 4) Rank and pick the top 10
SELECT
  symbol,
  usd_market_cap
FROM stable_snapshot
ORDER BY usd_market_cap DESC
LIMIT 10;