# Netflix Movies and TV Shows Data Analysis using PostgreSQL

## Overview
This project involves comprehensive data analysis of Netflix's movies and TV shows using PostgreSQL. The goal is to extract meaningful insights and answer business-critical questions that can inform content strategy, enhance user engagement, and assist in decision-making. SQL queries are utilized to uncover key trends within the dataset.

## Objectives

- Content Distribution Analysis: Examine the balance between movies and TV shows.

- Ratings Analysis: Identify the most frequent ratings for movies and TV shows.

- Content Analysis: Analyze content based on release years, countries, and durations.

- Keyword Categorization: Classify content based on keywords like "kill" and "violence".

## Dataset

The dataset for this project is sourced from Kaggle and contains information about Netflix's catalog of movies and TV shows.

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
The structure of the dataset is represented in the following table:
```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## Business Problems & Solutions
Here are the key business questions and SQL solutions we address in this project:

1. Count the number of Movies vs TV Shows
2. Find the most common rating for movies and TV show subset table for ranked ratings per type
3. List all movies released in a specific year (e.g., 2020)
4. Find the top 5 countries with the most content on Netflix
5. Identify the longest movie
6. Find content added in the last 5 years
7. Find all the movies/TV shows by director 'Steve Brill'!
8. List all TV shows with more than 5 seasons
9. Count the number of content items in each genre
10. Find each year and the average numbers of content release in United States on netflix. return top 5 year with highest avg content release!
11. List all movies that are documentaries
12. Find all content without a director
13. Find how many movies actor 'Adam Sandler' appeared in last 10 years!
14. Find the top 10 actors who have appeared in the highest number of movies produced in United States.
15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
the description field. Label content containing these keywords as 'Bad' and all other 
content as 'Good'. Count how many items fall into each category.

## Key Findings

- Content Distribution: The dataset reveals a higher number of movies compared to TV shows, though TV shows have gained in prominence in recent years.

- Popular Countries: The U.S. is the leading content producer on Netflix, followed by countries like India and the U.K.

- Genre Trends: Documentaries and thrillers are consistently popular across regions.

- Director Insights: Directors like Steve Brill are significant, but many other content creators are emerging.

- Actor Trends: Some actors (e.g., Adam Sandler) appear regularly in Netflix's catalog, especially in movies produced in the U.S.


This analysis provides valuable insights into Netflix’s content, from distribution patterns to content trends across regions. By using PostgreSQL, we can easily explore, manipulate, and extract insights that are critical for shaping future content strategies.
