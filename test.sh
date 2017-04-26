#!/bin/bash
#这次任务完全借鉴别人代码 json解析一头雾水 所以学着看html代码模仿别人用shell抓取 不过这位大佬直接看源码抓也是蛮拼的
#对于我来说 这次任务更像是作为一个学习任务 而不是一个考核任务= =！ 在接触这个任务之前 完全没碰过正则 我。。。就趁这次机会好好恶补一下shell和正则
url="https://weather.com/zh-CN/weather/today/l/23.12,113.25"
#将数据下载到文件中
wget -O - $url >file 2>/dev/null
#正则抓‘广州，中国’到‘云图’的文本
need=$(cat file | grep -o -P '广州，中国(.)*?云图' )

echo 广州，中国
#改了部分来测试自己对正则的理解 有些key word实在替换不了就算了（逃
#只能谈谈自己的理解 例：↓grep抓取了today_nowcard-phrase到</div>的文本   ↓这段是以><为分隔符的第二个字段。。后面同理
tianqi=$(echo $need | grep -o -P 'today_nowcard-phrase(.)*?</div>' | awk -F'[><]' '{print $2}' )
qiwen=$(echo $need | grep -o -P 'today_nowcard-temp(.)*?<sup>' | awk -F'[><]' '{print $4}' )
tgwd=$(echo $need | grep -o -P 'deg-feels(.)*?<sup>' | awk -F'[><]' '{print $2}' )
fengli=$(echo $need | grep -o -P 'today_nowcard-sidecar component panel(.)*?</span>' | awk -F'[><]' '{print $20}' )
shidu=$(echo $need | grep -o -P '公里 /小时(.)*?</span>' | awk -F'[><]' '{print $19}' )
ludian=$(echo $need | grep -o -P 'percent-symbol(.)*?</span>' | awk -F'[><]' '{print $22}' )
qiya=$(echo $need | grep -o -P '气压(.)*?</span>' | awk -F'[><]' '{print $7}' )
njd=$(echo $need | grep -o -P 'icon icon-font iconset-arrows icon-arrow-up-line(.)*?</span>' | awk -F'[><]' '{print $14}' )
echo 天气 $tianqi
echo 能见度 $njd
echo 气温 $qiwen°
echo 体感温度 $tgwd°
echo 风力 $fengli
echo 湿度 $shidu%
echo 露点 $ludian°
echo 气压 $qiya