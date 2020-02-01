#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Oct 26 11:27:31 2019

@author: kexinliang
"""

import csv
import pandas as pd


# CHINA
china = []

with open('China-tweets-_realDonaldTrump.csv', 'r') as f:
    header1 = f.readline().strip().split(',')
    for line in csv.reader(f):
        china.append(line[0].strip().split(','))

header1[0] = header1[0].lstrip('"')
header1[-1] = header1[-1].rstrip('"')

china_df = pd.DataFrame(china, columns=header1)
china_df.info()

china_df['retweet_count'] = china_df['retweet_count'].astype(int)
china_df['favorite_count'] = china_df['favorite_count'].astype(int)
china_df['created_at'] = pd.to_datetime(china_df['created_at'])
# china_df['id_str'] = china_df['id_str'].astype(str)
china_df = china_df.drop_duplicates()

china_df.to_csv('/Users/kexinliang/Desktop/Competition/other data source/china_tweets.csv',
                index=False)


# FARMER
farmer = []

with open('FarmerTweets-_realDonaldTrump.csv', 'r') as f:
    header2 = f.readline().strip().split(',')
    for line in csv.reader(f):
        farmer.append(line[0].strip().split(','))

header2[0] = header2[0].lstrip('"')
header2[-1] = header2[-1].rstrip('"')

farmer_df = pd.DataFrame(farmer, columns=header2)
farmer_df.info()

farmer_df['retweet_count'] = farmer_df['retweet_count'].astype(int)
farmer_df['favorite_count'] = farmer_df['favorite_count'].astype(int)
farmer_df['created_at'] = pd.to_datetime(farmer_df['created_at'])
farmer_df = farmer_df.drop_duplicates()

farmer_df.to_csv('/Users/kexinliang/Desktop/Competition/other data source/farmer_tweets.csv',
                index=False)

# SOYBEANS
soybean = []

with open('soybeans-tweets-_realDonaldTrump.csv', 'r') as f:
    header3 = f.readline().strip().split(',')
    for line in csv.reader(f):
        soybean.append(line[0].strip().split(','))

header3[0] = header3[0].lstrip('"')
header3[-1] = header3[-1].rstrip('"')

soybean_df = pd.DataFrame(soybean, columns=header3)
soybean_df.info()

soybean_df['retweet_count'] = soybean_df['retweet_count'].astype(int)
soybean_df['favorite_count'] = soybean_df['favorite_count'].astype(int)
soybean_df['created_at'] = pd.to_datetime(soybean_df['created_at'])
soybean_df = soybean_df.drop_duplicates()

soybean_df.to_csv('/Users/kexinliang/Desktop/Competition/other data source/soybean_tweets.csv',
                index=False)

# In[]
# weather
import pandas as pd

weather = []
header = []
with open('south_temp.txt', 'r') as f:
    header4 = f.readline().strip().split(',')
    for col in header4:
        header.append(col.strip().strip('-'))
    for line in f:
        line = line.strip().split(',')
        new_line = []
        for word in line:
            word = word.strip().strip('*').strip('I').strip('G').strip('C').strip('A').strip('B').strip('D').strip('H')
            new_line.append(word)
        weather.append(new_line)

weather_df = pd.DataFrame(weather, columns = header)
weather_df = weather_df.drop(columns = [''])
weather_df['TEMP'] = weather_df['TEMP'].astype(float)
weather_df['DEWP'] = weather_df['DEWP'].astype(float)
weather_df['SLP'] = weather_df['SLP'].astype(float)
weather_df['STP'] = weather_df['STP'].astype(float)
weather_df['VISIB'] = weather_df['VISIB'].astype(float)
weather_df['WDSP'] = weather_df['WDSP'].astype(float)
weather_df['MXSPD'] = weather_df['MXSPD'].astype(float)
weather_df['GUST'] = weather_df['GUST'].astype(float)
weather_df['MAX'] = weather_df['MAX'].astype(float)
weather_df['MIN'] = weather_df['MIN'].astype(float)
weather_df['PRCP'] = weather_df['PRCP'].astype(float)
weather_df['SNDP'] = weather_df['SNDP'].astype(float)
weather_df['YEARMODA'] = pd.to_datetime(weather_df['YEARMODA'])
weather_df = weather_df.drop_duplicates()
weather_df.to_csv('/Users/kexinliang/Desktop/Competition/new_weather/south_temp.csv',
                index=False)
