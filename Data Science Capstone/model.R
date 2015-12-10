#Load Packages
library(tm)

Sys.setlocale(category="LC_ALL", locale = "English_United States.1252")

#Load Data
dir = 'input/en_US/'
train_blogs = readLines(paste0(dir,"en_US.blogs.txt"))
train_twitter = readLines(paste0(dir,"en_US.twitter.txt"))
con = file(paste0(dir,"en_US.news.txt"), open="rb")
train_news = readLines(con, encoding="UTF-8")
close(con)

train_blogs = sample(train_blogs, 300000)
train_news = sample(train_news, 300000)
train_twitter = sample(train_twitter, 300000)