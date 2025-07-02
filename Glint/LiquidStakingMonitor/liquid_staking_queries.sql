
-- Query 1: Liquid-Staking Market-Cap & Dominance
-- Fetch daily avg USD market-cap for stETH & rETH over the past year,
-- plus each token’s share of total DeFi market-cap.
WITH daily_mcap AS (
  SELECT
    DATE_TRUNC('day', date)        AS day,
    LOWER(symbol)                  AS symbol,
    AVG(usd_market_cap)            AS mcap_usd
  FROM prices
  WHERE
    date >= CURRENT_DATE - INTERVAL '1 year'
    AND LOWER(symbol) IN ('steth','reth')
  GROUP BY 1,2
)
SELECT
  d.day,
  d.symbol,
  d.mcap_usd,
  d.mcap_usd / g.defi_market_cap  AS dominance_ratio
FROM daily_mcap d
JOIN global_defi g
  ON g.date::date = d.day;


-- Query 2: Liquid-Staking Implied APY Spread
-- Compute implied staking APY for stETH & rETH over the past 180 days
-- based on daily price ratio vs ETH, and the APY spread.
WITH daily_prices AS (
  SELECT
    DATE_TRUNC('day', date)           AS day,
    LOWER(symbol)                     AS symbol,
    AVG(usd_price)                    AS price_usd
  FROM prices
  WHERE
    date >= CURRENT_DATE - INTERVAL '180 days'
    AND LOWER(symbol) IN ('steth','reth','eth')
  GROUP BY 1,2
),
price_ratios AS (
  SELECT
    a.day,
    a.symbol                        AS token,
    a.price_usd / b.price_usd      AS price_ratio
  FROM daily_prices a
  JOIN daily_prices b
    ON a.day = b.day
   AND b.symbol = 'eth'
  WHERE a.symbol IN ('steth','reth')
),
returns AS (
  SELECT
    day,
    token                           AS symbol,
    price_ratio 
      / LAG(price_ratio) OVER (PARTITION BY token ORDER BY day)
    - 1                             AS daily_ret
  FROM price_ratios
),
apy_calc AS (
  SELECT
    day,
    symbol,
    daily_ret * 365                AS apy
  FROM returns
)
SELECT
  day,
  MAX(CASE WHEN symbol = 'steth' THEN apy END) AS steth_apy,
  MAX(CASE WHEN symbol = 'reth'  THEN apy END) AS reth_apy,
  MAX(CASE WHEN symbol = 'steth' THEN apy END)
  - MAX(CASE WHEN symbol = 'reth'  THEN apy END) AS apy_spread
FROM apy_calc
GROUP BY day;


-- Query 3: Liquid-Staking Peg Deviation
-- Calculate daily peg deviation (%) of stETH & rETH vs ETH over the past 180 days.
WITH daily_prices AS (
  SELECT
    DATE_TRUNC('day', date)        AS day,
    LOWER(symbol)                  AS symbol,
    AVG(usd_price)                 AS price_usd
  FROM prices
  WHERE
    date >= CURRENT_DATE - INTERVAL '180 days'
    AND LOWER(symbol) IN ('steth','reth','eth')
  GROUP BY 1,2
)
SELECT
  s.day,
  s.symbol,
  (s.price_usd / e.price_usd - 1) * 100 AS peg_deviation_pct
FROM daily_prices s
JOIN daily_prices e
  ON s.day = e.day
 AND e.symbol = 'eth'
WHERE s.symbol IN ('steth','reth');


-- Query 4: Liquid-Staking Liquidity Proxy (30-Day Avg Volume)
-- Compute 30-day average daily USD volume for stETH & rETH as a liquidity proxy.
SELECT
  symbol,
  AVG(daily_vol)               AS avg_vol_30d_usd
FROM (
  SELECT
    DATE_TRUNC('day', date)   AS day,
    LOWER(symbol)             AS symbol,
    SUM(usd_total_volume)     AS daily_vol
  FROM prices
  WHERE
    date >= CURRENT_DATE - INTERVAL '30 days'
    AND LOWER(symbol) IN ('steth','reth')
  GROUP BY 1,2
) t
GROUP BY symbol;


-- Query 5: Liquid-Staking Sankey: Category → Token Volume Flow
-- Get the latest USD 24h volume flow from the 'Staking' category to stETH and rETH.
SELECT
  c.category_name AS source,
  p.symbol        AS target,
  SUM(p.usd_total_volume) AS value
FROM prices p
JOIN token_categories tc
  ON p.token_id = tc.token_id
JOIN categories c
  ON tc.category_id = c.category_id
WHERE
  p.date::date = (
    SELECT MAX(date::date) FROM prices
  )
  AND LOWER(c.category_name) LIKE '%stake%'
  AND LOWER(p.symbol) IN ('steth','reth')
GROUP BY 1,2;
