#Across the United States, how have emissions from coal combustion-related sources 
#changed from 1999-2008?

plot4 = function(){
    #Reads data if necessary
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    if(!exists('SCC')){
        SCC <<- readRDS("Source_Classification_Code.rds")        
    }

    #Finds the entries with coal
    coal = grep('Coal', SCC$Short.Name, ignore.case = TRUE)
    coal_ent = SCC[coal,]
    coal_data = merge(NEI,coal_ent) #could probably use dplyr rather than merging all columns
    
    #Extracts total emissions from coal
    c1999 = sum(coal_data$Emissions[coal_data$year==1999])
    c2002 = sum(coal_data$Emissions[coal_data$year==2002])
    c2005 = sum(coal_data$Emissions[coal_data$year==2005])
    c2008 = sum(coal_data$Emissions[coal_data$year==2008])
    
    #Builds new data frame with prior extracted data for the graph
    p4data = data.frame(c(1999,2002,2005,2008),c(c1999,c2002,c2005,c2008))
    names(p4data) = c( 'year','total_emissions')
    
    #Plots and saves a png
    png(filename = "plot4.png", height = 480, width = 480)
    plot(x=p4data$year,y=p4data$total_emission, xlab="Year",ylab="Total Coal Emissions", 
         main=paste("Plot 4 - Change in Emission vs Time(year)"),type='l',col='red')
    dev.off()
}