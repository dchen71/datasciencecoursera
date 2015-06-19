project2 = function(){
    #Read and initialize library and data
    library(ggplot2)
    library(grid)
    library(gridExtra)
    library('dplyr')
    library('data.table')
    
    setwd("work/coursera/Data Science/Reproducible Research/Project 2")

    #Cache and reads data if available
    data = read.csv('repdata_data_StormData.csv', stringsAsFactors=FALSE)    
    #Subsets all relevant data for usage
    p2 <<- data.frame(data$STATE,data$EVTYPE,data$INJURIES,data$FATALITIES, data$PROPDMG,data$CROPDMG)
    names(p2) = c('STATE', 'EVTYPE', 'INJURIES', 'FATALITIES', 'PROPDMG', 'CROPDMG')
    p2 = data.table(p2)
    


    #Begin cleaning up the data
    states = c('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY')
    test = filter(p2, STATE == states) #filters out other states although leaves factors which is unwanted
    test2 = grep('summary',test$EVTYPE,ignore.case=TRUE) #done here to filter out the summary in evtype
    test = test[!test2] #need to remove factors again here
       
    #Standarizes wind conditions into a single variable
    test$EVTYPE = gsub('HIGH WIND', 'WIND', test$EVTYPE) #Standarize high wind to wind
    test$EVTYPE = gsub('HIGH WINDSS', 'WIND', test$EVTYPE) #Standarize highwindss to wind
    test$EVTYPE = gsub('WINDS', 'WIND', test$EVTYPE) #Standarize winds to wind
    test$EVTYPE = gsub('WIND 73', 'WIND', test$EVTYPE) #Standarize wind 72 to wind
    test$EVTYPE = gsub('TSTM WIND', 'WIND', test$EVTYPE)    
    test$EVTYPE = gsub('WIND DAMAGE', 'WIND', test$EVTYPE)
    test$EVTYPE = gsub('DRY MICROBURST WIND', 'WIND', test$EVTYPE)
    test$EVTYPE = gsub('WIND/HAIL', 'WIND', test$EVTYPE)
    test$EVTYPE = gsub('STRONG WIND', 'WIND', test$EVTYPE)
    test$EVTYPE = gsub('EXTREME WINDCHILL', 'WIND', test$EVTYPE)
    
    #Standarizes thunderstorm elements into one variable
    test$EVTYPE = gsub('THUNDERSTORMS WIND', 'THUNDERSTORM WINDS', test$EVTYPE)
    test$EVTYPE = gsub('THUNDERSTORM WINDS', 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub("THUNDERSTORM WIND HAIL", 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub("THUNDERSTORM WIND", 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub("THUNDERSTORM WIND/LIGHTNING" , 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub("THUNDERSTORM/LIGHTNING", 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub("THUNDERSTORMLIGHTNING", 'THUNDERSTORM', test$EVTYPE)  

    
    #Standarizes astronomical tides into a single varaible
    test$EVTYPE = gsub("ASTRONOMICAL HIGH TIDE", 'ASTRONOMICAL TIDE LEVELS', test$EVTYPE)
    test$EVTYPE = gsub("ASTRONOMICAL LOW TIDE", 'ASTRONOMICAL TIDE LEVELS', test$EVTYPE)
    
    #Standarizes coastal flooding
    test$EVTYPE = gsub('Coastal Flood', 'COASTAL FLOODING', test$EVTYPE)
    test$EVTYPE = gsub('COASTAL FLOODINGing', 'COASTAL FLOODING', test$EVTYPE)
    test$EVTYPE = gsub('COASTAL FLOOD', 'COASTAL FLOODING', test$EVTYPE)
    test$EVTYPE = gsub("COASTAL FLOODINGING", 'COASTAL FLOODING',test$EVTYPE)
    test$EVTYPE = gsub('CSTL FLOODING/EROSION', 'COASTAL FLOODING', test$EVTYPE)
    
    #Standarizes winter weather conditions    
    test$EVTYPE = gsub('WINTER STORM', 'WINTER WEATHER', test$EVTYPE)
    test$EVTYPE = gsub('WINTER WEATHER/MIX', 'WINTER WEATHER', test$EVTYPE)
    test$EVTYPE = gsub('WINTRY MIX', 'WINTER WEATHER', test$EVTYPE)
    
    #Standarizes wild/forest fires
    test$EVTYPE = gsub('WILDFIRES', 'WILD/FOREST FIRE', test$EVTYPE)
    test$EVTYPE = gsub('WILDFIRE', 'WILD/FOREST FIRE', test$EVTYPE)
    test$EVTYPE = gsub('WILD FIRES', 'WILD/FOREST FIRE', test$EVTYPE)
    
    #Standarizes urban flooding
    test$EVTYPE = gsub('URBAN FLOODING', 'URBAN FLOOD', test$EVTYPE)
    test$EVTYPE = gsub('URBAN/SML STREAM FLD', 'URBAN FLOOD', test$EVTYPE)
    test$EVTYPE = gsub('URBAN FLOOD', 'URBAN FLOODING', test$EVTYPE)
    
    #Standarizes unseasonable weather
    test$EVTYPE = gsub('UNSEASONABLY WARM', 'UNSEASONABLE TEMP', test$EVTYPE)
    test$EVTYPE = gsub('UNSEASONABLY WET', 'UNSEASONABLE TEMP', test$EVTYPE)
    
    #Standarizes snow
    test$EVTYPE = gsub('SNOW AND ICE', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('SNOW/BLOWING SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('LIGHT SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('Light Snow', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('HEAVY SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('HEAVY SNOW/SQUALLS', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('HEAVY WET SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('HEAVY LAKE SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('LAKE-EFFECT SNOW', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('BLOWING SNOW- EXTREME WIND CHI', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('MODERATE SNOWFALL', 'SNOW', test$EVTYPE)
    test$EVTYPE = gsub('SNOW/SQUALLS', 'SNOW', test$EVTYPE)
    
    #Standardizes dry conditions
    test$EVTYPE = gsub('DRY MICROBURST', 'DRY CONDITIONS', test$EVTYPE)
    test$EVTYPE = gsub('DROUGHT', 'DRY CONDITIONS', test$EVTYPE)
    
    #Standarize cold temperatures
    test$EVTYPE = gsub('Cold', 'COLD TEMPERATURES', test$EVTYPE)
    test$EVTYPE = gsub('COLD/WIND CHILL', 'COLD TEMPERATURES', test$EVTYPE)
    test$EVTYPE = gsub('EXTREME COLD TEMPERATURES', 'COLD TEMPERATURES', test$EVTYPE)
    test$EVTYPE = gsub('EXTREME COLD', 'COLD TEMPERATURES', test$EVTYPE)    
    
    #Standarize flood
    test$EVTYPE[test$EVTYPE == 'FLOOD'] = 'FLOOD/FLASH FLOOD'
    test$EVTYPE = gsub('FLASH FLOODING', 'FLOOD/FLASH FLOOD', test$EVTYPE)
    test$EVTYPE[test$EVTYPE == 'FLASH FLOOD'] = 'FLOOD/FLASH FLOOD'
    
    #Standardize freezing conditions
    test$EVTYPE = gsub('FREEZE', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FREEZING DRIZZLE', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FREEZING FOG', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FREEZING RAIN', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FREEZING RAIN AND SLEET', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FROST/FREEZE', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FREEZING CONDITIONS AND SLEET', 'FREEZING CONDITIONS', test$EVTYPE) 
    test$EVTYPE = gsub('FROST/FREEZING CONDITIONS', 'FREEZING CONDITIONS', test$EVTYPE) 
    
    #Standarizes hail
    test$EVTYPE[test$EVTYPE == 'HAIL 75'] = 'HAIL'
    test$EVTYPE[test$EVTYPE == 'NON SEVERE HAIL'] = 'HAIL'
    
    #Standardize surf
    test$EVTYPE[test$EVTYPE == 'HEAVY SURF/HIGH SURF'] = 'HEAVY SURF'
    test$EVTYPE[test$EVTYPE == 'HIGH SURF'] = 'HEAVY SURF'
    
    #Standard rain
    test$EVTYPE[test$EVTYPE == 'Heavy rain'] = 'HEAVY RAIN'
    test$EVTYPE[test$EVTYPE == 'EXCESSIVE RAINFALL'] = 'HEAVY RAIN'
    
    #Standarize heat
    test$EVTYPE[test$EVTYPE == 'EXCESSIVE HEAT'] = 'HIGH HEAT'
    test$EVTYPE[test$EVTYPE == 'EXTREME HEAT'] = 'HIGH HEAT'
    test$EVTYPE[test$EVTYPE == 'HEAT'] = 'HIGH HEAT'
    test$EVTYPE[test$EVTYPE == 'RECORD HEAT'] = 'HIGH HEAT'
    test$EVTYPE[test$EVTYPE == 'RECORD WARMTH'] = 'HIGH HEAT'
    test$EVTYPE[test$EVTYPE == 'Temperature record'] = 'HIGH HEAT'
    
    
    #Standarizes variables
    test$EVTYPE = gsub('TORNADO F0', 'TORNADO', test$EVTYPE)      
    test$EVTYPE = gsub('FUNNEL CLOUDS', 'FUNNEL CLOUD', test$EVTYPE)
    test$EVTYPE = gsub(' LIGHTNING', 'LIGHTNING', test$EVTYPE) #Fix the spaced lightning
    test$EVTYPE = gsub('WATER SPOUT', 'WATERSPOUT', test$EVTYPE)
    test$EVTYPE = gsub("THUNDERSTORMLIGHTNING", 'THUNDERSTORM', test$EVTYPE)  
    test$EVTYPE = gsub('TROPICAL DEPRESSION', 'TROPICAL STORM', test$EVTYPE)
    test$EVTYPE = gsub('STORM SURGE/TIDE', 'STORM SURGE', test$EVTYPE)
    test$EVTYPE = gsub('Mudslide', 'MUD SLIDES', test$EVTYPE)
    test$EVTYPE[test$EVTYPE == 'RIP CURRENT'] = 'RIP CURRENTS'
    
    #Creates a new data frame containing the compiled sum of injury/fatality/dmg
    Evtype = unique(test$EVTYPE)
    Injury = numeric()
    Fatality = numeric()
    Cropdmg = numeric()
    Propdmg = numeric()
    for(i in 1:42){
        Injury[i] = sum(test$INJURIES[test$EVTYPE == Evtype[i]])
        Fatality[i] = sum(test$FATALITIES[test$EVTYPE == Evtype[i]])
        Cropdmg[i] = sum(test$CROPDMG[test$EVTYPE == Evtype[i]])
        Propdmg[i] = sum(test$PROPDMG[test$EVTYPE == Evtype[i]])
    }
    
    results = data.frame(Evtype, Injury, Fatality, Propdmg, Cropdmg)

    #Subsets out the top 6 values for injuries, fatalities, propdmg, and cropdmg
    highInjury = sort.list(results$Injury, decreasing=TRUE)
    InEV = character()
    Injuries = numeric()
    
    highFatal = sort.list(results$Fatality, decreasing=TRUE)
    FaEV = character()
    Fatalities = numeric()    
    
    highProp = sort.list(results$Propdmg, decreasing=TRUE)
    PrEV = character()
    PropDMG = numeric()
    
    highCrop = sort.list(results$Cropdmg, decreasing=TRUE)
    CrEV = character()
    CropDMG = numeric()
    
    for(i in 1:6){
        InEV[i] = as.character(results$Evtype[highInjury[i]])
        FaEV[i] = as.character(results$Evtype[highFatal[i]])
        PrEV[i] = as.character(results$Evtype[highProp[i]])
        CrEV[i] = as.character(results$Evtype[highCrop[i]])
    
        Injuries[i] = results$Injury[highInjury[i]]
        Fatalities[i] = results$Fatality[highFatal[i]]
        PropDMG[i] = results$Propdmg[highProp[i]]
        CropDMG[i] = results$Cropdmg[highCrop[i]]
    }
    
    TopInjury = data.frame(factor(InEV), Injuries)
    TopFatal = data.frame(factor(FaEV), Fatalities)
    TopProp = data.frame(factor(PrEV), PropDMG)
    TopCrop = data.frame(factor(CrEV), CropDMG)
    
    names(TopInjury) = c('EVTYPE', 'Injuries')
    names(TopFatal) = c('EVTYPE', 'Fatalities')
    names(TopProp) = c('EVTYPE', 'PropDMG')
    names(TopCrop) = c('EVTYPE', 'CropDMG')
    
    #Creates plots of the data
    cropPlot = qplot(EVTYPE, CropDMG, data=TopCrop, geom='bar', stat='identity') + coord_flip()
    propPlot = qplot(EVTYPE, PropDMG, data=TopProp, geom='bar', stat='identity') + coord_flip()
    fatalPlot = qplot(EVTYPE, Fatalities, data=TopFatal, geom='bar', stat='identity') + coord_flip()
    injuryPlot = qplot(EVTYPE, Injuries, data=TopInjury, geom='bar', stat='identity') + coord_flip()
    
    fig1 = grid.arrange(injuryPlot,fatalPlot, ncol=2, main="Top Injuries/Fatalities vs Sources in US")
    fig2 = grid.arrange(cropPlot,propPlot, ncol=2, main="Top Crop/Property Damage vs Sources in US")
}