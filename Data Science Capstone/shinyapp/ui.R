library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Data Science Capstone"),
  
  sidebarPanel(
    h3("About"),
    p("The purpose of this model is to be able to predict words and phrases, based on what the user
      is inputting. Natural language processing has many uses including search engines and autocorrect.
      This model will be used as part of the Cousera Data Science Capstone in order to predict text 
      based on training data provided coming from blogs, twitter, and the news."),
    h3("How the model is structured"),
    h4("The model"),
    p("The model itself is simple and primitive. The model primarily functions by predicting words based 
      on n-1 grams. The prediction algorithm works only for up to 3 words. The model works in ngram2 and ngram3
      by looking at the previous word or phrase and subsetting its guess based on those datasets. If the phrase being
      predicted has a previous word or first two words in the prediction dataset, it will subset the data and
      return the highest occuring subsequent word afterwards. In the case that the previous word/words 
      have no matches, it returns the highest occuring phrase in the dataset. In addition, ngram1 can predict
      based on the first letter input.")
  ),
  
  mainPanel(
    h2("Text prediction"),
    p("Input some text to try it out"),
    helpText("Note that it will only work up to 3 words"),

    h3("Katz Backoff Model"),
    textInput("backoff", "Input"),
    h4("Predicted next word"),
    dataTableOutput("predictionv2")
  )
))
