##
## Preprocess data from 3 sources to create corpus
##

#Load Packages
require(tm)
require(RWeka)

create_training = function(){
  #Load Data
  print("Loading data")
  dir = 'input/en_US/'
  train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
  train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))
  con = file(paste0(dir,"en_US.news.txt"), open="rb")
  train_news = readLines(con, encoding="UTF-8")
  close(con)
  
  
  ##
  ## Corpus creation for training set of data
  ##
  
  #Sample data size due to memory issues
  print("Creating sample sizes from datasets")
  set.seed(100)
  train_blogs = sample(train_blogs, 400000)
  train_news = sample(train_news, 400000)
  train_twitter = sample(train_twitter, 400000)
  
  #Create a corpus from dataset
  print("Creating corpus")
  create_corpus = function(dm, filter){
    corpus = Corpus(VectorSource(dm))
    corpus = tm_map(corpus, removeNumbers) # remove numbers
    corpus = tm_map(corpus, stripWhitespace) # remove whitespaces
    corpus = tm_map(corpus, tolower) #lowercase all contents
    corpus = tm_map(corpus, removePunctuation) # remove punctuation
    corpus = tm_map(corpus, removeWords, filter)
    corpus = tm_map(corpus, PlainTextDocument) #convert to plaintextdocument
    
    return(corpus)
  }
  
  #Create filter for direct removal of certain words
  print("Filtering data")
  filter = c("fuck", "bitch", "ass", "cunt", "pussy", "asshole", "douche")
  
  #Setup corpus from training data
  train_words = c(train_blogs, train_news, train_twitter)
  train_corpus = create_corpus(train_words, filter)
  
  return(train_corpus)
}


