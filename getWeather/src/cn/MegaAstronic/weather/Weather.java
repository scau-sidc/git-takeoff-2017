package cn.MegaAstronic.weather;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.URL;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class Weather {
	public static String jsonURL="https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=en-US&units=m";
	public static String jsonURLCN="https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=zh-CN&units=m";
	public static String jsonFileName="weather.json";
	/**
	 * 在控制台打印广州天气信息
	 * @throws IOException
	 */
	public static void printWeatherMsg() throws IOException{
			Weather.JSONdownLoad(Weather.jsonURLCN, jsonFileName);//下载JSON文件
			
			JsonParser parse = new JsonParser();	
			JsonObject json=(JsonObject) parse.parse(new FileReader(jsonFileName));
			JsonObject weatherJson = json.get("vt1observation").getAsJsonObject();
			String phrase = weatherJson.get("phrase").getAsString();
			String temperature = weatherJson.get("temperature").getAsString();
			String windDirCompass = weatherJson.get("windDirCompass").getAsString();
			String windSpeed = weatherJson.get("windSpeed").getAsString();
			String humidity = weatherJson.get("humidity").getAsString();
			System.out.println("广州天气");
			System.out.println(phrase);
			System.out.println("温度:"+temperature+"℃");
			System.out.println("湿度:"+humidity+"%");
			System.out.println("风向:"+windDirCompass+" 风速:"+windSpeed+"km/h");
			
	}
	
	
	/**
	 * 下载天气信息的JSON
	 * @param urlStr API的URL
	 * @param fileName 保存的文件名
	 * @throws IOException
	 */
	public static void  JSONdownLoad(String urlStr,String fileName) throws IOException{  
        URL url = new URL(urlStr);    
        HttpURLConnection conn = (HttpURLConnection)url.openConnection();    
        conn.setConnectTimeout(3*1000);  
        conn.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)");  
        InputStream inputStream = conn.getInputStream();    
        byte[] getData = readInputStream(inputStream);      
        File file = new File(fileName);      
        FileOutputStream fos = new FileOutputStream(file);       
        fos.write(getData);   
        if(fos!=null){  
            fos.close();    
        }  
        if(inputStream!=null){  
            inputStream.close();  
        }  
       // System.out.println("json download success");   
    }  
    
    public static  byte[] readInputStream(InputStream inputStream) throws IOException {    
        byte[] buffer = new byte[1024];    
        int len = 0;    
        ByteArrayOutputStream bos = new ByteArrayOutputStream();    
        while((len = inputStream.read(buffer)) != -1) {    
            bos.write(buffer, 0, len);    
        }    
        bos.close();    
        return bos.toByteArray();    
    }    
}
