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

Code powering the map
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

As can be seen in the map, incidents of vandalism are reported all over San Francisco with particular concentrations in the downtown area as well as along major freeways and roads.

Locations of vandalism in 2015
========================================================

![plot of chunk unnamed-chunk-4](map_present-figure/unnamed-chunk-4-1.png) 

As can be seen in this map of vandalism in 2015, the areas of vandalism are roughly the same however, there is a decrease in the amount of vandalism in 2015.

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

