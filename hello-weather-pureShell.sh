function getMsg(){
	curlPage=$(curl -s -A "Mozilla/4.0 (compatible; MSIE 5.01; Windows NT 5.0)" https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH)
	result=$(echo $curlPage |
 	grep -o "<div class=\"today_nowcard-phrase\">[^<]\{1,\}<"  |
 	grep -o ">[^<]*<")
	endLetter=`expr index "$result" \<`
	letterLength=$[(endLetter - 2)/3]
 	msg=${result:1:letterLength}
 	#echo "$curlPage"
}
function getTemperature(){
	result=$(echo $curlPage | 
	grep -E -o 'deg-feels">[^<]{1,}<' |
 	grep -o ">[^<]*<" )
	endLetter=`expr index "$result" \<`
	letterLength=$[(endLetter - 2)]
	temperature=${result:1:letterLength}
}

function getWetPercent(){
	result=$(echo $curlPage | 
	grep -E -o '湿度</th><td><span class=""><span>[^<]{1,}<' |
	grep -E -o 'span>[^<]{1,}<' |
 	grep -o ">[^<]*<" )
	endLetter=`expr index "$result" \<`
	letterLength=$[(endLetter - 2)]
	wetPercent=${result:1:letterLength}
}

function getWindMsg(){
	result=$(echo $curlPage | 
	grep -E -o '风力</th><td><span class="">[^<]{1,}<' |
	grep -E -o '>[^<]{1,}<' |
 	grep -o ">[^<]*<" )
	endLetter=`expr index "$result" \<`
	letterLength=$[(endLetter - 2)/3]
	windMsg=${result:1:letterLength}
}

getMsg 
getTemperature
getWetPercent
getWindMsg
echo "广州当前天气 $msg 温度：${temperature}°C  湿度：${wetPercent} % ${windMsg}"