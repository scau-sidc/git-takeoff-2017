#!/usr/bin/env python
# -*- coding: utf-8 -*-

import requests
import json

url = 'https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=zh-CN&units=m'
headers = {
    'Referer':"https://weather.com/",
    'User-Agent':"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/57.0.2987.133 Safari/537.36"
}

r = requests.get(url, headers=headers)
data = r.json()['vt1observation']
for k, v in data.items():
    print u'{}: {}'.format(k, v)