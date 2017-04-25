import requests
import urllib
import urllib.parse
from bs4 import BeautifulSoup
from datetime import datetime
import re
import urllib.request
url='https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH'
headers = {
        'Connection': 'Keep-Alive',
        'Accept-Language': 'en-US,en;q=0.8,zh-Hans-CN;q=0.5,zh-Hans;q=0.3',
        
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36',
        'Accept-Encoding':"utf-8"
        
          }
res={}
res = requests.get(url) 
res.encoding = 'UTF-8'
soup = BeautifulSoup(res.text, 'html.parser')
#print(res)
title=soup.select('h1')[0].text

print("城市:",title)
wendu=soup.select('.today_nowcard-temp span')[0].text
print("体感温度:",wendu)

rain=soup.select('.today_nowcard-phrase ')[0].text
print("天气情况:",rain)
#for i in range(0,8):
warth=soup.select('.today_nowcard-hilo span')

print("气温:",warth[0].text,warth[1].text,warth[4].text,warth[5].text)

zhishu=soup.select('.today_nowcard-hilo div')[0].text
print("紫外线指数:",zhishu)

#pinjunwendu1=soup.select('.today_nowcard-sidecar ')[0].text
#print(pinjunwendu1)
time=soup.select('.todaymap__timestamp ')[0].text
print("当前时间:",time)
foresee=soup.select('.heading-link h2')[0].text
print()
#####################################################
print(foresee,":")
print()
#pinjunwendu1=soup.select('.today-daypart-top ')[0].text
#print(pinjunwendu1)
nextday=soup.select('.daypart-0 span ')[0].text
print("时间点:",nextday)
nextday=soup.select('.daypart-0 span ')[1].text
print("天气情况:",nextday)
details=soup.select('.dp-details span')[0].text
print("天气详情:",details)
pinjunwendu3=soup.select('.wx-detail ')[0].text
print("风力:",pinjunwendu3)
pinjunwendu3=soup.select('.wx-detail ')[1].text
print("湿度:",pinjunwendu3)
pinjunwendu3=soup.select('.wx-detail ')[2].text
print("紫外线指数:",pinjunwendu3)
moonphrase=soup.select('.moonphase p')[0].text
print("月相:",moonphrase)

sunrise=soup.select('.list-group.sun p ')[0].text
print("日出时间:",sunrise)
sunset=soup.select('.list-group.sun p ')[1].text
print("日落时间:",sunset)



moonrise=soup.select('.list-group.moon p ')[0].text
print("月出时间:",moonrise)
moonset=soup.select('.list-group.moon p ')[1].text
print("月落时间:",moonset)

print()

####################################################
nextday=soup.select('.daypart-1 span ')[0].text
print("时间点:",nextday)
nextday=soup.select('.daypart-1 span ')[1].text
print("天气情况:",nextday)
hilo1=soup.select('.today-daypart-hilo  ')[1].text
#print("天气情况:",hilo1)
temp1=soup.select('.today-daypart-temp  ')[1].text
print("最高/最低温度:",hilo1,temp1)



print()
############################################################

nextday=soup.select('.daypart-2 span ')[0].text
print("时间点:",nextday)
nextday=soup.select('.daypart-2 span ')[1].text
print("天气情况:",nextday)
hilo2=soup.select('.today-daypart-hilo  ')[2].text
#print("天气情况:",hilo2)
temp2=soup.select('.today-daypart-temp  ')[2].text
print("最高/最低温度:",hilo2,temp2)
print()

