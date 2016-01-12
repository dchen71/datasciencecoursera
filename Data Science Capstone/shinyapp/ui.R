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
    h4("Preprocessing the data"),
    p("The data used in the model comes from a combination of a sampling of 200000 from blogs, twitter, 
      and the news. The data is processed into a corpu where it is then further processed by removing
      numbers, white spaces, lowercase the content, remove punctuation, and some swear words. From there,
      a 1-gram,2-gram, and 3-gram are created and some sparse terms are removed. "),
    h4("Building the model"),
    p("The model itself is simple and primitive. The model primarily functions by predicting words based 
      on n-1 grams. The prediction algorithm works only for up to 3 words. The model works in ngram2 and ngram3
      by looking at the previous word or phrase and subsetting its guess based on those datasets. If the phrase being
      predicted has a previous word or first two words in the prediction dataset, it will subset the data and
      return the highest occuring subsequent word afterwards. In the case that the previous word/words 
      have no matches, it returns the highest occuring phrase in the dataset. In addition, ngram1 can predict
      based on the first letter input."),
    h3("Methods to improve the model:"),
    tags$ul(
      tags$li("Local alignment of words being inputted so it finds most likely word based on input"),
      tags$li("A bigger training set of data should be used to better model what can be input"),
      tags$li("Could potentially use bigger ngram to better guess text"),
      tags$li("Could use position of text to help indicate start, end of text"),
      tags$li("The list goes on and on")
    )
  ),
  
  mainPanel(
    h2("Text prediction"),
    p("Input some text to try it out"),
    helpText("Note that it will only work up to 3 words"),
    h3("Simple prediction model"),
    textInput("query", "Input"),
    h4("Predicted text"),
    textOutput("predictionv1"),
    h3("Katz Backoff Model"),
    textInput("backoff", "Input"),
    h4("Predicted next word"),
    textOutput("predictionv2")
  )
))
