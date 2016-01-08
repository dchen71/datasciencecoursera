library(shiny)
ngram1_raw = read.csv("data/ng1.csv")
ngram2_raw = read.csv("data/ng2.csv")
ngram3_raw = read.csv("data/ng3.csv")

#Predicts word/word phrases
pred_word = function(word){
  words = as.data.frame(unlist(strsplit(word, " ")))
  names(words) = "query"
  query_length = nrow(words)
  
  #Nice to have predict completely based on preceding characters
  #could be improved by trying to do local alignment
  if(query_length == 1){
    prediction = n1_pred(words, word)
  } else if(query_length == 2){
    if(words[1,1] %in% ngram2_raw$word1){ #If first word there, take the highest occuring 2nd word following it
      if(words[2,1] %in% ngram2_raw$word2){
        prediction = paste(words[1,1],words[2,1])
      } else{
        word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[1,1]),]
        prediction = paste(words[1,1], as.vector(word_match$word2[which.max(word_match$total)]))
      }
    } else if(words[1,1] %in% ngram1_raw$words){
      #predict 1gram freq vs freq of word in word2
      w2 = as.data.frame(words[2,1])
      if(nrow(ngram2_raw[ngram2_raw$word2 == as.vector(words[2,1]),]) >= 1){
        prediction = paste(words[1,1], words[2,1])
      } else{
        names(w2) = "query"
        w2 = n1_pred(w2, word)
        prediction = paste(words[1,1], w2)
      }
    }else{ #Take highest occuring preceding word
      word_match = ngram2_raw[ngram2_raw$word1 == as.vector(ngram1_raw$words[which.max(ngram1_raw$total)]),]
      if(words[2,1] %in% ngram2_raw$word2){ #Check if in dictionary
        prediction = paste(word_match$word1[1],words[2,1])
      } else{ #Second word will be predicted based on highest occurence
        prediction = as.vector(ngram2_raw$words[which.max(ngram2_raw$total)])
      }
    }
  } else if(query_length == 3){
    #check if first two words in, if not guess one from list
    #check first two words and guess likelihood of next word based on prob
    if(paste(words[1,1], words[2,1]) %in% ngram3_raw$phrase){
      if(words[3,1] %in% ngram3_raw$word3){
        prediction = paste(paste(words[1,1], words[2,1]), words[3,1])
      } else{
        word_match = ngram3_raw[ngram3_raw$phrase == paste(words[1,1], words[2,1]),]
        prediction = paste(paste(words[1,1], words[2,1]), as.vector(word_match$word3[which.max(word_match$total)]))
      }
    } else{ #Take highest occuring phrase
      word_match = ngram3_raw[ngram3_raw$phrase == as.vector(ngram2_raw$words[which.max(ngram2_raw$total)]),]
      if(words[3,1] %in% ngram3_raw$word3){ #Check if in dictionary
        prediction = paste(word_match$phrase[1], words[2,1])
      } else{ #Second word will be predicted based on highest occurence
        prediction = paste(word_match$phrase[1], as.vector(word_match$word3[which.max(word_match$total)]))
      }
    }
  } else{
    prediction = "Please limit prediction to 3 works max"
  }
  
  return(prediction)
}

#Predicts 1gram
n1_pred = function(words, word){
  if(words$query %in% ngram1_raw$words){ #If word in dict, then it is correct
    prediction = word
  }
  else if(substr(words$query[1],1,1) %in% ngram1_raw$start){ #Takes the highest occuring same starting char
    start_test = substr(words$query[1],1,1)
    start_match = ngram1_raw[ngram1_raw$start == start_test,]
    prediction = as.vector(start_match$words[which.max(start_match$total)])
  }
  else{ #Take the highest occuring word, be great if this took it based on local alignment although be less of issue if bigger data size
    prediction = as.vector(ngram1_raw$words[which.max(ngram1_raw$total)])
  }
  return(prediction)
}

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  output$prediction = renderText({pred_word(input$query)})
})
