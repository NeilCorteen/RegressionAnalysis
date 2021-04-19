# Tableau - Regression

Tableau Questions:

1. Convert the necessary measures to dimensions (the variables that are categorical in nature)
2. Plot the distribution of `price` vs. _number of bedrooms_, `price` vs. _number of bathrooms_, `price` vs. _condition_, `price` vs. _floors_, `price` vs. _grade_, `price` vs. _view_, and `price` vs. _waterfront_.

![Alt text](PriceVsFeatures.png?raw=true "Price vs Feature")


3. Draw scatter plots for `price` vs. `sqft_above`, `price` vs. `sqft_basement`, `price` vs. `living15`, `price` vs. `sqft_lot15`.

![Alt text](ScatterPlots.png?raw=true "Scatter Plots")

4. Identify using tableau which state data is presented to you. Use latitude (generated), longitude (generated), and zip code for this. Color code the zip codes based on the prices to see which areas are more expensive than the others.

![Alt text](MapPlotting.png?raw=true "Map Plotting")

5. Create a plot to check which are the more selling properties based on the number of bedrooms in the house. Create a plot of bedrooms vs. count of data points.
6. We want to see the trend in price of houses based on the year built. From our previous plot, we know that most of our customers are interested in three and four bedroom houses. Create a filter on bedroom feature to select those properties and compare the trends in prices using line charts.

![Alt text](PriceVsFeatures.png?raw=true "Price vs Feature")

7. Create calculated field `year_built_bins` for the column `year_built` by creating buckets as follows, for houses built between 1900 and 2000 - category A, for houses built between 2000 and 2010 - category B, and for houses built after 2000 - category C. Use `IF-ELSE` statement to create the bins/buckets. Compare the prices of houses for the three categories.

![Alt text](FurtherExploration.png?raw=true "Further Exploration")

8. Now we want to deep dive into the categories we created in the last question. Let’s see how many properties are in each of the categories. Indicate the numbers as labels on each of the three categories.
9. Deep dive in category A, category B and category C using filters. Identify different characteristics/trends for each of the three categories.
10. Create a visually appealing dashboard to represent the information.

![Alt text](MainDashboard-Tableau.png?raw=true "Main Dashboard")


