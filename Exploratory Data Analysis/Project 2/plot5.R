#How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City? 

plot5 = function(){
    #Reads data if necessary
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    if(!exists('SCC')){
        SCC <<- readRDS("Source_Classification_Code.rds")        
    }
    
    #Subsets out the data for Baltimore
    balt = subset(NEI,NEI$fips == '24510')   
    
    #Extracts any vehicle for highway/offhighway usage
    motor = grep('highway', SCC$Short.Name, ignore.case=TRUE)
    motor_ent = SCC[motor,]
    motor_data = merge(balt,motor_ent) #could probably use dplyr rather than merging all columns
    
    #Extracts total emissions from motor
    m1999 = sum(motor_data$Emissions[motor_data$year==1999])
    m2002 = sum(motor_data$Emissions[motor_data$year==2002])
    m2005 = sum(motor_data$Emissions[motor_data$year==2005])
    m2008 = sum(motor_data$Emissions[motor_data$year==2008])
    
    #Builds new data frame with prior extracted data for the graph
    p5data = data.frame(c(1999,2002,2005,2008),c(m1999,m2002,m2005,m2008))
    names(p5data) = c( 'year','total_emissions')
 
    #Draws and saves the graph
    png(filename = "plot5.png", height = 480, width = 480)
    plot(x=p5data$year,y=p5data$total_emission, xlab="Year",ylab="Total Vehicle Emissions", 
         main=paste("Plot 5 - Change in Emission from Vehicles vs Time(year)"),type='l',col='red')
    dev.off()
}