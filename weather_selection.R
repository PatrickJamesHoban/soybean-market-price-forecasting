library(readxl)
library(dplyr)
# setwd("~/Desktop/Competition/original data")
# july = read_excel('ActiveSoybeanContractsfor2020.CSV.xlsx')

# weather
setwd("~/Desktop/Competition/new_weather")
july = read.csv('may_contract.csv')
arkansas = read.csv('arkansas_temp.csv')
illinois = read.csv('illinois_temp.csv')
indiana = read.csv('indiana_temp.csv')
lowa = read.csv('iowa_temp.csv')
minnesota = read.csv('minnesota_temp.csv')
missouri = read.csv('missouri_temp.csv')
north_dakota = read.csv('north_temp.csv')
ohio = read.csv('ohio_temp.csv')
south_dakota = read.csv('south_temp.csv')
nebraska = read.csv('nebraska_temp.csv')

july$Time = as.Date(july$Time)

arkansas$YEARMODA = as.Date(arkansas$YEARMODA)
illinois$YEARMODA = as.Date(illinois$YEARMODA)
indiana$YEARMODA = as.Date(indiana$YEARMODA)
lowa$YEARMODA = as.Date(lowa$YEARMODA)
minnesota$YEARMODA = as.Date(minnesota$YEARMODA)
missouri$YEARMODA = as.Date(missouri$YEARMODA)
north_dakota$YEARMODA = as.Date(north_dakota$YEARMODA)
ohio$YEARMODA = as.Date(ohio$YEARMODA)
south_dakota$YEARMODA = as.Date(south_dakota$YEARMODA)
nebraska$YEARMODA = as.Date(nebraska$YEARMODA)


minnesota_t = minnesota %>%
  group_by(YEARMODA) %>%
  summarize(minnesota_temp = mean(TEMP, na.rm = TRUE))
illinois_t = illinois %>%
  group_by(YEARMODA) %>%
  summarize(illinois_temp = mean(TEMP, na.rm = TRUE))
lowa_t = lowa %>%
  group_by(YEARMODA) %>%
  summarize(lowa_temp = mean(TEMP, na.rm = TRUE))
nebraska_t = nebraska %>%
  group_by(YEARMODA) %>%
  summarize(nebraska_temp = mean(TEMP, na.rm = TRUE))
ohio_t = ohio %>%
  group_by(YEARMODA) %>%
  summarize(ohio_temp = mean(TEMP, na.rm = TRUE))
arkansas_t = arkansas %>%
  group_by(YEARMODA) %>%
  summarize(arkansas_temp = mean(TEMP, na.rm = TRUE))
indiana_t = indiana %>%
  group_by(YEARMODA) %>%
  summarize(indiana_temp = mean(TEMP, na.rm = TRUE))
missouri_t = missouri %>%
  group_by(YEARMODA) %>%
  summarize(missouri_temp = mean(TEMP, na.rm = TRUE))
north_dakota_t = north_dakota %>%
  group_by(YEARMODA) %>%
  summarize(northdakota_temp = mean(TEMP, na.rm = TRUE))
south_dakota_t = south_dakota %>%
  group_by(YEARMODA) %>%
  summarize(southdakota_temp = mean(TEMP, na.rm = TRUE))

# arkansas_t = arkansas %>% select(YEARMODA,arkansas_temp = TEMP)
# illinois_t = illinois %>% select(YEARMODA,illinois_temp = TEMP)
# indiana_t = indiana %>% select(YEARMODA,indiana_temp = TEMP)
# lowa_t = lowa %>% select(YEARMODA,lowa_temp = TEMP)
# minnesota_t = minnesota %>% select(YEARMODA,minnesota_temp = TEMP)
# missouri_t = missouri %>% select(YEARMODA,missouri_temp = TEMP)
# north_dakota_t = north_dakota %>% select(YEARMODA,north_dakota_temp = TEMP)
# ohio_t = ohio %>% select(YEARMODA,ohio_temp = TEMP)
# south_dakota_t = south_dakota %>% select(YEARMODA,south_dakota_temp = TEMP)
# nebraska_t = nebraska %>% select(YEARMODA,nebraska_temp = TEMP)


