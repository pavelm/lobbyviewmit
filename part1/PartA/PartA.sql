-- Assumption: retrieving a registrants' id is adequate


----------------
-- Part A

SELECT r.registrant_id
FROM analyst.registrants AS r
         JOIN analyst.filings AS f ON r.registrant_id = f.registrant_id
GROUP BY r.registrant_id
HAVING COALESCE(SUM(amount::numeric), 0) > 10000000
LIMIT 10;
--  (converting from money type to numeric) https://www.postgresql.org/docs/current/datatype-money.html

