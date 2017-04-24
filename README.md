#run
```bash
python weather.py
```

#心得
搜索广州的页面，转换语言为中文，页面跳转至

https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH

使用 chrome 的开发者工具观察请求，发现请求

https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&geocode=23.12%2C113.25&units=m&language=zh-CN&format=json

有大部分数据，返回格式是 json，于是直接使用 requests 库发送改请求，使用浏览器的 headers。

以上。