#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which 
#of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have 
#seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this 
#question.

plot3 = function(){
    #Creates table as necessary
    if(!exists('NEI')){
        NEI <<- readRDS("summarySCC_PM25.rds")    
    }
    
    #Load ggplot2
    library('ggplot2')
    
    #Subsets the NEI types
    balt = subset(NEI,NEI$fips == '24510')
    point = subset(balt,balt$type == 'POINT')
    nonpoint = subset(balt,balt$type == 'NONPOINT')
    onroad = subset(balt,balt$type == 'ON-ROAD')
    nonroad = subset(balt,balt$type == 'NON-ROAD')
    
    #Extracts data from point
    p1999 = sum(point$Emissions[point$year==1999])
    p2002 = sum(point$Emissions[point$year==2002])
    p2005 = sum(point$Emissions[point$year==2005])
    p2008 = sum(point$Emissions[point$year==2008])
    
    #Extracts data from nonpoint
    np1999 = sum(nonpoint$Emissions[nonpoint$year==1999])
    np2002 = sum(nonpoint$Emissions[nonpoint$year==2002])
    np2005 = sum(nonpoint$Emissions[nonpoint$year==2005])
    np2008 = sum(nonpoint$Emissions[nonpoint$year==2008])

    #Extracts data from onroad
    r1999 = sum(onroad$Emissions[onroad$year==1999])
    r2002 = sum(onroad$Emissions[onroad$year==2002])
    r2005 = sum(onroad$Emissions[onroad$year==2005])
    r2008 = sum(onroad$Emissions[onroad$year==2008])
    
    #Extracts data from nonroad
    nr1999 = sum(nonroad$Emissions[nonroad$year==1999])
    nr2002 = sum(nonroad$Emissions[nonroad$year==2002])
    nr2005 = sum(nonroad$Emissions[nonroad$year==2005])
    nr2008 = sum(nonroad$Emissions[nonroad$year==2008])    
    
    #Creates dataframe with all the variables
    p3data = data.frame(c(1999,2002,2005,2008),c(p1999,p2002,p2005,p2008,
                        np1999,np2002,np2005,np2008,r1999,r2002,r2005,r2008,
                        nr1999,nr2002,nr2005,nr2008),factor(c('point','point','point','point',
                        'nonpoint','nonpoint','nonpoint','nonpoint','onroad','onroad','onroad',
                        'onroad','nonroad','nonroad','nonroad','nonroad')))
    names(p3data) = c('year','emissions','type')
    
    
    #Creates and saves the plot
    png(filename = "plot3.png", height = 480, width = 480)
    p3 = qplot(x=year,y=emissions,data=p3data,color=type,geom="line",xlab="Year",
               ylab="Total Emissions",main="Total emissions between different types of emitters 
               vs time",type="Type")
    p3 + labs(colour = "Type of Source") #Rename legend
    print(p3) #To be able to save the plot
    dev.off()
}