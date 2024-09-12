/*
Question: What are the most optimal skills to learn (aka it's high demand and a high-paying skill)?
    - Identify skills in high demand and associated with high average salaries for Data Analyst roles
    - Concentrates on remote positions with specified salaries
    - Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
        offering strategic insights for career development in data analysis.
*/

SELECT 
    sd.skill_id,
    sd.skills,
    COUNT(sjd.job_id) AS demand_count,
    ROUND(AVG(jpf.salary_year_avg)) AS avg_salary
FROM    
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd ON sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY
    sd.skill_id
HAVING
    COUNT(sjd.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
