
----------------
-- Part B

-- select the top 5 clients for each registrant
WITH top_super_registrants AS (
    SELECT r.registrant_id,
           COALESCE(SUM(amount::numeric), 0) AS total_value
    FROM analyst.registrants AS r
             JOIN analyst.filings AS f ON r.registrant_id = f.registrant_id
    GROUP BY r.registrant_id
    HAVING COALESCE(SUM(amount::numeric), 0) > 10000000
    ORDER BY total_value DESC
    LIMIT 5
),
     top_clients AS (
         SELECT f.registrant_id,
                f.client_id,
                COALESCE(SUM(amount::numeric), 0) AS total_amount,
                ROW_NUMBER() OVER (PARTITION BY f.registrant_id ORDER BY COALESCE(SUM(amount::numeric), 0) DESC) AS rank
         FROM analyst.filings AS f
                  JOIN top_super_registrants AS tsr ON f.registrant_id = tsr.registrant_id
         GROUP BY f.registrant_id, f.client_id
     )
SELECT registrant_id, client_id, total_amount
-- join on the registrant and client tables to list the names of each client for each registrant.
FROM top_clients
WHERE rank <= 5
ORDER BY registrant_id, rank;
