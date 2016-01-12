library(shiny)
ngram1_raw = read.csv("data/ng1.csv")
ngram2_raw = read.csv("data/ng2.csv")
ngram3_raw = read.csv("data/ng3.csv")

#Predicts word/word phrases, simple model
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
        w2 = n1_pred(w2, as.vector(words[2,1]))
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
      if(words[3,1] %in% ngram3_raw$word3){ #see if phrase in ngram3
        prediction = word
      } else if(words[2,1] %in% ngram2_raw$word1){ #check if 2nd word part of a 2gram phrase
        word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[2,1]),]
        prediction = paste(words[1,1], as.vector(word_match$words[which.max(word_match$total)]))
      } else { #takes the highest ngram3
        word_match = ngram3_raw[ngram3_raw$phrase == paste(words[1,1], words[2,1]),]
        prediction = paste(paste(words[1,1], words[2,1]), as.vector(word_match$word3[which.max(word_match$total)]))
      }
    } else if(words[2,1] %in% ngram2_raw$word1){ #checks 2gram for presence
      word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[2,1]),]
      prediction = paste(words[1,1], as.vector(word_match$words[which.max(word_match$total)]))
    } else{ 
      freqs = table(ngram2_raw$word2)
      if(word[2,1] != names(which.max(freqs))){
        prediction = paste(paste(words[1,1], words[2,1]), names(which.max(table(ngram2_raw$word2))))
      }
      else{
        len_freqs = length(freqs)
        prediction = paste(paste(words[1,1], words[2,1]), names(freqs[order(freqs)][len_freqs - 1]))
      }
    }
  } else{
    prediction = "Please limit prediction to 3 words max"
  }
  
  return(prediction)
}

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
  
  
  if(query_length == 1 && spaces == 1){ #1 word input, create prediction for next word
    if(word[1] %in% ngram2_raw$word1){ #see if there is an eisting pattern
      word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[1,1]),]
      word_prob = aggregate(total ~ word2, data=word_match, sum)
      word_prob$prob = word_prob$total / sum(word_prob$total)
      word_prob = word_prob[order(word_prob$prob),]
      prediction = tail(word_prob[,c(1,3)], 5)
    } else{ #guess the next word without a pattern through ngram1
      prediction = tail(twogram_prob[,c(1,3)], 5)
    }
  } else if(spaces == 1 && query_length == 2){ #2 words inputted, create prediction for 3gram
    if(paste(words[1,1], words[2,1]) %in% ngram3_raw$phrase){
      word_match = ngram3_raw[ngram3_raw$phrase == paste(words[1,1], words[2,1]),]
      word_prob = aggregate(total ~ word3, data=word_match, sum)
      word_prob$prob = word_prob$total / sum(word_prob$total)
      word_prob = word_prob[order(word_prob$prob),]
      prediction = tail(word_prob[,c(1,3)], 5)
    }
    else{
      if(words[2,1] %in% ngram1_raw$word1){ #see if it can be matched through 2grams
        word_match = ngram2_raw[ngram2_raw$word1 == as.vector(words[1,1]),]
        word_prob = aggregate(total ~ word2, data=word_match, sum)
        word_prob$prob = word_prob$total / sum(word_prob$total)
        word_prob = word_prob[order(word_prob$prob),]
        prediction = tail(word_prob[,c(1,3)], 5)
      } else{
        #0/whatever
      }
    }
  }
  else{
    prediction = "Please enter a string between 1-2 words"
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
  output$predictionv1 = renderText({pred_word(input$query)}) #simple model
  output$predictionv2 = renderDataTable({pred_backoff(input$backoff)}) #backoff model
})
