
 
# Ironhack mid bootcamp project
## SQL questions - regression
 
### 1. Create a database called house_price_regression.

`CREATE DATABASE house_price_regression;`

#### Explicitly select house_price_regression database for use 

```
use house_price_regression;
SET GLOBAL local_infile = 1;
```

### 2. Create a table `house_price_data` with the same columns as given in the csv file. Please make sure you use the correct data types for the columns. 

Done, created a copy of the .csv file with appropriate headings

```
CREATE TABLE house_price_data (
    id INT NOT NULL AUTO_INCREMENT,
    bathrooms INTEGER,
    bedrooms INTEGER,
    sqft_living INTEGER,
    sqft_Lot INTEGER,  
    floors INTEGER,
    waterfront INTEGER,
    view INTEGER,
    cond INTEGER,
    grade INTEGER,
    sqft_above INTEGER,
    yr_built INTEGER,
    sqft_basement INTEGER,
    yr_renovated INTEGER,
    zipcode INTEGER,
    latitude INTEGER,
    longitud INTEGER,
    sqft_living15 INTEGER,
    sqft_lot15 INTEGER,
    price INTEGER,
    PRIMARY KEY (id));
```
To load .csv file:

```
LOAD DATA INFILE '/home/export_file.csv'
INTO TABLE house_price_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '/n'
IGNORE 1 ROWS;
```

## 4. Select all the data from table house_price_data to check if the data was imported correctly
SELECT * FROM house_price_data LIMIT 5;


## 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.

```
ALTER TABLE house_price_data
DROP COLUMN date;
```
View the change

`SELECT * FROM house_price_data LIMIT 5;` #view the change

## 6. Use sql query to find how many rows of data you have.
SELECT COUNT(*) as 'rows' FROM house_price_data;
#Answer:21596

## Q7. Finding the unique values in some of the categorical columns: 

## What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms FROM house_price_data;
#Ans: 1,2,3,4,5,6,7,8,9,10,11,33

## What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms FROM house_price_data;
#Answer: Range from 1 to 7.75

## What are the unique values in the column floors?
SELECT DISTINCT floors FROM house_price_data;
#Answer: Range from 1 to 3.5

## What are the unique values in the column condition?
SELECT DISTINCT bedrooms FROM house_price_data;
#Answer: Done

## What are the unique values in the column grade?
SELECT DISTINCT grade FROM house_price_data;
#Answer: There are 10 unique values ranging from 3 to 13

## Q8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT id FROM house_price_data ORDER BY price DESC LIMIT 10;
#Answer: starts id 6762700020 to 3835500195

## Q9. What is the average price of all the properties in your data?
SELECT AVG(price) AS 'AveragePrice' FROM house_price_data;
#Answer: 540311 dollars

## Q10. What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
SELECT bedrooms, ROUND (AVG(price)) AS 'average_house_price'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
#Answer: Av 1 bed house: 318239 dollars, Av 3 bed house = 466301 dollars, Av 10 bed house: 820000

## What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
SELECT bedrooms, ROUND(AVG(sqft_living)) AS 'av_living_area_in_sqft'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
#Answer: Av 1 bed: 888 sq ft, Av 3 bed: 1806 sq ft, Av 10 bed: 3707 sq ft

## What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
SELECT waterfront, ROUND (AVG(price)) AS 'av_price_on_waterfront'
FROM house_price_data
GROUP BY waterfront
ORDER BY 2 DESC;
#Ans: Av price of house on waterfront: 1662524 dollars, Av price of house not on waterfront: 531777 dollars

## Q11. One of the customers is only interested in the following houses:
'''Number of bedrooms either 3 or 4
Bathrooms more than 3
One Floor
No waterfront
Condition should be 3 at least
Grade should be 5 at least
Price less than 300000
For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?''';

SELECT * 
FROM house_price_data
WHERE bedrooms IN (3,4)
AND bathrooms > 3
AND floors = 1
AND waterfront = 0
AND house_price_data.condition >= 3
AND grade >= 5
AND price < 300000;

#Answer: no available properties, the client would have to increase their price to 345100 
#or modify requirements the most options is through reducing the required number of bathrooms to greter than two.
