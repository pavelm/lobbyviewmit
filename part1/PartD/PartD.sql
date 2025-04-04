----------------
-- Part D

-- For using Similar to https://www.codecademy.com/resources/docs/sql/operators/similar-to
-- a percent sign (%) matches any sequence of zero or more character (https://www.postgresql.org/docs/current/functions-matching.html#FUNCTIONS-SIMILARTO-REGEXP)
SELECT
  COUNT(*) FILTER (
    WHERE title SIMILAR TO '%(Act|Law|Resolution)'
  ) AS standard_titles_count,

  COUNT(*) FILTER (
    WHERE title NOT SIMILAR TO '%(Act|Law|Resolution)'
  ) AS non_standard_titles_count
FROM analyst.bills;

