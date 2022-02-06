package com.jang.portfolio.user.web;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jang.portfolio.user.service.userService;
import com.jang.portfolio.user.service.impl.UserVO;
import com.jang.portfolio.util.LoginUserSession;
import com.jang.portfolio.util.Utils;

@Controller
public class userController {

	@Resource(name="userService")
	private userService service;
	
	@Resource(name="LoginUserSession")
	private LoginUserSession hs;
	
	@Resource(name="utils")
	private Utils utils;
	
	private int globalCnt = 0;
	//CRUD create, select, update, delete
	
	@RequestMapping(value="/user/login", method = RequestMethod.GET)
	public String login() {
		System.out.println("누구냐!" + ++globalCnt);
		return "/user/login";
	}
	
	@RequestMapping(value="/user/login", method = RequestMethod.POST)
	public String login(UserVO vo, Model model) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		String msg = "";
		
		String result = service.login(vo);
		
		if(result == "loginSuc") {
			return "redirect:/board/list";
		} 
		
		msg = "아이디 또는 비밀번호를 확인해주세요.";
		
		model.addAttribute("logfail", msg);
		
		return "/user/login";
	}
	
	@RequestMapping(value="/user/join", method = RequestMethod.GET)
	public String join(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			cookies[0].setMaxAge(0);
		}
		
		return "/user/join";
	}
	
	@RequestMapping(value="/user/join", method = RequestMethod.POST)
	public String join(UserVO vo
					 , HttpServletResponse response
					 , HttpServletRequest request) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException{
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies.length >= 2) {
			
			vo.setKakaoId(cookies[1].getValue());
			
		}

		String result = service.join(vo);
		
		/*
		if(cookies != null) {
			//ssl문서가 아닌경우 쿠키 이용이 제한된다. 삭제안됨
			
			for (int i = 0; i < cookies.length; i++) {
	            cookies[i].setMaxAge(0); // 유효시간을 0으로 설정
	            response.addCookie(cookies[i]); // 응답에 추가하여 만료시키기.
	        }
			 
		}
		*/
		return "redirect:/user/login";
		
	}
	
	@RequestMapping(value="/user/search", method = RequestMethod.GET)
	public String search() {
		
		return "/user/search";
	}
	
	//아이디 중복체크
	@RequestMapping(value="/duple/id", method = RequestMethod.POST)
	public String dupleId(UserVO vo, ModelMap model) {
				
		String result = service.dupleId(vo);
		
		//방법2 jsonView
		if(result == null) {
			model.addAttribute("res", "dupleSuc");
		} else {
			model.addAttribute("res", "dupleFail");
		}
		
		return "jsonView";
		
		/*
		//방법1 type Map<String, Object>
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(result == "") {
			map.put("res", "good");
		} else {
			map.put("res", "bad");
		}
		
		return map;
		*/
			
	}
	
	@RequestMapping(value="/user/logout" , method = RequestMethod.GET)
	public String logout() {
		
		hs.userSession().invalidate();
		
		return "redirect:/user/login";
	}
	
	@ResponseBody
	@RequestMapping(value="/user/getKakaoAuthUrl", method = RequestMethod.GET)
	public String kakaoLogin() {
		
		String reqUrl = 
				"https://kauth.kakao.com/oauth/authorize"
				+ "?client_id=2dcf89a26d35b1bdefb99a137e907076"				//ResAPI key
				+ "&redirect_uri=http://jangport.tplinkdns.com/user/oauth_kakao"	//Redirect URl
				+ "&response_type=code";
		
		return reqUrl;
	}
	
	@RequestMapping(value="/user/oauth_kakao", method = RequestMethod.GET)
	public String kakaoLogin(HttpServletRequest request
							, HttpServletResponse response
							, @RequestParam(value = "code", required = false) String code
							, Model model
							) throws Exception {
		
        String access_Token = utils.getAccessToken(code);     
        
        //HashMap<String, Object> userInfo = utils.getUserInfo(access_Token);
        String kakaoId = utils.getUserInfo(access_Token);
        
        UserVO result = service.kakaoIdChk(kakaoId);
        
        //db에 같은 id가 있는지 확인 한 후 있으면 로그인, 없으면 회원가입 페이지로 이동
        if(result != null) {
        	
        	return "redirect:/board/list";
        } else {
        	
        	Cookie cookie = new Cookie("kakaoId", kakaoId);
        	cookie.setPath("/");
        	cookie.setMaxAge(60*60);		//1시간
        	response.addCookie(cookie);
        	
        	return "redirect:/user/join";
        }
        
        
        /*
        JSONObject kakaoInfo = new JSONObject();
        
        for(Map.Entry<String, Object> entry : userInfo.entrySet()) {
        	kakaoInfo.put(entry.getKey(), entry.getValue());
        }
        
        model.addAttribute("kakaoInfo", kakaoInfo);
        
        return "";
        */

	}
	
	/*
	//아이디 찾기
	@RequestMapping(value="/user/searchId", method = RequestMethod.POST)
	public String searchId(UserVO param, Model model) {
		
		System.out.println(param.getNm());
		System.out.println(param.getEmail());
		
		model.addAttribute("userId", service.searchId(param));
		
		return "/user/search";
	}
	
	//비밀번호 찾기
	@RequestMapping(value="/user/searchPw", method = RequestMethod.POST)
	public String searchPw(UserVO param, Model model) {
		
		model.addAttribute("userPw", service.searchPw(param));
		
		return "/user/search";
	}
	
	
	@RequestMapping(value="/user/myinfo", method = RequestMethod.GET)
	public String myInfo(HttpSession hs, Model model) {
		
		model.addAttribute("myInfoProfile", service.getProfileImg(hs));
		
		return "/user/myinfo";
	}
	
	@RequestMapping(value="/user/chgpw", method = RequestMethod.GET)
	public String chgpw() {
		
		return "user/chgpw";
	}
	
	@RequestMapping(value="/user/chgpw", method = RequestMethod.POST)
	public ModelAndView chgpw(UserVO param, HttpSession hs, ModelAndView mav, String chgUpw) {
		
		int result = service.chgpw(param, hs, chgUpw);
		
		if(result == 1) {
			mav.addObject("message", "변경되었습니다");
		} else {
			mav.addObject("message", "현재 비밀번호가 일치하지 않습니다");
		}
		
		return mav;
	}
	
	@RequestMapping(value="/user/chgInfo", method = RequestMethod.GET)
	public String chgInfo() {
		
		return "user/chgInfo";
	}
	
	@RequestMapping(value="/user/chgInfo", method = RequestMethod.POST)
	public String chgInfo(UserVO vo, HttpSession hs, Model model) {
		
		int result = service.chgInfo(vo, hs);
		
		if(result == 1) {
			
			UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
			
			loginUser.setNm(vo.getNm());
			loginUser.setZoneCode(vo.getZoneCode());
			loginUser.setRoadAddr(vo.getRoadAddr());
			loginUser.setDetailAddr(vo.getDetailAddr());
			loginUser.setPh(vo.getPh());
			
		}
		
		return "redirect:/user/myinfo";
	}
	/*
	@RequestMapping(value="/user/profile", method = RequestMethod.GET)
	public String uploadProfile(Model model, HttpSession hs) {
		
		model.addAttribute("myProfile", service.getProfileImg(hs));
		
		return "user/profile";
	}
	
	@RequestMapping(value="/user/profile", method = RequestMethod.POST)
	public String uploadProfile(@RequestParam("uploadProfile") MultipartFile file
			, HttpSession hs) {
		
		if(!file.isEmpty()) {
			service.uploadProfile(file, hs);
		}
		
		return "redirect:/user/profile";
	}
	
	@RequestMapping(value="/user/delProfile", method = RequestMethod.GET)
	public String delProfile(HttpSession hs) {
		
		service.delProfileParent(hs);
		
		return "redirect:/user/profile";
	}
	*/
	
		
	
}
