ALTER TABLE house_price_data
DROP COLUMN date;

SELECT * FROM house_price_data;

SELECT * FROM house_price_data LIMIT 10;

SELECT COUNT(*) as 'Number of Records' FROM house_price_data;

SELECT DISTINCT bedrooms FROM house_price_data;

SELECT DISTINCT bathrooms FROM house_price_data;

SELECT DISTINCT floors FROM house_price_data;

SELECT DISTINCT house_price_data.condition FROM house_price_data;

SELECT DISTINCT grade FROM house_price_data;

SELECT id FROM house_price_data ORDER BY price DESC LIMIT 10;

SELECT ROUND(AVG(price),2) AS 'AveragePrice' FROM house_price_data;

SELECT bedrooms, ROUND(AVG(price),2) AS 'Average of the prices'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;

SELECT bedrooms, ROUND(AVG(sqft_living),2) AS 'Average of the sqft_living'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;


SELECT waterfront, ROUND(AVG(price),2) AS 'Average Price'
FROM house_price_data
GROUP BY waterfront
ORDER BY 2 DESC;


SELECT house_price_data.condition, COUNT(DISTINCT grade)
FROM house_price_data
GROUP BY 1;

SELECT COUNT(DISTINCT house_price_data.condition), grade
FROM house_price_data
GROUP BY 2;

SELECT DISTINCT house_price_data.condition, grade
FROM house_price_data;


SELECT * 
FROM house_price_data
WHERE bedrooms IN (3,4)
AND bathrooms > 3
AND floors = 1
AND waterfront = 0
AND house_price_data.condition >= 3
AND grade >= 5
AND price < 300000;

SELECT ROUND(AVG(price),2) FROM house_price_data;
SELECT AVG(price)*2 FROM house_price_data;

SELECT * FROM house_price_data
HAVING price > (SELECT AVG(price)*2 FROM house_price_data);


CREATE OR REPLACE VIEW property_twice_avg_price AS
SELECT * FROM house_price_data
HAVING price > (SELECT AVG(price)*2 FROM house_price_data);



SELECT bedrooms, AVG(price) FROM
(SELECT  * FROM house_price_data
HAVING bedrooms IN (3,4)) as sub1
GROUP BY bedrooms;

SELECT bedrooms, ROUND(AVG(price),2) FROM
(SELECT  * FROM house_price_data
HAVING bedrooms IN (3,4)) as sub1
GROUP BY bedrooms;

SELECT ROUND(MAX(avg_price)-MIN(avg_price),2) as 'Difference Between Avg Price of 3/4 Bedroom Properties' FROM
(SELECT  bedrooms, AVG(price) as avg_price FROM house_price_data
WHERE bedrooms IN (3,4)
GROUP BY bedrooms) as sub1;


SELECT COUNT(DISTINCT zipcode) FROM house_price_data;

SELECT * FROM house_price_data
HAVING yr_renovated > 0;


SELECT house_price_data.condition, AVG(grade)
FROM house_price_data
GROUP BY 1;


SELECT * FROM house_price_data
ORDER BY price DESC
LIMIT 11;


CREATE OR REPLACE VIEW property_by_price_desc AS
SELECT * , RANK () OVER ( ORDER BY price DESC) price_rank FROM house_price_data;

SELECT * FROM property_by_price_desc
HAVING price_rank = 11;
