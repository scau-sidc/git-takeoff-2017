package cn.MegaAstronic.weather;

import java.io.IOException;

public class Main {

	public static void main(String[] args) {
		try {
			Weather.printWeatherMsg();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
