package com.jang.portfolio.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.jang.portfolio.user.service.impl.UserVO;

public class Utils {

	//카카오 소셜 로그인
	public String getAccessToken(String authorize_code) {
		
		String access_Token = "";
		String refresh_Token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			//URL연결은 입출력에 사용 될 수 있고, POST혹은 PUT요청을 하려면 setDoOutput을 true로 설정해야함.
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			//POST요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
	        StringBuilder sb = new StringBuilder();
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=2dcf89a26d35b1bdefb99a137e907076");
			sb.append("&redirect_uri=http://jangport.tplinkdns.com/user/oauth_kakao");
			sb.append("&code=" +authorize_code);
			
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "";
			String result = "";
			
			while ((line = br.readLine()) != null) {
				result += line;
			}
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			access_Token = element.getAsJsonObject().get("access_token").getAsString();

			refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			
			br.close();
			bw.close();
			
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return access_Token;
	}
	
	//유저정보조회
	public String getUserInfo(String access_Token) { 
		
		//HashMap<String, Object> userInfo = new HashMap<String, Object>();
		String kakaoId = "";
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
			
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			
			conn.setRequestProperty("Authorization", "Bearer " + access_Token);
			
			int responseCode = conn.getResponseCode();
			
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			
			String line = "";
			String result = "";
			
			while((line = br.readLine()) != null) {
				result += line;
			}
			
			JsonParser parser = new JsonParser();
			JsonElement element = parser.parse(result);
			
			//JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
			
            //JsonObject properties2 = element.getAsJsonObject().get("kakao_account").getAsJsonObject().get("profile").getAsJsonObject();
            //String nickname = properties2.getAsJsonObject().get("nickname").getAsString();
            kakaoId = element.getAsJsonObject().get("id").getAsString();
            
            //userInfo.put("accessToken", access_Token);
            //userInfo.put("kakaoId", kakaoId);
            //userInfo.put("nickname", nickname);
            
		} catch(IOException e) {
			e.printStackTrace();
		}
		
		return kakaoId;
	}
	
	public UserVO loginUser(UserVO param) {
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		return loginUser;
	}
}
