WITH mapped AS (
  SELECT
    t.token_id,
    CASE
      WHEN c.category_name = 'Fiat-backed Stablecoin' THEN 'Fiat-backed'
      WHEN c.category_name = 'Algorithmic Stablecoin' THEN 'Algorithmic'
      WHEN c.category_name = 'Crypto-backed Stablecoin' THEN 'Crypto-backed'
      WHEN c.category_name = 'Commodity-backed Stablecoin' THEN 'Commodity-backed'
      ELSE NULL
    END AS parent_category
  FROM TOKENS t
  JOIN TOKEN_CATEGORIES tc
    ON t.TOKEN_ID = tc.TOKEN_ID
  JOIN CATEGORIES c
    ON tc.CATEGORY_ID = c.CATEGORY_ID
  WHERE
    c.CATEGORY_NAME IN (
      'Fiat-backed Stablecoin',
      'Algorithmic Stablecoin',
      'Crypto-backed Stablecoin',
      'Commodity-backed Stablecoin'
    )
)
SELECT
  'All Stablecoins'    AS source,
  parent_category      AS target,
  COUNT(DISTINCT token_id) AS value
FROM mapped
GROUP BY parent_category
ORDER BY value DESC;