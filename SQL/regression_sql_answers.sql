#Ironhack mid bootcamp project
#SQL questions - regression

use house_price_regression;
 SET GLOBAL local_infile = 1;

#Q1. Create a database called house_price_regression.
#Done

#Q2. Create a table house_price_data with the same columns as given in the csv file. 

#Q3. Import the data from the csv file into the table. 
#Done, created a copy of the .csv file with appropriate headings

#Q4. Select all the data from table house_price_data to check if the data was imported correctly
SELECT * FROM house_price_data LIMIT 5;

#Q5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE house_price_data
DROP COLUMN date;

SELECT * FROM house_price_data LIMIT 5; #view the change

#Q6. Use sql query to find how many rows of data you have.
SELECT COUNT(*) as 'rows' FROM house_price_data;
#Answer:21596

#Q7. Finding the unique values in some of the categorical columns:

# What are the unique values in the column bedrooms?
SELECT DISTINCT bedrooms FROM house_price_data;
#Ans: 1,2,3,4,5,6,7,8,9,10,11,33

# What are the unique values in the column bathrooms?
SELECT DISTINCT bathrooms FROM house_price_data;
#Answer: Range from 1 to 7.75

# What are the unique values in the column floors?
SELECT DISTINCT floors FROM house_price_data;
#Answer: Range from 1 to 3.5

# What are the unique values in the column condition?
SELECT DISTINCT bedrooms FROM house_price_data;

# What are the unique values in the column grade?
SELECT DISTINCT grade FROM house_price_data;
#Answer: There are 10 unique values ranging from 3 to 13

# Q8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.
SELECT id FROM house_price_data ORDER BY price DESC LIMIT 10;
#Answer: starts id 6762700020 to 3835500195

#Q9. What is the average price of all the properties in your data?
SELECT AVG(price) AS 'AveragePrice' FROM house_price_data;
#Answer: 540311 dollars

#Q10. Using simple group by to check the properties of some of the categorical variables in our data
#What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. Use an alias to change the name of the second column.
SELECT bedrooms, ROUND (AVG(price)) AS 'average_house_price'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
#Answer: Av 1 bed house: 318239 dollars, Av 3 bed house = 466301 dollars, Av 10 bed house: 820000

#What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. Use an alias to change the name of the second column.
SELECT bedrooms, ROUND(AVG(sqft_living)) AS 'av_living_area_in_sqft'
FROM house_price_data
GROUP BY bedrooms
ORDER BY 2 DESC;
# Answer: Av 1 bed: 888 sq ft, Av 3 bed: 1806 sq ft, Av 10 bed: 3707 sq ft

#What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. Use an alias to change the name of the second column.
SELECT waterfront, ROUND (AVG(price)) AS 'av_price_on_waterfront'
FROM house_price_data
GROUP BY waterfront
ORDER BY 2 DESC;
#Ans: Av price of house on waterfront: 1662524 dollars, Av price of house not on waterfront: 531777 dollars

#Q11. One of the customers is only interested in the following houses:
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

????
#Q12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT * FROM house_price_data
HAVING price > (SELECT AVG(price)*2 FROM house_price_data);

????
#Q13. Since this is something that the senior management is regularly interested in, create a view of the same query.

????
#Q14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?


????
#Q15. What are the different locations where properties are available in your database? (distinct zip codes)
SELECT COUNT(DISTINCT zipcode) FROM house_price_data;

????
#Q16. Show the list of all the properties that were renovated.

????
#17. Provide the details of the property that is the 11th most expensive property in your database.
SELECT * FROM property_by_price_desc
HAVING price_rank = 11;
