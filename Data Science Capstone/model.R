#Load Packages
library(tm)

Sys.setlocale(category="LC_ALL", locale = "English_United States.1252")

#Load Data
##Manually removed strange encoding(sub?) at lines 77259,766277
dir = 'input/en_US/'
train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
train_news = readLines(paste0(dir,"en_US.news.txt"))
train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))
train_news = train_news[1:926142]

train_blogs = sample(train_blogs, 300000)
train_news = sample(train_news, 300000)
train_twitter = sample(train_twitter, 300000)