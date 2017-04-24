/**
 * Created by huangpeisong on 2017/4/24.
 */

const request = require('request-promise');
const cheerio = require('cheerio');


request('https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH')
  .then(function (res) {
    var $ = cheerio.load(res);
    var city = $(".today_nowcard-location").text();
    var temp = $(".today_nowcard-temp").text();
    var weather = $(".today_nowcard-phrase").text();
    var getTime = $(".today_nowcard-timestamp").text();
    console.log("地区:" + city.split(', ')[0]);
    console.log("温度:" + temp);
    console.log("天气:" + weather);
    console.log("更新时间:" + getTime.match(/[0-9]+:[0-9]+/g));
  }).catch(function (e) {
  console.log(e)
});

