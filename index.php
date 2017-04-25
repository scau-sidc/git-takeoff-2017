<?php
$url = "https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=zh-CN&units=m";
$source = file_get_contents($url);
$result = json_decode($source)->vt1observation;
//print_r($result);
printf("今天是%s，广州天气%s，温度%s℃，体感温度%s℃，气压%s毫巴，相对湿度%s，能见度%s公里，%s%skm/s 紫外线指数%s/10，强度%s，祝您愉拥有快的一天！\n",date("m月d日"),$result->phrase,$result->temperature,$result->feelsLike,$result->altimeter,$result->humidity,$result->visibility,$result->windDirCompass,$result->windSpeed,$result->uvIndex,$result->uvDescription)
?>