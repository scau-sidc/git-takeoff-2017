package weather;
import java.io.BufferedReader;   
import java.io.IOException;  
import java.io.InputStreamReader;  
 
import java.net.MalformedURLException;  
import java.net.URL;  
import java.net.URLConnection;
import java.util.Scanner;  

public class sixsixsix {

	static String  getWeatherInform(String cityName){  
        
 
        String Url = "https://api.weather.com/v2/turbo/vt1observation?apiKey=c1ea9f47f6a88b9acb43aba7faf389d4&format=json&geocode=23.12%2C113.25&language=zh-CN&units=m";  
        StringBuffer strBuf;  
        strBuf = new StringBuffer();  
              
        try{  
            URL url = new URL(Url);  
            URLConnection conn = url.openConnection();  
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(),"utf-8"));//×ªÂë¡£  
            String line = null;  
            while ((line = reader.readLine()) != null)  
                strBuf.append(line +" ");  
                reader.close();  
        }catch(MalformedURLException e) {  
            e.printStackTrace();   
        }catch(IOException e){  
            e.printStackTrace();   
        }     

        return strBuf.toString(); 
	}
	
	
	public static void main(String[] args)
	{   
		Scanner in=new Scanner(System.in);
		String x=in.next();
		String k=new String(".hello-weather.sh" );
		if(x.equals(k))
		{
		String s=new String(getWeatherInform("¹ãÖÝ"));
	    int a=s.indexOf("altimeter");
	    int b=s.indexOf("}");
	    String s1=new String(s.substring(a, b));
	    String[] s2=s1.split(",");
	    System.out.print('"');
	    for(String a1:s2)
	    {
	    	System.out.println(a1);
	    }
		}
		
	}
}

