package com.jang.portfolio.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.json.JSONArray;
import org.json.JSONObject;


public class ApiExplorer {
	
	public static void main(String args[]) throws IOException{
		
		String today = null;
		
		Date date = new Date();
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
		String dateStr = dtFormat.format(date);
		
		Calendar cal = Calendar.getInstance();

		cal.add(Calendar.DATE, -3);
		  
		today = dtFormat.format(cal.getTime());
		
		String apiUrl = "http://apis.data.go.kr/1360000/EqkInfoService/getEqkMsg"; //지진정보
		//decode인증키 입력
		String serviceKey = "NTgUe2KWiRRyApX8AIPkiPvFtQlyJz9hYxywyQihgbux2QcrlqtUfcGryBQnF8XqkiB9L9m/iuWeiB4uMar7WA==";
		String pageNo = "1";	// 페이지 번호
		String numOfRows = "10";	// 한 페이지 결과 수		
		String type = "json";	// 응답자료형식 : xml, json 
		String fromTmFc = today;
		String toTmFc = dateStr;
				
		//URL
		StringBuilder urlBuilder = new StringBuilder(apiUrl); // 요청주소 
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(serviceKey, "UTF-8")); //공공데이터포털에서 받은 인증키
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); //페이지번호
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); //한 페이지 결과 수
	    urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(type, "UTF-8")); //요청자료형식(XML/JSON)
	    urlBuilder.append("&" + URLEncoder.encode("fromTmFc","UTF-8") + "=" + URLEncoder.encode(fromTmFc, "UTF-8")); //시간(년월일)
	    urlBuilder.append("&" + URLEncoder.encode("toTmFc","UTF-8") + "=" + URLEncoder.encode(toTmFc, "UTF-8")); //시간(년월일)
	    
	    URL url = new URL(urlBuilder.toString());
	    
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
        BufferedReader rd;
        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        //string->json
        JSONObject jsonObj = new JSONObject(sb.toString());
        
        //json->jsonArray
        JSONArray jsonArr = new JSONArray();
        jsonArr.put(jsonObj);
        
        //jsonArray -> jsonList
        ArrayList<JSONObject> arrayJson = new ArrayList<JSONObject>();
        
        for(int i = 0; i < jsonArr.length(); i++) {
        	JSONObject tempJson = jsonArr.getJSONObject(i);
        	arrayJson.add(tempJson);
        }
        
        for(int i = 0; i < arrayJson.size(); i++) {
        	System.out.println(arrayJson.get(i));
        }
        
        rd.close();
        conn.disconnect();
        
	}
	
	public String apidata() throws IOException {
		
		String today = null;
		
		Date date = new Date();
		SimpleDateFormat dtFormat = new SimpleDateFormat("yyyyMMdd");
		String dateStr = dtFormat.format(date);
		
		Calendar cal = Calendar.getInstance();

		cal.add(Calendar.DATE, -3);
		  
		today = dtFormat.format(cal.getTime());
		
		String apiUrl = "http://apis.data.go.kr/1360000/EqkInfoService/getEqkMsg"; //지진정보
		//decode인증키 입력
		String serviceKey = "NTgUe2KWiRRyApX8AIPkiPvFtQlyJz9hYxywyQihgbux2QcrlqtUfcGryBQnF8XqkiB9L9m/iuWeiB4uMar7WA==";
		String pageNo = "1";	// 페이지 번호
		String numOfRows = "10";	// 한 페이지 결과 수		
		String type = "json";	// 응답자료형식 : xml, json 
		String fromTmFc = today;
		String toTmFc = dateStr;
				
		//URL
		StringBuilder urlBuilder = new StringBuilder(apiUrl); // 요청주소 
		urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=" + URLEncoder.encode(serviceKey, "UTF-8")); //공공데이터포털에서 받은 인증키
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode(pageNo, "UTF-8")); //페이지번호
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(numOfRows, "UTF-8")); //한 페이지 결과 수
	    urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode(type, "UTF-8")); //요청자료형식(XML/JSON)
	    urlBuilder.append("&" + URLEncoder.encode("fromTmFc","UTF-8") + "=" + URLEncoder.encode(fromTmFc, "UTF-8")); //시간(년월일)
	    urlBuilder.append("&" + URLEncoder.encode("toTmFc","UTF-8") + "=" + URLEncoder.encode(toTmFc, "UTF-8")); //시간(년월일)
	    
	    URL url = new URL(urlBuilder.toString());
	    
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        
        BufferedReader rd;
        
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        
        StringBuilder sb = new StringBuilder();
        String line;
        
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        
        rd.close();
        conn.disconnect();
        
        return sb.toString();
	}
	
}
