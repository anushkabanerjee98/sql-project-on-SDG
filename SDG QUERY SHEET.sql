create database sustainable_development_goals;
use sustainable_development_goals;

-- Overall SDG Index --
-- 1. What is the average SDG index score across all countries for each year?
select year, avg(sdg_index_score) AS average_score
from (
    select year, sdg_index_score FROM sdg2018
    union all
    select year, sdg_index_score FROM sdg2019
    union all
	select year, sdg_index_score FROM sdg2020
    union all
	select year, sdg_index_score FROM sdg2021
    union all
	select year, sdg_index_score FROM sdg2022
) AS all_years
GROUP BY year
ORDER BY year;

-- 2. What is the average score for each SDG goal across all years?
WITH AllData AS (
    SELECT * FROM sdg2018
    UNION ALL
    SELECT * FROM sdg2019
    UNION ALL
    SELECT * FROM sdg2020
    UNION ALL
    SELECT * FROM sdg2021
    UNION ALL
    SELECT * FROM sdg2022
)
SELECT 
    'Goal 1' AS sdg_goal,
    AVG(goal_1_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 2' AS sdg_goal,
    AVG(goal_2_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 3' AS sdg_goal,
    AVG(goal_3_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 4' AS sdg_goal,
    AVG(goal_4_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 5' AS sdg_goal,
    AVG(goal_5_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 6' AS sdg_goal,
    AVG(goal_6_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 7' AS sdg_goal,
    AVG(goal_7_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 8' AS sdg_goal,
    AVG(goal_8_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 9' AS sdg_goal,
    AVG(goal_9_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 10' AS sdg_goal,
    AVG(goal_10_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 11' AS sdg_goal,
    AVG(goal_11_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 12' AS sdg_goal,
    AVG(goal_12_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 13' AS sdg_goal,
    AVG(goal_13_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 14' AS sdg_goal,
    AVG(goal_14_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 15' AS sdg_goal,
    AVG(goal_15_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 16' AS sdg_goal,
    AVG(goal_16_score) AS average_score
FROM 
    AllData
UNION ALL
SELECT 
    'Goal 17' AS sdg_goal,
    AVG(goal_17_score) AS average_score
FROM 
    AllData;

-- 3. Which country has consistently performed the best and worst across all SDG goals from 2018 to 2022?

WITH AllData AS (
    SELECT * FROM sdg2018
    UNION ALL
    SELECT * FROM sdg2019
    UNION ALL
    SELECT * FROM sdg2020
    UNION ALL
    SELECT * FROM sdg2021
    UNION ALL
    SELECT * FROM sdg2022
)
SELECT 
    country,
    AVG(sdg_index_score) AS avg_score
FROM 
    AllData
GROUP BY 
    country
ORDER BY 
    avg_score DESC;
    
-- 4. analysis of finland
-- Union all the tables to create a unified dataset

CREATE VIEW all_sdg_data AS
SELECT * FROM sdg2018
UNION ALL
SELECT * FROM sdg2019
UNION ALL
SELECT * FROM sdg2020
UNION ALL
SELECT * FROM sdg2021
UNION ALL
SELECT * FROM sdg2022;
-- Analyze Finland's performance from 2018 to 2022
SELECT *
FROM all_sdg_data
WHERE country = 'Finland' AND year BETWEEN 2018 AND 2022;

-- 5. analysis of south sudan

CREATE VIEW all_sdg_data1 AS
SELECT * FROM sdg2018
UNION ALL
SELECT * FROM sdg2019
UNION ALL
SELECT * FROM sdg2020
UNION ALL
SELECT * FROM sdg2021
UNION ALL
SELECT * FROM sdg2022;
-- Analyze south sudan's performance from 2018 to 2022
SELECT *
FROM all_sdg_data1
WHERE country = 'South Sudan' AND year BETWEEN 2018 AND 2022;

-- Covid Analysis

-- 6. How did the average SDG index score change from pre-COVID (2018-2019) to post-COVID (2020-2022) across all countries?

SELECT AVG(sdg_index_score) AS average_score,
     CASE
        WHEN year BETWEEN 2018 AND 2019 THEN 'Pre-COVID'
        WHEN year BETWEEN 2020 AND 2022 THEN 'Post-COVID'
    END AS covid_phase
FROM
    (
    SELECT year, sdg_index_score FROM sdg2018
    UNION ALL
    SELECT year, sdg_index_score FROM sdg2019
    UNION ALL
    SELECT year, sdg_index_score FROM sdg2020
    UNION ALL
    SELECT year, sdg_index_score FROM sdg2021
    UNION ALL
    SELECT year, sdg_index_score FROM sdg2022
    ) AS combined_data
GROUP BY covid_phase;

-- 7. Which country experienced the most significant decrease in SDG index score from pre-COVID to post-COVID?

SELECT
    pre_covid.country,
    (pre_covid.avg_sdg_index_score - post_covid.avg_sdg_index_score) AS score_decrease
FROM
    (
    SELECT
        country,
        AVG(sdg_index_score) AS avg_sdg_index_score
    FROM
        sdg2018
    GROUP BY
        country
    UNION ALL
    SELECT
        country,
        AVG(sdg_index_score) AS avg_sdg_index_score
    FROM
        sdg2019
    GROUP BY
        country
    ) AS pre_covid
JOIN
    (
    SELECT
        country,
        AVG(sdg_index_score) AS avg_sdg_index_score
    FROM
        sdg2020
    GROUP BY
        country
    UNION ALL
    SELECT
        country,
        AVG(sdg_index_score) AS avg_sdg_index_score
    FROM
        sdg2021
    GROUP BY
        country
    UNION ALL
    SELECT
        country,
        AVG(sdg_index_score) AS avg_sdg_index_score
    FROM
        sdg2022
    GROUP BY
        country
    ) AS post_covid ON pre_covid.country = post_covid.country
ORDER BY
    score_decrease DESC
LIMIT 1;

-- 8. Analyse Myanmar. 

CREATE VIEW all_sdg_data2 AS
SELECT * FROM sdg2018
UNION ALL
SELECT * FROM sdg2019
UNION ALL
SELECT * FROM sdg2020
UNION ALL
SELECT * FROM sdg2021
UNION ALL
SELECT * FROM sdg2022;
-- Analyze myanmar's performance from 2018 to 2022
SELECT *
FROM all_sdg_data2
WHERE country = 'Myanmar' AND year BETWEEN 2018 AND 2022;

-- 9. Decrease in their Goal 1 (No Poverty) score from 2019 to 2021, and by how much?

SELECT country, (SELECT goal_1_score FROM sdg2022 WHERE country = s.country) - (SELECT goal_1_score FROM sdg2019 WHERE country = s.country) AS decrease_in_goal_1_score
FROM sdg2019 s
WHERE country IN (SELECT country FROM sdg2022)
ORDER BY decrease_in_goal_1_score DESC;

-- 10. Overall score of goal 2 in 2020

select country, goal_2_score
from sdg2020 ;

-- 11a. Which country showed the most improvement in Goal 3 (Good Health and Well-being) from 2018 to 2022?

SELECT country, (max_score_2022 - min_score_2018) AS score_increase
FROM (
    SELECT country,
        (SELECT MAX(goal_3_score) FROM sdg2022 WHERE country = sdg.country) AS max_score_2022,
        (SELECT MIN(goal_3_score) FROM sdg2018 WHERE country = sdg.country) AS min_score_2018
    FROM sdg2018 AS sdg
) AS scores
ORDER BY score_increase DESC
LIMIT 1;

-- 11b. Which countries achieved the highest score for Goal 3 (Good Health and Well-being) in 2020?

SELECT country, goal_3_score
FROM sdg2020
ORDER BY goal_3_score DESC
LIMIT 5;

-- 12. What is the overall score for Goal 13 (Climate Action) across all countries in 2020?

SELECT country, SUM(goal_13_score) AS overall_goal_13_score_2020
FROM sdg2020
GROUP BY country;

-- 13. Regional Comparison

WITH CountryClassification AS (
    SELECT
        country,
        year,
        sdg_index_score,
        CASE
            WHEN country IN ('Andorra', 'United Arab Emirates', 'Antigua and Barbuda', 'Australia', 'Austria', 'Belgium', 'Bahrain', 'Bahamas, The', 'Barbados', 'Brunei Darussalam',
                'Canada', 'Switzerland', 'Chile', 'Cayman Islands', 'Germany', 'Denmark', 'Spain', 'Finland', 'Faroe Islands', 'France', 'United Kingdom', 'Gibraltar',
                'Greece', 'Greenland', 'Guam', 'Hong Kong SAR, China', 'Israel', 'Isle of Man', 'Ireland', 'Iceland', 'Italy', 'Japan', 'Korea, Rep.', 'Kuwait',
                'Cayman Islands', 'Liechtenstein', 'Lithuania', 'Luxembourg', 'Macao SAR, China', 'Monaco', 'Marshall Islands', 'Northern Mariana Islands', 'Mauritius',
                'Malta', 'Netherlands', 'Norway', 'Oman', 'Palau', 'Portugal', 'Puerto Rico', 'Qatar', 'Saudi Arabia', 'Singapore', 'San Marino', 'Sint Maarten (Dutch part)',
                'Slovak Republic', 'Slovenia', 'Sweden', 'Seychelles', 'Turks and Caicos Islands', 'Trinidad and Tobago', 'United States', 'Uruguay', 'Virgin Islands (U.S.)') THEN 'Developed'
            ELSE 'Developing'
        END AS country_type
    FROM
        (
            SELECT * FROM sdg2018
            UNION ALL
            SELECT * FROM sdg2019
            UNION ALL
            SELECT * FROM sdg2020
            UNION ALL
            SELECT * FROM sdg2021
            UNION ALL
            SELECT * FROM sdg2022
        ) AS all_years
)
, YearlyAverageScores AS (
    SELECT
        year,
        country_type,
        AVG(sdg_index_score) AS avg_sdg_score
    FROM
        CountryClassification
    GROUP BY
        year,
        country_type
)
, PercentageChange AS (
    SELECT
        a.year,
        a.country_type,
        (a.avg_sdg_score - b.avg_sdg_score) / b.avg_sdg_score * 100 AS percentage_change
    FROM
        YearlyAverageScores a
    JOIN
        YearlyAverageScores b ON a.year = b.year + 1 AND a.country_type = b.country_type
)
SELECT
    year,
    country_type,
    ROUND(percentage_change, 2) AS percentage_change
FROM
    PercentageChange
ORDER BY
    year,
    country_type;

