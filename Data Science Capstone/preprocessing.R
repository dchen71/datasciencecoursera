##
## Preprocess data from 3 sources to create tm of 1gram/2gram/3gram
##

#Load Packages
library(tm)
library(RWeka)
source("create_corpus.R")

# Create corpus
train_corpus = create_training()
save(train_corpus, file="train_corpus.RData")

##
## 1-Gram
##

# Load corpus
load("train_corpus.RData")

# Create 1grams
ngram1 = DocumentTermMatrix(train_corpus)
save(ngram1, file="ngram1_raw.RData")
ngram1 = removeSparseTerms(ngram1, 0.995)
ngram1 = as.data.frame(as.matrix(ngram1))
save(ngram1, file="ngram1.RData")

# Process raw ngrams
ngram1_total = colSums(ngram1)
ngram1_raw = as.numeric(ngram1_total[1:length(ngram1_total)])
ngram1_raw = data.frame(names(ngram1),ngram1_raw)
names(ngram1_raw) = c("words", "total")
ngram1_raw$start = substr(ngram1_raw$words, 1,1)
save(ngram1_raw, file="ngram1_processed.RData")
write.csv(ngram1_raw, "ng1.csv", row.names = FALSE)

##
## 2-Gram
##

# Load corpus
load("train_corpus.RData")

#Create 2-grams
TwogramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
ngram2 = TermDocumentMatrix(train_corpus, control = list(tokenize = TwogramTokenizer))
save(ngram2, file="ngram2_raw.RData")
ngram2 = removeSparseTerms(ngram2, 0.995)
ngram2 = as.data.frame(as.matrix(ngram2))
save(ngram2, file="ngram2.RData")

#Preceding word, after
ngram2_total = rowSums(ngram2)
ngram2_raw = as.numeric(ngram2_total[1:nrow(ngram2)])
ngram2_raw = data.frame(names(ngram2_total),ngram2_raw)
names(ngram2_raw) = c("words", "total")
ngram2_raw$word1 = "dummy"
ngram2_raw$word2 = "dummy"
for(i in 1:nrow(ngram2_raw)){
  split_words = unlist(strsplit(as.character(ngram2_raw$words[i]), " "))
  ngram2_raw$word1[i] = split_words[1]
  ngram2_raw$word2[i] = split_words[2]
}
save(ngram2_raw, file="ngram2_processed.RData")
write.csv(ngram2_raw, "ng2.csv", row.names = FALSE)

##
## 3-Gram
##

# Load corpus
load("train_corpus.RData")

#Create 3-grams
TrigramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
ngram3 = TermDocumentMatrix(train_corpus, control = list(tokenize = TrigramTokenizer))
save(ngram3, file="ngram3_raw.RData")
ngram3 = removeSparseTerms(ngram3, 0.999)
ngram3 = as.data.frame(as.matrix(ngram3))
save(ngram3, file="ngram3.RData")

#Preceding phrase, after
ngram3_total = rowSums(ngram3)
ngram3_raw = as.numeric(ngram3_total[1:nrow(ngram3)])
ngram3_raw = data.frame(names(ngram3_total),ngram3_raw)
names(ngram3_raw) = c("words", "total")
ngram3_raw$phrase = "dummy"
ngram3_raw$word3 = "dummy"
for(i in 1:nrow(ngram3_raw)){
  split_words = unlist(strsplit(as.character(ngram3_raw$words[i]), " "))
  ngram3_raw$phrase[i] = paste(split_words[1],split_words[2], sep=" ")
  ngram3_raw$word3[i] = split_words[3]
}
save(ngram3_raw, file="ngram3_processed.RData")
write.csv(ngram3_raw, "ng3.csv", row.names = FALSE)
