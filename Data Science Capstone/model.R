#Load Packages
library(tm)
library(RWeka)

#Load Data
dir = 'input/en_US/'
train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))
con = file(paste0(dir,"en_US.news.txt"), open="rb")
train_news = readLines(con, encoding="UTF-8")
close(con)

#Combine the datasets and begin to create the corpus of words
combined_raw = c(train_blogs,  train_news, train_twitter)

#Create a corpus from dataset
corpus = Corpus(VectorSource(combined_raw))
corpus = tm_map(corpus, removeNumbers) # remove numbers
corpus = tm_map(corpus, stripWhitespace) # remove whitespaces
corpus = tm_map(corpus, tolower) #lowercase all contents
corpus = tm_map(corpus, removePunctuation) # remove punctuation
corpus = tm_map(corpus, removeWords, c("fuck", "bitch", "ass", "cunt", "pussy", "asshole", "douche")) #remove some swears
corpus = tm_map(corpus, PlainTextDocument) #convert to plaintextdocument

#Create 1gram
ngram1 = DocumentTermMatrix(corpus)
ngram1 = removeSparseTerms(ngram1, 0.995) #keep words in that appear in 99.5%
ngram1 = as.data.frame(as.matrix(ngram1))

#Create 2-grams
TwogramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
ngram2 = TermDocumentMatrix(corpus, control = list(tokenize = TwogramTokenizer))
ngram2 = removeSparseTerms(ngram2, 0.995)
ngram2.5 = as.data.frame(as.matrix(ngram2))

#Create 3-grams
TrigramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
ngram3 = TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))
ngram3 = removeSparseTerms(ngram3, 0.999)
ngram3.5 = as.data.frame(as.matrix(ngram3))