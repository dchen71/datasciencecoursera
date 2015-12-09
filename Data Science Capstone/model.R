#Load Packages
library(tm)

#Load Data
dir = 'input/en_US/'
train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
train_news = readLines(paste0(dir,"en_US.news.txt"))
train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))

train_blogs = sample(train_blogs, 300000)

train_twitter = sample(train_twitter, 300000)