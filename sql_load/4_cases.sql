CREATE TABLE jan_job_postings AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 1 CREATE TABLE feb_job_postings AS -- SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 2 CREATE TABLE mar_job_postings AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(
        MONTH
        FROM job_posted_date
    ) = 3 CASE
        EXPRESSION
        SELECT COUNT(job_id) AS no_of_jobs,
            job_title_short,
            job_location,
            CASE
                WHEN job_location = 'Anywhere' THEN 'Remote'
                WHEN job_location = 'New York, NY' THEN 'Local'
                ELSE 'Onsite'
            END AS job_type
        FROM job_postings_fact
        WHERE job_title_short = 'Data Analyst'
        GROUP BY job_type
        SELECT job_title_short,
            salary_year_avg,
            CASE
                WHEN salary_year_avg < 50000 THEN 'Low'
                WHEN salary_year_avg BETWEEN 50000 AND 100000 THEN 'Medium'
                WHEN salary_year_avg = NULL THEN 'Not Specified'
                ELSE 'High'
            END AS salary_range
        FROM job_postings_fact
        WHERE job_title_short = 'Data Analyst'
        ORDER BY salary_year_avg DESC;
SELECT *
FROM job_postings_fact
LIMIT 10;