#Load Packages
library(tm)

#Load Data
dir = 'input/en_US/'
train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
train_news = readLines(paste0(dir,"en_US.news.txt"))
train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))



