library(lubridate) 

# July Contract
fcj = read.csv("jui_contract.csv")
colnames(fcj)[1] = "Date"
#fcj = fcj[,-1]

supply = read.csv('soybean_supply_disappearance.csv')


fcj$Date = as.Date(fcj$Date)
fcj$Date= as.POSIXct(paste(fcj$Date))
fcj$Year = year(fcj$Date)
fcj$Month = month(fcj$Date)

#get export and import of soybean
merge_supply= merge(fcj,supply[,c(1,2,4,6)],by = c('Year','Month'), all.x = TRUE)

#get export and import of soybean oil
oil = read.csv('soyoil_supply_disp.csv')
merge_supply= merge(merge_supply,oil[,c(1,2,3,4,6,10)],by = c('Year','Month'), all.x = TRUE)


# add us dollar
merge_supply$Date = as.Date(merge_supply$Date)
dollar = read.csv('DTWEXB.csv')
dollar$Date= as.POSIXct(paste(dollar$Date),format="%m/%d/%y")
dollar$Date= as.Date(dollar$Date)
#colnames(dollar)[1] = "Date"

merge_supply= merge(merge_supply,dollar,by="Date",all.x = TRUE)


# rapeseed
r = read.csv('Rapeseed Futures Historical Data.csv')
r$Date= as.POSIXct(paste(r$Date),format="%m/%d/%y")
r$Date = as.Date(r$Date)

merge_supply= merge(merge_supply,r[,c(1,2)],by="Date",all.x = TRUE)

#sunflower
s = read.csv('Sunflower Seed Futures Historical Data.csv')
s$Date= as.POSIXct(paste(s$Date),format="%m/%d/%y")
s$Date = as.Date(s$Date)

merge_supply= merge(merge_supply,s[,c(1,2)],by="Date",all.x = TRUE)
colnames(merge_supply)[21] = "SunflowerPrice"
 

#cottonseed
s = read.csv('Cottonseed Oilcake Futures Historical Data.csv')
s$Date= as.POSIXct(paste(s$Date),format="%m/%d/%y")
s$Date = as.Date(s$Date)

merge_supply= merge(merge_supply,s[,c(1,2)],by="Date",all.x = TRUE)
colnames(merge_supply)[22] = "CottonseedPrice"



#corn
corn_july = read.csv('US Corn Futures Historical Data.csv')
corn_july$Date= as.POSIXct(paste(corn_july$Date), format="%m/%d/%y")
corn_july$Date= as.Date(corn_july$Date)
merge_corn = merge(merge_supply,corn_july[,c(1,2)],by = 'Date', all.x = TRUE)
colnames(merge_corn)[23] = "Corn_Price"

#fertilizer

f1 = read.csv("Fertilizer price.csv")
f1$Date= as.POSIXct(paste(f1$Date), format="%m/%d/%y")
f1$Date= as.Date(f1$Date)
m1= merge(merge_corn,f1[,c(1,5)],by = 'Date',all.x = TRUE)
 

write.csv(m1,file="July_Super_Final.csv",row.names = FALSE)





#get weather and precipition

w_p = read.csv('price_temp_prcp_July.csv')
w_p$Date= as.POSIXct(paste(w_p$Date),format="%m/%d/%y")
#w_p$Year = year(w_p$Date)
#w_p$Month = month(w_p$Date)
merge_supply= merge(merge_supply,w_p,by = 'Date', all.x = TRUE)

write.csv(merge_supply,file = "July_Final.csv",row.names = FALSE)




# May Contract
fcj = read.csv("fertilizer_corn_May.csv")
fcj = fcj[,-1]

supply = read.csv('soybean_supply_disappearance.csv')

library()

fcj$Date = as.Date(fcj$Date)
fcj$Date= as.POSIXct(paste(fcj$Date))
fcj$Year = year(fcj$Date)
fcj$Month = month(fcj$Date)

#get export and import of soybean
merge_supply= merge(fcj,supply[,c(1,2,4,6)],by = c('Year','Month'), all.x = TRUE)


#get export and import of soybean oil
oil = read.csv('soyoil_supply_disp.csv')
merge_supply= merge(merge_supply,oil[,c(1,2,3,4,6,10)],by = c('Year','Month'), all.x = TRUE)


#miss soybean meal

#get weather and precipition

w_p = read.csv('price_temp_prcp_July.csv')
w_p$Date= as.POSIXct(paste(w_p$Date),format="%m/%d/%y")
#w_p$Year = year(w_p$Date)
#w_p$Month = month(w_p$Date)
merge_supply= merge(merge_supply,w_p,by = 'Date', all.x = TRUE)

summary(merge_supply$Date)




#March Contract
fcj = read.csv("fertilizer_corn_March.csv")
#fcj = fcj[,-1]

supply = read.csv('soybean_supply_disappearance.csv')

fcj$Date = as.Date(fcj$Date)
fcj$Date= as.POSIXct(paste(fcj$Date))
fcj$Year = year(fcj$Date)
fcj$Month = month(fcj$Date)

#get export and import of soybean
merge_supply= merge(fcj,supply[,c(1,2,4,6)],by = c('Year','Month'), all.x = TRUE)


#get export and import of soybean oil
oil = read.csv('soyoil_supply_disp.csv')
merge_supply= merge(merge_supply,oil[,c(1,2,3,4,6,10)],by = c('Year','Month'), all.x = TRUE)


#miss soybean meal

#get weather and precipition

w_p = read.csv('price_temp_prcp_March.csv')
w_p$Date= as.POSIXct(paste(w_p$Date),format="%m/%d/%y")
#w_p$Year = year(w_p$Date)
#w_p$Month = month(w_p$Date)
merge_supply= merge(merge_supply,w_p[,c(1,3,4)],by = 'Date', all.x = TRUE)

write.csv(merge_supply,file = "March_ffinal.csv",row.names = FALSE)

 

