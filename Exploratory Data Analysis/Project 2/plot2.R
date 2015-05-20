#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 
#to 2008? Use the base plotting system to make a plot answering this question.

plot2 = function(){
    #Reads the data
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    
    #Extracts necessary data for the graph
    balt = subset(NEI,NEI$fips == '24510')
    p1999 = sum(balt$Emissions[balt$year==1999])
    #p2000 = sum(balt$Emissions[balt$year==2000]) #no recorded values
    #p2001 = sum(balt$Emissions[balt$year==2001]) #no recorded values
    p2002 = sum(balt$Emissions[balt$year==2002])
    #p2003 = sum(balt$Emissions[balt$year==2003]) #no recorded values
    #p2004 = sum(balt$Emissions[balt$year==2004]) #no recorded values
    p2005 = sum(balt$Emissions[balt$year==2005])
    #p2006 = sum(balt$Emissions[balt$year==2006]) #no recorded values
    #p2007 = sum(balt$Emissions[balt$year==2007]) #no recorded values
    p2008 = sum(balt$Emissions[balt$year==2008])
    
    #Builds new data frame with prior extracted data for the graph
    p2data = data.frame(c(p1999,p2002,p2005,p2008),c(1999,2002,2005,2008))
    names(p2data) = c('total_emissions', 'year')
    
    #Draws the plot
    png(filename = "plot2.png", height = 480, width = 480)
    plot(x=p2data$year,y=p2data$total_emission, xlab="Year",ylab="Total Pm2.5 emission of Baltimore", 
         main=paste("Plot 2 - Total Emissions in Baltimore vs Time(year)"),type='l',col='red')
    dev.off()
}