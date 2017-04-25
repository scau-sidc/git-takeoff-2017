#!/bin/bash

url="https://weather.com/zh-CN/weather/today/l/23.12,113.25"

wget -O - $url >file 2>/dev/null

need=$(cat file | grep -o -P 'h1 class(.)*?云图' )

echo 广州，中国

qiwen=$(echo $need | grep -o -P 'today_nowcard-temp(.)*?<sup>' | awk -F'[><]' '{print $4}' )
echo 气温 $qiwen°

tianqi=$(echo $need | grep -o -P 'today_nowcard-phrase(.)*?</div>' | awk -F'[><]' '{print $2}' )
echo 天气 $tianqi

tgwd=$(echo $need | grep -o -P 'deg-feels(.)*?<sup>' | awk -F'[><]' '{print $2}' )
echo 体感温度 $tgwd°

fengli=$(echo $need | grep -o -P '风力(.)*?</span>' | awk -F'[><]' '{print $7}' )
echo 风力 $fengli

shidu=$(echo $need | grep -o -P '湿度(.)*?</span>' | awk -F'[><]' '{print $9}' )
echo 湿度 $shidu%

ludian=$(echo $need | grep -o -P '露点(.)*?</span>' | awk -F'[><]' '{print $7}' )
echo 露点 $ludian°

qiya=$(echo $need | grep -o -P '气压(.)*?</span>' | awk -F'[><]' '{print $7}' )
echo 气压 $qiya

njd=$(echo $need | grep -o -P '能见度(.)*?</span>' | awk -F'[><]' '{print $7}' )
echo 能见度 $njd