package demo;

import java.io.*;
import java.net.*;
import java.util.Scanner;

public class Weather {
	public static void main(String[] args) {
		Scanner input = new Scanner(System.in);
		while(true)
		{
			String a = input.nextLine();
			if(a.equals(". hello-weather.sh")){
				output();
			}
			else
				break;
		}
		
	}
	
	public static void output(){
		String url = "https://api.weather.com/v2/turbo/vt1observation?"
				+ "apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=zh-CN&units=m";
		String result = "";
		BufferedReader in = null;
		try {
			URL realUrl = new URL(url);
			URLConnection connection = realUrl.openConnection();
			connection.connect();
			in = new BufferedReader(new InputStreamReader(connection.getInputStream(),"utf-8"));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		int a = result.lastIndexOf('{');
		int b = result.indexOf('}');
		result = result.substring(a+1, b);
		String[] items = result.split(",");
		for(String item:items){
			System.out.println(item);
		}
	}
}