weather_10 = merge(july,arkansas_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,illinois_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,indiana_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,lowa_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,minnesota_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,missouri_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,north_dakota_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,ohio_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,south_dakota_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
weather_10 = merge(weather_10,nebraska_t,by.x = 'Time', by.y = 'YEARMODA', all.x = TRUE)
#weather_10$avg_temp = rowMeans(weather_10[,6:15], na.rm = TRUE)
out_temp = weather_10 %>%
  select(arkansas_temp:nebraska_temp)
write.csv(out_temp, 'temp.csv', row.names = FALSE)
# ccf1 = ccf(weather_10$Close, weather_10$avg_temp)
# noem_data = as.data.frame(scale(weather_10[,-1]))
# ccf2 = ccf(noem_data$Close, weather_10$avg_temp)
# lm1 = lm(Close ~ .-Open-High-Low, noem_data)
# summary(lm1)




###################################rainfall###################################
# setwd("~/Desktop/Competition/rainfall")
# minnesota_r = read.csv('MinnesotaDailyWeather_09-2017_10-2019.csv')
# illinois_r = read.csv('IllinoisDailyWeather_09-2017_10-2019.csv')
# lowa_r = read.csv('IowaDailyWeather_09-2017_10-2019.csv')
# nebraska_r = read.csv('NebraskaDailyWeather_09-2017_10-2019.csv')
# ohio_r = read.csv('OhioDailyWeather_09-2017_10-2019.csv')
# arkansas_r = read.csv('ArkansasDailyWeather_09-2017_10-2019.csv')
# indiana_r = read.csv('IndianaDailyWeather_09-2017_10-2019.csv')
# missouri_r = read.csv('MissouriDailyWeather_09-2017_10-2019.csv')
# northdakota_r = read.csv('NorthDakotaDailyWeather_09-2017_10-2019.csv')
# southdakota_r = read.csv('SouthDakotaDailyWeather_09-2017_10-2019.csv')

arkansas_r = read.csv('Arkansas_Weather.csv')
illinois_r = read.csv('Illinois_Weather.csv')
indiana_r = read.csv('Indiana_Weather.csv')
lowa_r = read.csv('Iowa_Weather.csv')
minnesota_r = read.csv('Minnesota_Weather.csv')
missouri_r = read.csv('Missouri_Weather.csv')
northdakota_r = read.csv('North_Dakota_Weather.csv')
ohio_r = read.csv('Ohio_Weather.csv')
southdakota_r = read.csv('South_Dakota_Weather.csv')
nebraska_r = read.csv('Nebraska_Weather.csv')

nrow(distinct(ohio_r))

minnesota_rs = minnesota_r %>%
  group_by(DATE) %>%
  summarize(minnesota_prcp = mean(PRCP, na.rm = TRUE))
illinois_rs = illinois_r %>%
  group_by(DATE) %>%
  summarize(illinois_prcp = mean(PRCP, na.rm = TRUE))
lowa_rs = lowa_r %>%
  group_by(DATE) %>%
  summarize(lowa_prcp = mean(PRCP, na.rm = TRUE))
nebraska_rs = nebraska_r %>%
  group_by(DATE) %>%
  summarize(nebraska_prcp = mean(PRCP, na.rm = TRUE))
ohio_rs = ohio_r %>%
  group_by(DATE) %>%
  summarize(ohio_prcp = mean(PRCP, na.rm = TRUE))
arkansas_rs = arkansas_r %>%
  group_by(DATE) %>%
  summarize(arkansas_prcp = mean(PRCP, na.rm = TRUE))
indiana_rs = indiana_r %>%
  group_by(DATE) %>%
  summarize(indiana_prcp = mean(PRCP, na.rm = TRUE))
missouri_rs = missouri_r %>%
  group_by(DATE) %>%
  summarize(missouri_prcp = mean(PRCP, na.rm = TRUE))
northdakota_rs = northdakota_r %>%
  group_by(DATE) %>%
  summarize(northdakota_prcp = mean(PRCP, na.rm = TRUE))
southdakota_rs = southdakota_r %>%
  group_by(DATE) %>%
  summarize(southdakota_prcp = mean(PRCP, na.rm = TRUE))
# minnesota_rs = minnesota_r %>% filter(STATION == levels(minnesota_r$STATION)[4]) %>% select(DATE, minnesota_prcp = PRCP)
# illinois_rs = illinois_r %>% filter(STATION == levels(illinois_r$STATION)[7]) %>% select(DATE, illinois_prcp = PRCP)
# lowa_rs = lowa_r %>% filter(STATION == levels(lowa_r$STATION)[2]) %>% select(DATE, lowa_prcp = PRCP)
# nebraska_rs = nebraska_r %>% filter(STATION == levels(nebraska_r$STATION)[3]) %>% select(DATE, nebraska_prcp = PRCP)
# ohio_rs = ohio_r %>% filter(STATION == levels(ohio_r$STATION)[1]) %>% select(DATE, ohio_prcp = PRCP)

minnesota_rs$DATE = as.Date(minnesota_rs$DATE)
illinois_rs$DATE = as.Date(illinois_rs$DATE)
lowa_rs$DATE = as.Date(lowa_rs$DATE)
nebraska_rs$DATE = as.Date(nebraska_rs$DATE)
ohio_rs$DATE = as.Date(ohio_rs$DATE)
arkansas_rs$DATE = as.Date(arkansas_rs$DATE)
indiana_rs$DATE = as.Date(indiana_rs$DATE)
missouri_rs$DATE = as.Date(missouri_rs$DATE)
northdakota_rs$DATE = as.Date(northdakota_rs$DATE)
southdakota_rs$DATE = as.Date(southdakota_rs$DATE)

weather_15 = merge(weather_10,minnesota_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,illinois_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,lowa_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,nebraska_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,ohio_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,arkansas_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,indiana_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,missouri_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,northdakota_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
weather_15 = merge(weather_15,southdakota_rs,by.x = 'Time', by.y = 'DATE', all.x = TRUE)
out_prep = weather_15 %>%
  select(minnesota_prcp:southdakota_prcp)

write.csv(out_prep, 'prep.csv', row.names = FALSE)
colnames(weather_15)

weather_15$avg_temp = rowMeans(weather_15[,11:20], na.rm = TRUE)
weather_15$avg_prcp = rowMeans(weather_15[,21:30], na.rm = TRUE)

out = weather_15 %>% select(Time:sent_agri, avg_temp, avg_prcp)
write.csv(out,'MayContract_latest.csv', row.names = FALSE)
lm1 = lm(Close ~ .-Date-avg_temp, out)
summary(lm1)
lm2 = lm(Close ~ .-Date-avg_prcp, out)
summary(lm2)
lm3 = lm(Close ~ .-Date, out)
summary(lm3)

#####################
corn = read.csv('May_Super_Final.csv')
weather = read.csv('MayContract_latest.csv')
corn = corn %>%
  select(Time = Date, Soybean_Imports:Fertilizer_Price)
corn$Time = as.Date(corn$Time,format = '%m/%d/%y')
weather$Time = as.Date(weather$Time)
final = merge(weather, corn, by = 'Time')
write.csv(final, '5Contract_Latest.csv',row.names = FALSE)

latest = read.csv('MayContract_latest.csv')
str(latest)
latest$soyoil_imports = as.numeric(latest$soyoil_imports)
latest$soyoil_exports = as.numeric(latest$soyoil_exports)
latest$US_Dollar_Index = as.numeric(latest$US_Dollar_Index)
latest$SunflowerPrice = as.numeric(latest$SunflowerPrice)
latest$CottonseedPrice = as.numeric(latest$CottonseedPrice)
latest[is.na(latest)] = 0
summary(latest)
write.csv(latest,'5contrat.csv',row.names = FALSE)




