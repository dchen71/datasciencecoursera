San Francisco Crime Map
========================================================
author: dchen71
date: 10/17/2015

About
========================================================

This app is based on data from the Kaggle competition which uses crime data from San Francisco and attempts to classify the types of crimes that occurs in the city. The data is subsetted to contain several crime types. The app allows the user to visualize the location of crimes based on year and type of crime in San Francisco. This map is useful for several reasons:
- Visually determine hotspots of crimes in the city
- View the change in locations of crime over time
- View overlap of crimes in areas of the city

Code powering the mapping of crimes in San Francisco
========================================================




```r
#Initializes and setups data and maps
data = read.csv("subset.csv")
data$Dates = year(data$Dates)
map = get_map(location="sanfrancisco",
              zoom=12,source="osm")

#Function used to read in dataframe, type of crime, and year        
map_crime = function(crime_df, crime, year) {
    filtered = filter(filter(crime_df, Category %in% crime), Dates %in% year)
    plot = ggmap(map, extent='device') + 
        geom_point(data = filtered, aes(x = X, y = Y, color=Category))
    return(plot)
}
```

Location of vandalism in 2003
========================================================

![plot of chunk unnamed-chunk-3](map_present-figure/unnamed-chunk-3-1.png) 

***

As can be seen in the map, incidents of vandalism are reported all over San Francisco with particular concentrations in the downtown area as well as along major freeways and roads.

Locations of vandalism in 2015
========================================================

![plot of chunk unnamed-chunk-4](map_present-figure/unnamed-chunk-4-1.png) 

***

As can be seen in this map of vandalism in 2015, the areas of vandalism are roughly the same however, there is a decrease in the amount of vandalism in 2015.

Location of warrants and vandalism in 2014
========================================================

![plot of chunk unnamed-chunk-5](map_present-figure/unnamed-chunk-5-1.png) 

***

An overlaid map showing the location for warrants and vandalism in 2014. The map shows a concentration of warrants and vandalism downtown. The vandalism is still spread out across major roads and concentrations of warrant arrests can be seen in seedier areas of the city such as Hunter's point.
