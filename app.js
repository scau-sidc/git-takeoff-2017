/**
 * Created by huangpeisong on 2017/4/24.
 */

const request = require('request');
const cheerio = require('cheerio');
const fs = require('fs');
// const fs = require('fs');//
// var body = fs.readFileSync('test.txt');
// var $ = cheerio.load(body)
// var city = $("h1.today_nowcard-location").text();
// var temp = $(".today_nowcard-temp").text();
// var weather = $(".today_nowcard-phrase").text();
// var getTime = $(".today_nowcard-timestamp").text();
//
// console.log(city);
// console.log(temp);
// console.log(weather);
// console.log(getTime);


request('https://weather.com/zh-CN/weather/today/l/CHXX0037:1:CH', function (error, response, body) {
  if (!error && response.statusCode == 200) {
    fs.writeFile('test.txt', body,  function() {
      fs.readFile('test.txt', function (err, body) {
        if (err) {
          return console.error(err);
        }
        else{
          var $ = cheerio.load(body)
          var city = $(".today_nowcard-location").text();
          var temp = $(".today_nowcard-temp").text();
          var weather = $(".today_nowcard-phrase").text();
          var getTime = $(".today_nowcard-timestamp").text();

          console.log("地区:"+city);
          console.log("温度:"+temp);
          console.log("天气:"+weather);
          console.log("更新时间:"+getTime);
        }
      });
    });

  }
});


