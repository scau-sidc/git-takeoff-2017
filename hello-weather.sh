#! /bin/sh

#获取网页内容
url=https://weather.com/zh-CN/weather/today/l/23.12,113.25
wget $url -O weather_data.html > /dev/null 2>&1

#预处理，缩小匹配范围
sed -i 's/<div class="today_nowcard">/\n/' weather_data.html 
grep -E '<section class="today_nowcard-container">|<div class="today-daypart-hilo"' weather_data.html > tmp.log

#将所需要的数据分别置于单独一行
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

#提取数据
grep -E 'silence_location:|silence_temp:|silence_phrase:|silence_feels:|silence_hilo:|silence_rays:|silence_wind:|silence_humidity:|silence_dew-point:|silence_pressure:|silence_visibility:|silence_today-pre:' tmp.log > weather_data

#格式化输出
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

#删除临时文件
rm -rf weather_data.html tmp.log weather_data