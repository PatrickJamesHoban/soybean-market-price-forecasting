
# Set the path where the files are placed
setwd("C:\\Users\\vnike\\Downloads\\Minnemudac\\working code")


# Installing the required pages
installed.packages("SnowballC")
installed.packages("tm")
installed.packages("syuzhet")
install.packages("sentimentr")
install.packages('lubridate')
install.packages('ggplot2')
install.packages('dplyr')
install.packages('tseries')


# Loading the installed packages
library(SnowballC)
library(tm)
library(syuzhet)
library(lubridate)
library(ggplot2)
library(dplyr)
library(sentimentr)
library(tseries)

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


# Data manipulation steps so that they can be merged with the the contract file later which contains close price for soybean
manipulate_tweets_df <- function(temp){
  temp$created_time <- as.character(temp$created_time)
  temp$retweet_count <- as.numeric(temp$retweet_count)
  temp$fav_count <- as.numeric(temp$fav_count)
  temp$created_time <-  as.Date(temp$created_time, format = "%m-%d-%Y %H:%M:%S") 
  temp2 <- temp %>% group_by(created_time)%>%summarise(sentiment= mean(sentiment),retweet_count = sum(retweet_count),fav_count = sum(fav_count)) 
  return (temp2)
}


china_tweet_sentiment <- tweet_sentiment('China-tweets-realDonaldTrump.csv')
farmers_tweet_sentiment <- tweet_sentiment('FarmerTweets-realDonaldTrump.csv')
soy_tweet_sentiment <- tweet_sentiment('soybeans-tweets-realDonaldTrump.csv')


china_tweet_sentiment <- manipulate_tweets_df(china_tweet_sentiment)
farmers_tweet_sentiment <- manipulate_tweets_df(farmers_tweet_sentiment)
soy_tweet_sentiment <- manipulate_tweets_df(soy_tweet_sentiment)

# changing colnames of sentiment, fav_count and retweet count since all the tweet files have the same column names and merginf can be a problem
colnames(china_tweet_sentiment) <- c("created_time","china_sentiment","china_retweet_count","china_fav_vount")
colnames(farmers_tweet_sentiment) <- c("created_time","farm_sentiment","farm_retweet_count","farm_fav_vount")
colnames(soy_tweet_sentiment) <- c("created_time","soy_sentiment","soy_retweet_count","soy_fav_vount")

# Reading the contract for may file and merging it with the tweets sentiment to see if there is any correlation between tweet and sentiment
may_contract <- read.csv("may2020_contract.csv",header = T,stringsAsFactors = F)
may_contract$ï..Date <-  as.Date(may_contract$ï..Date, format = "%m/%d/%Y") 
may_contract_tweet <- merge(may_contract,china_tweet_sentiment,by.x = "ï..Date",by.y = "created_time",all.x = T)
may_contract_tweet <- merge(may_contract_tweet,farmers_tweet_sentiment,by.x = "ï..Date",by.y = "created_time",all.x = T)
may_contract_tweet <- merge(may_contract_tweet,soy_tweet_sentiment,by.x = "ï..Date",by.y = "created_time",all.x = T)

# Replacing the NAs with 0 value
may_contract_tweet[is.na(may_contract_tweet)] <- 0

#write.csv(may_contract_china_tweet,"may_tweet.csv",row.names = F)

# running a linear regression to check if sentiment has any correlation with close price of soybean
may_tweet <- may_contract_tweet[,5:14]
reg <- lm(data= may_tweet,Close~.)
summary(reg)

## we can see that other than sentiment on soy tweets and well as favourite count of tweets by trump on china 
## none of the other sentiments are playing a role in soybeans closing price in the futures market

# Tweets can have a delayed effect and the prices of soybean may have an impact after the tweet has been made a couple of days before.
# checking if any of the lag has a corrleation with the soybean price

corr <- may_contract_tweet %>% select(Close,china_sentiment,farm_sentiment,soy_sentiment)


# performaing a stationary test to see if the time series is stationary
adf.test(corr$Close)
adf.test(corr$china_sentiment)
adf.test(corr$farm_sentiment)
adf.test(corr$soy_sentiment)

diff_close=diff(corr$Close,1)
acf(diff_close)

ccf1 = ccf(diff_close, corr$china_sentiment)
ccf1

ccf2 = ccf(diff_close, corr$farm_sentiment)
ccf2

ccf3 = ccf(diff_close, corr$soy_sentiment)
ccf3

# It can be clearly seen that, none of the lagged variables have any correlation as well

## One logical reason to this could be that some tweets can have a drastic impact on price but that is just one event, tweet sentiment may not always have an impact on price

# Nect analysis is to check if US conversion rates with any of the major exporting/importing nations have an impact on soybean price

# converting the datwe format and the column name of price to be used with the merged file

currency_conversion <-function(filename){
  temp <- read.csv(filename,header = T,stringsAsFactors = F)
  temp$ï..Date <-  as.Date(temp$ï..Date, format = "%m/%d/%Y")
  return(temp)
}

us_brl <- currency_conversion('brl.csv')
us_chn <- currency_conversion('cny.csv')
us_eur <- currency_conversion('eur.csv')
us_mxn <- currency_conversion('mxn.csv')
us_ind  <- currency_conversion('inr.csv')



# Merging the contract price file with conversion rate files
usd_cny_contract <- merge(may_contract,us_chn,by= "ï..Date")
converion_stock <- merge(usd_cny_contract,us_eur,by = "ï..Date")
converion_stock <- merge(converion_stock,us_mxn,by = "ï..Date")
converion_stock <- merge(converion_stock,us_brl,by = "ï..Date")
converion_stock <- merge(converion_stock,us_ind,by = "ï..Date")

# Running regression to see the correlation between soybean price and conversion rates 
usd_cny_req <- converion_stock %>% select(Close,Price_cny,Price_eur,Price_mxn,Price_brl,Price_inr)
reg <- lm(data = usd_cny_req,Close~.)
summary(reg)


