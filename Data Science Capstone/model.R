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

#Subset data for memory issues
train_blogs = sample(train_blogs, 500000)
train_news = sample(train_news, 500000)
train_twitter = sample(train_twitter, 500000)

#Create a corpus from dataset
create_corpus = function(dm){
  corpus = Corpus(VectorSource(dm))
  corpus = tm_map(corpus, removeNumbers) # remove numbers
  corpus = tm_map(corpus, stripWhitespace) # remove whitespaces
  corpus = tm_map(corpus, tolower) #lowercase all contents
  corpus = tm_map(corpus, removePunctuation) # remove punctuation
  corpus = tm_map(corpus, removeWords, c("fuck", "bitch", "ass", "cunt", "pussy", "asshole", "douche")) #remove some swears
  corpus = tm_map(corpus, PlainTextDocument) #convert to plaintextdocument
  
  return(corpus)
}

#Setup corpus from training data
train_words = c(train_blogs, train_news, train_twitter)
train_corpus = create_corpus(train_words)

#Create 1gram
ngram1 = DocumentTermMatrix(train_corpus)
ngram1 = removeSparseTerms(ngram1, 0.995) #keep words in that appear in 99.5%
ngram1 = as.data.frame(as.matrix(ngram1))


#Create 2-grams
create_n2 = function(corpus){
  TwogramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
  ngram2 = TermDocumentMatrix(corpus, control = list(tokenize = TwogramTokenizer))
  ngram2 = removeSparseTerms(ngram2, 0.995)
  ngram2 = as.data.frame(as.matrix(ngram2))
  
  return(ngram2)
}

ngram2 = create_n2(train_corpus)

#Create 3-grams
create_n3 = function(corpus){
  TrigramTokenizer = function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
  ngram3 = TermDocumentMatrix(corpus, control = list(tokenize = TrigramTokenizer))
  ngram3 = removeSparseTerms(ngram3, 0.999)
  ngram3 = as.data.frame(as.matrix(ngram3))
  
  return(ngram3)
}

ngram3 = create_n3(train_corpus)

