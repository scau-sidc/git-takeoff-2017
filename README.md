## GetWeather 简易天气信息获取
- 数据源来自 weather.com
- 采用 PHP 编写

### 环境需求
- Linux
- PHP >= 5.0

### 环境安装*
For Debian / Ubuntu:
```bash
apt install php5-cgi php5-cli
```
请通过执行以下命令确保 PHP 安装正确
```bash
php -v
```

### 运行方法
```bash
./hello-weather.sh
```

#### 返回结果示例
> 今天是04月25日，广州天气多云，温度23℃，体感温度23℃，气压1013.88毫巴，相对湿度87，能见度6.44公里，東南偏東風3km/s 紫外线指数2/10，强度低，祝您愉拥有快的一天！

### 开发历程
1. 访问 weather.com ，通过 Chrome浏览器 开发者工具分析出对其api请求，返回为json格式。
![image](https://raw.githubusercontent.com/scau-sidc/git-takeoff-2017/dev-Rytia/screenshot_1.png)
2. 编写 php 代码，通过 file_get_content 模拟访问，并对获取的数据进行拆分显示。
3. 根据题目要求编写 shell 脚本启动 php