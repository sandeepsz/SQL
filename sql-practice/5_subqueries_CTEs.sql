SELECT company_id,
    name AS company_name
FROM company_dim
WHERE company_id IN (
        SELECT company_id
        FROM job_postings_fact
        WHERE job_no_degree_mention = TRUE
        ORDER BY company_id
    )
ORDER BY company_id;
SELECT job_title_short,
    company_id,
    job_location
FROM jan_job_postings
UNION ALL
SELECT job_title_short,
    company_id,
    job_location
FROM feb_job_postings --  Find job postings from the first quarter that have a salary gretater than $70
    --   - Combine job postings tables from the  first quater of 2023 (Jan-Mar)
    --   - Gets job postings with an average yearly salary > $70,000
SELECT job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM (
        SELECT *
        FROM jan_job_postings
        UNION ALL
        SELECT *
        FROM feb_job_postings
        UNION ALL
        SELECT *
        FROM mar_job_postings
    ) AS quarter1_job_postings
WHERE quarter1_job_postings.salary_year_avg > 70000
ORDER BY salary_year_avg DESC