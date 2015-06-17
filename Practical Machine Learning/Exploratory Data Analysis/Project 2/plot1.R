#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot 
#showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

plot1 = function(){
    #Reads the data
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    
    #Extracts necessary data for the graph
    p1999 = sum(NEI$Emissions[NEI$year==1999])
    p2002 = sum(NEI$Emissions[NEI$year==2002])
    p2005 = sum(NEI$Emissions[NEI$year==2005])
    p2008 = sum(NEI$Emissions[NEI$year==2008])
    
    #Builds new data frame with prior extracted data for the graph
    p1data = data.frame(c(p1999,p2002,p2005,p2008),c(1999,2002,2005,2008))
    names(p1data) = c('total_emissions', 'year')
    
    #Draws the plot
    png(filename = "plot1.png", height = 480, width = 480)
    plot(x=p1data$year,y=p1data$total_emission, xlab="Year",ylab="Total Pm2.5 emission", 
         main=paste("Plot 1 - Total PM2.5 Emissions vs Time(year)"),type='l',col='red')
    dev.off()
}