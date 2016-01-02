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
      based on training data provided from blogs, twitter, and the news."),
    p("How the model is structured"),
    p("There are numerous ways to improve the model:"),
    tags$ul(
      tags$li("Local alignment of words being inputted so it finds most likely word based on input"),
      tags$li("A bigger training set of data should be used to better model what can be input")
    )
  ),
  
  mainPanel(
    h2("Text prediction"),
    p("Input some text to try it out"),
    em("Note that it will only work up to 3 words"),
    textInput("query", "Input")
  )
))
