# SQL questions and Solutions - regression


### 1. Create a database called house_price_regression. **COMPLETE**

### 2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.  **COMPLETE**

### 3. Import the data from the csv file into the table. Before you import the data into the empty table, make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:

SHOW VARIABLES LIKE 'local_infile'; -- This query would show you the status of the variable ‘local_infile’. If it is off, use the next command, otherwise you should be good to go
SET GLOBAL local_infile = 1;

**COMPLETE**


### 4. Select all the data from table house_price_data to check if the data was imported correctly. **COMPLETE**
```
SELECT * FROM house_price_regression.house_price_data;
```

### 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10. **COMPLETE**

```
ALTER TABLE house_price_data
DROP COLUMN date;

SELECT * FROM house_price_data LIMIT 10;
```

### 6. Use sql query to find how many rows of data you have. **COMPLETE**

*There were 21,597 records returned*

```
SELECT COUNT(*) as 'Number of Records' FROM house_price_data;
```

### 7. Now we will try to find the unique values in some of the categorical columns:

-What are the unique values in the column bedrooms? **COMPLETE**
    
*There are 12 unique values in the bedrooms column, these are 1,2,3,4,5,6,7,8,9,10,11,33. Possible bad data with the 33 roomed property*
    
``` '*.sql'
SELECT DISTINCT bedrooms FROM house_price_data;
```
       
-What are the unique values in the column bathrooms? **COMPLETE**
      
*There are 29 distinct values in the bathrooms column, ranging from 0.5 - 8.*
    
```
SELECT DISTINCT bathrooms FROM house_price_data; 
```
    
-What are the unique values in the column floors? **COMPLETE**
   
*There are 4 distinct values in the floors column. 1,2,3 and 4*
    
```
SELECT DISTINCT floors FROM house_price_data;
```
    
-What are the unique values in the column condition? **COMPLETE**
   
*There are 5 distinct values in the condition column, 1,2,3,4 and 5. From the information about the dataset it states that these vulues relate to the overall condition of the property. "1 indicates worn out property and 5 excellent."*
    
```
SELECT DISTINCT house_price_data.condition FROM house_price_data;
```

-What are the unique values in the column grade? **COMPLETE**

*There are 13 unique values in the grade column. Integers from 3 - 13. From the documentation: "Overall grade given to the housing unit, based on King County grading system. 1 poor ,13 excellent."*
    
```
SELECT DISTINCT grade FROM house_price_data;
```
    
### 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data. **COMPLETE**

*The largest sales value in the database is the property with id:6762700020*

```
SELECT id FROM house_price_data ORDER BY price DESC LIMIT 10;
```

### 9. What is the average price of all the properties in your data? **COMPLETE**

*The average property value in the database is $540,296.57.*

```
SELECT ROUND(AVG(price),2) AS 'AveragePrice' FROM house_price_data;
```


### 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

-What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column. **COMPLETE**

```
SELECT bedrooms, ROUND(AVG(price),2) AS 'Average of the prices'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
```
    
-What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column. **COMPLETE**

```
SELECT bedrooms, ROUND(AVG(sqft_living),2) AS 'Average of the sqft_living'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
```
    
-What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column. **COMPLETE**

```
SELECT waterfront, ROUND(AVG(price),2) AS 'Average Price'
FROM house_price_data
GROUP BY waterfront
ORDER BY 2 DESC;
```
    
-Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. Visually check if there is a positive correlation or negative correlation or no correlation between the variables. **COMPLETE**



```
SELECT house_price_data.condition, COUNT(DISTINCT grade)
FROM house_price_data
GROUP BY 1;

SELECT COUNT(DISTINCT house_price_data.condition), grade
FROM house_price_data
GROUP BY 2;

SELECT house_price_data.condition, AVG(grade)
FROM house_price_data
GROUP BY 1;
```

### 11. One of the customers is only interested in the following houses:     **COMPLETE**

    -Number of bedrooms either 3 or 4
    
    -Bathrooms more than 3
    
    -One Floor
    
    -No waterfront
    
    -Condition should be 3 at least
    
    -Grade should be 5 at least
    
    -Price less than 300000
    
For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

*There are no records returned for this function, as there are no properties under 300000 that meet the other criteria.*

```
SELECT * 
FROM house_price_data
WHERE bedrooms IN (3,4)
AND bathrooms > 3
AND floors = 1
AND waterfront = 0
AND house_price_data.condition >= 3
AND grade >= 5
AND price < 300000;
```

### 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.   **COMPLETE**

*The average house price is '$540296.57'. Selecting property with twice the average value returns 1246 records.*

```
SELECT * FROM house_price_data
HAVING price > (SELECT AVG(price)*2 FROM house_price_data);
```

### 13. Since this is something that the senior management is regularly interested in, create a view of the same query. **COMPLETE**

```
CREATE OR REPLACE VIEW property_twice_avg_price AS
SELECT * FROM house_price_data
HAVING price > (SELECT AVG(price)*2 FROM house_price_data);
```

### 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?   **COMPLETE**

*The difference between the average value of 3 and 4 bedroom properties is $169288.09.*

```
SELECT ROUND(MAX(avg_price)-MIN(avg_price),2) as 'Difference Between Avg Price of 3/4 Bedroom Properties' FROM
(SELECT  bedrooms, AVG(price) as avg_price FROM house_price_data
WHERE bedrooms IN (3,4)
GROUP BY bedrooms) as sub1;
```

### 15. What are the different locations where properties are available in your database? (distinct zip codes)  **COMPLETE**

*There are 70 unique zipcodes listed in the database.*

```
SELECT COUNT(DISTINCT zipcode) FROM house_price_data;

SELECT DISTINCT zipcode FROM house_price_data;
```

### 16. Show the list of all the properties that were renovated.    **COMPLETE**

*There are 914 properties in the database that have been renovated.*

```
SELECT * FROM house_price_data
HAVING yr_renovated > 0;
```

### 17. Provide the details of the property that is the 11th most expensive property in your database.  **COMPLETE**

```
CREATE OR REPLACE VIEW property_by_price_desc AS
SELECT * , RANK () OVER ( ORDER BY price DESC) price_rank FROM house_price_data;

SELECT * FROM property_by_price_desc
HAVING price_rank = 11;
```

