# Hello-Weather
### 使用
unix下切换到文件所在目录执行 
```bash
chmod +x hello-weather.sh
./hello-weather.sh
```
### 效果
![image](http://ofx0oa4m3.bkt.clouddn.com/0425.png)
### 实现
没接触过shell脚本，现学现卖，实现不是很好，还请多加指教。

** （shell和正则表达式真的很强大） **

首先获取网页内容
```bash
url=https://weather.com/zh-CN/weather/today/l/23.12,113.25
wget $url -O weather_data.html > /dev/null 2>&1
```

因为网页内容被压缩过，全都挤在一行里，所以先处理一下将所需要的信息单独成行，再提取到tmp.log中

** sed **

输入命令：sed 's/ /\n/g' example.log。解释下命令，s是替换的标记，第一个/ /里面有一个空格，意思是查找所有含有空格的行，最后的g表明要对该行的所有空格进行查询，而不只是查询到第一个就查询下一行，第二个/\n/是一个换行符，结合前面的空格查询语法，可以对所有的空格替换成换行符。里面的命令执行后会把文本重新编排，遇到空格就换行。

** grep **

输入命令：grep 'test' test.log。  会将test.log里所有包含test的行输出。加-E参数可以加多个条件（或）
```bash
sed -i 's/<div class="today_nowcard">/\n/' weather_data.html 
grep -E '<section class="today_nowcard-container">|<div class="today-daypart-hilo"' weather_data.html > tmp.log
```


进一步筛选，查看网页html可以看到数据的前后格式为 >xxx< ，因此可通过匹配所需数据前的字符替换silence_xxx作为标识并换行，最后一句将每一行的第一个（没加-g参数）‘ < ’替换为回车，从而实现所需数据分别在单独的一行
```bash
sed -i 's/<h1 class="h4 today_nowcard-location">/\nsilence_location:/' tmp.log
sed -i 's/<div class="today_nowcard-temp"><span class="">/\nsilence_temp:/' tmp.log
sed -i 's/<div class="today_nowcard-phrase">/\nsilence_phrase:/' tmp.log
sed -i 's/<span class="deg-feels">/\nsilence_feels:/' tmp.log
sed -i 's/<span class="deg-hilo-nowcard"><span class="">/\nsilence_hilo:/g' tmp.log
sed -i 's/紫外线指数<!----> <\/span><span class="">/\nsilence_rays:/' tmp.log
sed -i 's/<tbody><tr><th>风力<\/th><td><span class="">/\nsilence_wind:/' tmp.log
sed -i 's/<\/tr><tr><th>湿度<\/th><td><span class=""><span>/\nsilence_humidity:/' tmp.log
sed -i 's/<tr><th>露点<\/th><td><span class="">/\nsilence_dew-point:/' tmp.log
sed -i 's/<tr><th>气压<\/th><td><span class="">/\nsilence_pressure:/' tmp.log
sed -i 's/<tr><th>能见度<\/th><td><span class="">/\nsilence_visibility:/' tmp.log
sed -i 's/<span class="today-wx-descrip" id="dp0-details-narrative">/\nsilence_today-pre:/' tmp.log

sed -i 's/</\n/' tmp.log
```

提取上面已单独成行并带有标识的数据到另外的文件中
```bash
grep -E 'silence_location:|silence_temp:|silence_phrase:|silence_feels:|silence_hilo:|silence_rays:|silence_wind:|silence_humidity:|silence_dew-point:|silence_pressure:|silence_visibility:|silence_today-pre:' tmp.log > weather_data
```

通过sed选取行，用awk选取列（用‘：’做分隔符），格式化输出
```bash
SYSTEM_TIME=`date '+%A %Y-%m-%d %H:%M'`
echo $SYSTEM_TIME

sed -n '1p' weather_data | awk -F: '{print $2}' 
sed -n '2p' weather_data | awk -F: 'BEGIN{ORS=""}{print $2 "ºC  "}'
sed -n '3p' weather_data | awk -F: '{print $2}'
sed -n '4p' weather_data | awk -F: '{print "体感温度：" $2 "ºC"}'
sed -n '5p' weather_data | awk -F: 'BEGIN{ORS=""}{print "高温： " $2 "ºC / "}'
sed -n '6p' weather_data | awk -F: '{print "低温：" $2 "ºC"}'
sed -n '7p' weather_data | awk -F: '{print "紫外线指数： " $2}'
sed -n '8p' weather_data | awk -F: '{print "风力： " $2}'
sed -n '9p' weather_data | awk -F: '{print "湿度： " $2 "%"}'
sed -n '10p' weather_data | awk -F: '{print "露点： " $2 "ºC"}'
sed -n '11p' weather_data | awk -F: '{print "气压： " $2}'
sed -n '12p' weather_data | awk -F: '{print "能见度： " $2}'
sed -n '13p' weather_data | awk -F: '{print $2}'
```

运行后产生一堆文件总是会让人心烦的，统统删掉
```bash
rm -rf weather_data.html tmp.log weather_data
```
