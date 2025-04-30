--Netflix Movies and TV Shows Database
DROP TABLE IF EXISTS netflix;

CREATE TABLE netflix
(
	show_id		VARCHAR(6),
	type		VARCHAR(10),
	title		VARCHAR(150),
	director	VARCHAR(208),
	casts		VARCHAR(1000),
	country		VARCHAR(150),
	date_added	VARCHAR(50),
	release_year	INT,
	rating		VARCHAR(10),
	duration	VARCHAR(15),
	listed_in	VARCHAR(100),
	description	VARCHAR(250)
);

SELECT * FROM netflix;



-- 15 Business Problems & Solutions

-- 1. Count the number of Movies vs TV Shows

SELECT
	type,
	COUNT(*) as total_count
FROM netflix
GROUP BY type;


-- 2. Find the most common rating for movies and TV shows
-- subset table for ranked ratings per type
WITH ranked_rating AS (
	SELECT 
		type,
		rating,
		COUNT(*) as total_count,
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking 
	FROM netflix
	GROUP BY type, rating
)
-- main query
SELECT 
	type,
	rating
FROM ranked_rating
WHERE ranking = 1;


-- 3. List all movies released in a specific year (e.g., 2020)

SELECT
	*
FROM netflix 
WHERE 
	type = 'Movie'
	AND 
	release_year = 2020;


-- 4. Find the top 5 countries with the most content on Netflix

SELECT 
	UNNEST(STRING_TO_ARRAY(country, ',')) as new_country,
	COUNT(*) as total_content
FROM netflix
GROUP BY new_country
ORDER BY total_content DESC
LIMIT 5;


-- 5. Identify the longest movie

SELECT
	*
FROM netflix
WHERE 
	type = 'Movie'
	AND
	duration = (SELECT MAX(duration) FROM netflix);


-- 6. Find content added in the last 5 years

SELECT 
	*
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= (CURRENT_DATE - INTERVAL '5 years');


-- 7. Find all the movies/TV shows by director 'Steve Brill'!

SELECT
	*
FROM netflix
WHERE director ILIKE '%Steve Brill%';


-- 8. List all TV shows with more than 5 seasons

SELECT 
	*
FROM netflix
WHERE 
	type = 'TV Show'
	AND
	SPLIT_PART(duration, ' ', 1)::numeric > 5;


-- 9. Count the number of content items in each genre

SELECT 
	UNNEST(STRING_TO_ARRAY(listed_in, ',')) as genre,
	COUNT(*) as total_content
FROM netflix
GROUP BY genre;


-- 10.Find each year and the average numbers of content release in United States on netflix. 
-- return top 5 year with highest avg content release!

SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) as year,
	COUNT(*) as yearly_content,
	ROUND(COUNT(*)::numeric / (SELECT COUNT(*) FROM netflix WHERE country = 'United States')::numeric * 100, 2) as average_content_per_year 
FROM netflix
WHERE country = 'United States'
GROUP BY year
ORDER BY average_content_per_year DESC;


-- 11. List all movies that are documentaries

SELECT 
	*
FROM netflix
WHERE 
	type = 'Movie'
	AND
	listed_in ILIKE '%Documentaries%';


-- 12. Find all content without a director

SELECT 
	*
FROM netflix
WHERE director IS NULL;


-- 13. Find how many movies actor 'Adam Sandler' appeared in last 10 years!

SELECT 
	*
FROM netflix
WHERE 
	casts ILIKE '%Adam Sandler%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10;


-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in United States.

SELECT 
	UNNEST(STRING_TO_ARRAY(casts, ',')) as actors,
	COUNT(*) as total_appearance
FROM netflix
WHERE 
	type = 'Movie'
	AND 
	country ILIKE '%United States%'
GROUP BY actors
ORDER BY total_appearance DESC
LIMIT 10;


-- 15.
-- Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.

WITH categorized_content AS(
	SELECT
		*,
		CASE 
			WHEN 	
				description ILIKE '%kill%'
				OR
				description ILIKE '%violence%'
			THEN 'Bad Content'
			ELSE 'Good Content'
		END AS category
	FROM netflix
)

SELECT 
	category,
	COUNT(*)
FROM categorized_content
GROUP BY category;

