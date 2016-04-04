library(shiny)
ngram1_raw = read.csv("data/ng1.csv")
ngram2_raw = read.csv("data/ng2.csv")
ngram3_raw = read.csv("data/ng3.csv")

#Performs a Katz backoff model prediction
pred_backoff = function(word){
  spaces = length(gregexpr(" ", word)[[1]]) #counts number of lines in a string
  
  words = as.data.frame(unlist(strsplit(word, " "))) #splits up the word into dataframe
  names(words) = "query"
  query_length = nrow(words)
  
  ngram1_raw$prob = ngram1_raw$total / sum(ngram1_raw$total) #likelihood based on word frequency for 1grams
  ngram1_raw = ngram1_raw[order(ngram1_raw$prob),]
  
  twogram_prob = aggregate(total ~ word2, data=ngram2_raw, sum) #likelihood based on 2gram
  twogram_prob$prob = twogram_prob$total / sum(twogram_prob$total) #likelihood based on word frequency for 1grams
  twogram_prob = twogram_prob[order(twogram_prob$prob),]
  
  threegram_prob = aggregate(total ~ word3, data=ngram3_raw, sum)
  threegram_prob$prob = threegram_prob$total / sum(threegram_prob$total) #likelihood based on word frequency for 1grams
  threegram_prob = threegram_prob[order(threegram_prob$prob),]
  
  if(query_length == 1 && spaces == 1){ #1 word input, create prediction for next word
    if(word[1] %in% ngram2_raw$word1){ #see if there is an existing pattern
      word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[1,1]),]
      word_prob = aggregate(total ~ word2, data=word_match, sum)
      word_prob$prob = word_prob$total / sum(word_prob$total)
      word_prob = word_prob[order(word_prob$prob),]
      prediction = tail(word_prob[,c(1,3)])
    } else{ #guess the next word without a pattern through ngram1
      prediction = tail(twogram_prob[,c(1,3)])
    }
  } else if(query_length >= 2){ #For phrases longer than two words, will take the last 1-2 words to build prediction
      if(paste(words[query_length - 1,1], words[query_length,1]) %in% ngram3_raw$phrase){ #Checks ngram3 list first
        word_match = ngram3_raw[ngram3_raw$phrase == paste(words[query_length - 1,1], words[query_length,1]),]
        word_prob = aggregate(total ~ word3, data=word_match, sum)
        word_prob$prob = word_prob$total / sum(word_prob$total)
        word_prob = word_prob[order(word_prob$prob),]
        prediction = tail(word_prob[,c(1,3)])
      }
      else{ #Checks ngram2 list
        if(words[query_length,1] %in% ngram1_raw$word1){ #see if it can be matched through 2grams
          word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[query_length - 1,1]),]
          word_prob = aggregate(total ~ word2, data=word_match, sum)
          word_prob$prob = word_prob$total / sum(word_prob$total)
          word_prob = word_prob[order(word_prob$prob),]
          prediction = tail(word_prob[,c(1,3)])
        } else{
          prediction = tail(threegram_prob[,c(1,3)])
        }
    }
  }
  else{
    prediction = "No suitable prediction found"
  }
  
  return(prediction)
}

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  output$predictionv2 = renderDataTable({pred_backoff(input$backoff)}) #backoff model
})
