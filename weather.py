#! /usr/bin/python3
import requests
from bs4 import BeautifulSoup


class weather:
    def __init__(self, url):
        self.url = url

    def get_weather(self):
        rec = requests.get(url=self.url)
        rec.encoding = 'utf8'
        # print(rec.text)
        soup = BeautifulSoup(rec.text, 'lxml')
        today_data = soup.select('.today_nowcard-container')[0]
        # print(today_data)
        today_weather = {}
        bow_weather = {}
        print('-------------------------------------------')
        print('today weather')
        print('-------------------------------------------')
        # today_weather['location'] = today_data.select('.today_nowcard-location')[0].text
        today_weather['time'] = today_data.select('.today_nowcard-timestamp')[0].text
        today_weather['temp'] = today_data.select('.today_nowcard-temp span')[0].text
        today_weather['feel'] = today_data.select('.today_nowcard-feels')[0].text
        today_weather['condition'] = today_data.select('.today_nowcard-phrase')[0].text
        today_weather['hilo'] = today_data.select('.today_nowcard-hilo')[0].text
        for key, value in today_weather.items():
            print(key)
            print(value)
        print('-------------------------------------------')
        print('now condition')
        print('-------------------------------------------')
        now_weather = soup.select('.today_nowcard-sidecar.component.panel tr')
        for now_detail in now_weather:
            print(now_detail.text)


if __name__ == '__main__':
    GZ_url = 'https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH'
    GZ = weather(url=GZ_url)
    GZ.get_weather()
