project2 = function(){
    library('data.table')
    #Cache and reads data if available
    data = read.csv('repdata_data_StormData.csv', stringsAsFactors=FALSE)    
    #Subsets all relevant data for usage
    p2 <<- data.frame(data$STATE,data$EVTYPE,data$INJURIES,data$FATALITIES, data$PROPDMG,data$CROPDMG)
    names(p2) = c('STATE', 'EVTYPE', 'INJURIES', 'FATALITIES', 'PROPDMG', 'CROPDMG')
    p2 = data.table(p2)
    
    states=c('AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'
    )
    
    #EVTYPE - types of disasters
    #INJURIES
    #FATALITIES
    
    #PROPDMG
    #CROPDMG
    
    #Want to make table with diaster type for injury/fatal prop/crop

    #Need to remove entries with summary    
    #Filter out states
    #AL,AK,AZ,AR,CA,CO,CT,DE,FL,GA,HI,ID,IL,IN,IA, KS,KY,LA,ME,MD,MA,MI,MN,MS,MO,MT,NE,NV,NH,NJ,NM,NY,NC,ND,OH,OK, OR,PA,RI,SC,SD,TN,TX,UT,VT,VA,WA,WV,WI,WY
    #'AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK,'OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY'
    
    #library('dplyr')
    #test = filter(p2, STATE == states) #filters out other states although leaves factors which is unwanted
    #test2 = grep('summary',test$EVTYPE,ignore.case=TRUE) #done here to filter out the summary in evtype
    #test = test[!test2] #need to remove factors again here
    #need to standardize evtype
    #need to merge evtype
}