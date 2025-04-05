-- Assumption: retrieving a registrants' id is adequate


----------------
-- Part A

SELECT r.registrant_id, SUM(f.amount) as total --include the sum in the columns so it's clear that your results are correct
FROM analyst.registrants AS r
JOIN analyst.filings AS f ON r.registrant_id = f.registrant_id
WHERE f.amount IS NOT NULL  
GROUP BY r.registrant_id
HAVING SUM(f.amount) > '$10000000'::money --Here's how you can do it without a coalesce 
ORDER BY SUM(f.amount) DESC
;
--LIMIT 10;  -- the task says that your query should return everything but you can put the top 10 in your document


