SELECT *
FROM {{ ref('fct_job_ads') }}
WHERE relevance > 1

--the test should fail with WHERE relevance = 1