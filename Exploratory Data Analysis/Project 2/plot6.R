#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
#in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in 
#motor vehicle emissions?

plot6 = function(){
    #Reads data if necessary
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    if(!exists('SCC')){
        SCC <<- readRDS("Source_Classification_Code.rds")        
    }    
    
    #Subsets data into Baltimore and Los Angeles values
    balt = subset(NEI,NEI$fips == '24510')
    la = subset(NEI,NEI$fips == '06037')
    
    #Extracts motor vehicles based on highway
    motor = grep('highway', SCC$Short.Name, ignore.case=TRUE)
    motor_ent = SCC[motor,]
    balt_data = merge(balt,motor_ent) #could probably use dplyr rather than merging all columns
    la_data = merge(la,motor_ent) #could probably use dplyr rather than merging all columns
    
    #Extracts total emissions for LA and Balt
    b1999 = sum(balt_data$Emissions[balt_data$year==1999])
    b2002 = sum(balt_data$Emissions[balt_data$year==2002])
    b2005 = sum(balt_data$Emissions[balt_data$year==2005])
    b2008 = sum(balt_data$Emissions[balt_data$year==2008])
    l1999 = sum(la_data$Emissions[la_data$year==1999])
    l2002 = sum(la_data$Emissions[la_data$year==2002])
    l2005 = sum(la_data$Emissions[la_data$year==2005])
    l2008 = sum(la_data$Emissions[la_data$year==2008])
    
    #Builds new data frame with prior extracted data for the graph
    p6data = data.frame(c(1999,2002,2005,2008),c(b1999,b2002,b2005,b2008),
                        c(l1999, l2002,l2005,l2008))
    names(p6data) = c( 'year','balt_emissions','la_emissions')
    
}