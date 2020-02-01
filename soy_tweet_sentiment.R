
# Set the path where the files are placed
setwd("C:\\Users\\vnike\\Downloads\\Minnemudac\\working code")


# Installing the required pages
installed.packages("SnowballC")
installed.packages("tm")
installed.packages("syuzhet")
install.packages("sentimentr")

# Loading the installed packages
library("SnowballC")
library("tm")
library(syuzhet)
library(lubridate)
library(ggplot2)
library(dplyr)
library(sentimentr)

## first step is to load the tweet data into a dataframe and do the necessary cleaning. Once the data is cleaned extracting sentiment from tweets using the syuzhet package in R 
tweet_sentiment <- function(filename){
  temp <- read.csv(filename,header = T,stringsAsFactors = F)
  temp1 <- data.frame(do.call('rbind', strsplit(as.character(temp$source.text.created_at.retweet_count.favorite_count.is_retweet.id_str),',',fixed=TRUE)))
  colnames(temp1) <- c("source", "tweet","created_time","retweet_count","fav_count","is_retweet","id_str")
  temp2 <- temp1 %>% select(tweet)
  temp2$tweet <- as.vector(temp2$tweet)
  sent.value <- as.data.frame(get_sentiment(temp2$tweet))
  colnames(sent.value) <- "sentiment"
  temp3 <- cbind(temp1,sent.value)
  return (temp3)
  
}


china_tweet_sentiment <- tweet_sentiment('China-tweets-realDonaldTrump.csv')

farmers_tweet_sentiment <- tweet_sentiment('FarmerTweets-realDonaldTrump.csv')

soy_tweet_sentiment <- tweet_sentiment('soybeans-tweets-realDonaldTrump.csv')



# Data manipulation steps so that they can be merged with the the contract file later which contains close price for soybean
manipulate_tweets_df <- function(temp){
  temp$created_time <- as.character(temp$created_time)
  temp$retweet_count <- as.numeric(temp$retweet_count)
  temp$fav_count <- as.numeric(temp$fav_count)
  temp$created_time <-  as.Date(temp$created_time, format = "%m-%d-%Y %H:%M:%S") 
  temp2 <- temp %>% group_by(created_time)%>%summarise(sentiment= mean(sentiment),retweet_count = sum(retweet_count),fav_count = sum(fav_count)) 
  return (temp2)
}

china_tweet_sentiment <- manipulate_tweets_df(china_tweet_sentiment)

farmers_tweet_sentiment <- manipulate_tweets_df(farmers_tweet_sentiment)

farmers_tweet_sentiment



may_contract <- read.csv("ActiveSoybeanContractsForMay2020.csv",header = T,stringsAsFactors = F)
may_contract$ï..Date <-  as.Date(may_contract$ï..Date, format = "%m/%d/%Y") 

may_contract_china_tweet <- merge(may_contract,tweet_sentiment_china,by.x = "ï..Date",by.y = "created_time",all.x = T)
may_contract_china_tweet <- merge(may_contract_china_tweet,tweet_sentiment_farmers,by.x = "ï..Date",by.y = "created_time",all.x = T)
may_contract_china_tweet <- merge(may_contract_china_tweet,tweet_sentiment_soy,by.x = "ï..Date",by.y = "created_time",all.x = T)


may_contract_china_tweet[is.na(may_contract_china_tweet)] <- 0
colnames(may_contract_china_tweet)[colnames(may_contract_china_tweet)=="ï..Date"] <- "date"

write.csv(may_contract_china_tweet,"may_tweet.csv",row.names = F)


may_tweet <- may_contract_china_tweet[,5:14]
reg <- lm(data= may_tweet,Close~.)
summary(reg)


usd_cny <- read.csv("USD_CNY Historical Data.csv",header = T,stringsAsFactors = F)
usd_cny$ï..Date <-  as.Date(usd_cny$ï..Date, format = "%m/%d/%Y")
colnames(usd_cny)[colnames(usd_cny)=="Price"] <- "Price_china"
usd_eur <- read.csv("EUR_USD.csv",header = T,stringsAsFactors = F)
usd_eur$ï..Date <-  as.Date(usd_eur$ï..Date, format = "%m/%d/%Y")
colnames(usd_eur)[colnames(usd_eur)=="Price"] <- "Price_europe"
usd_mxn <- read.csv("USD_MXN.csv",header = T,stringsAsFactors = F)
usd_mxn$ï..Date <-  as.Date(usd_mxn$ï..Date, format = "%m/%d/%Y")
colnames(usd_mxn)[colnames(usd_mxn)=="Price"] <- "Price_mexico"


usd_cny_contract <- merge(may_contract,usd_cny,by= "ï..Date")
converion_stock <- merge(usd_cny_contract,usd_eur,by = "ï..Date")
converion_stock <- merge(converion_stock,usd_mxn,by = "ï..Date")
usd_cny_req <- converion_stock %>% select(Close,Price_china,Price_europe,Price_mexico)
reg <- lm(data = usd_cny_req,Close~.)
summary(reg)


