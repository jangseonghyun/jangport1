package com.jang.portfolio.user.service.impl;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.jang.portfolio.user.service.userService;
import com.jang.portfolio.util.AES256Util;
import com.jang.portfolio.util.LoginUserSession;


@Service("userService")
public class userServiceImpl implements userService{

	@Resource(name="userDAO")
	private userDAO userDAO;
	
	@Resource(name="AES256Util")
	private AES256Util aes;
	
	@Resource(name="LoginUserSession")
	private LoginUserSession hs;
	
	//crud (create, read, update, delete)
	
	//회원가입 (0: 아이디 중복, 1: 회원가입 완료)
	public String join(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
			
		//암호화 aes-256
		vo.setUpw(aes.encrypt(vo.getUpw()));
		
		String result = userDAO.join(vo);
		
		return result;
	}
	
	//로그인 
	public String login(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		/*
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpSession hs = request.getSession(true);
		*/
		String result = "";
		
		vo.setUpw(aes.encrypt(vo.getUpw()));
		
		UserVO newVO = userDAO.login(vo);
		
		if(newVO != null) {
		
			newVO.setUpw(null);
			hs.userSession().setAttribute("loginUser", newVO);
			
			result = "loginSuc";
			
		} else {
			result = "loginFail";
		}
		
		return result;
	}
	
	public String dupleId(UserVO vo) {
		
		String result = userDAO.dupleId(vo);	
		
		return result; 
	}
	
	public UserVO searchId(UserVO param) {
		
		return userDAO.searchId(param);
	}
	
	public UserVO searchPw(UserVO param) {
		
		System.out.println(param.getUpw());
		return userDAO.searchPw(param);
	}
	
	//0 : 현재 비밀번호 틀림, 1 : 성공
	public int chgpw(UserVO param, HttpSession hs, String chgUpw) {
		
		int result = 0;
		
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		param.setI_user(loginUser.getI_user());
		
		//입력 비밀번호
		String inputUpw = param.getUpw();

		//디비에 저장된 비밀번호
		String dbUpw = userDAO.chkpw(param); 
		
		if(inputUpw.equals(dbUpw)) {
			param.setUpw(chgUpw);
			result = userDAO.updUser(param);
		}
		
		return result;
	}
	
	public UserVO kakaoIdChk(String kakaoId) {
		
		UserVO kakaoIdChk = userDAO.kakaoIdChk(kakaoId);
		
		if(kakaoIdChk != null) {
			hs.userSession().setAttribute("loginUser", kakaoIdChk);
		}
		
		return kakaoIdChk;
	}
	
	public int chgInfo(UserVO param, HttpSession hs) {
		
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		param.setI_user(loginUser.getI_user());
		
		return userDAO.updUser(param);
	}
		
		
	/*
	//
	public void delProfileParent(HttpSession hs) {
		
		delProfile(hs);
		
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		//DB profileImg에 빈칸 넣기
		UserVO param = new UserVO();
		param.setI_user(loginUser.getI_user());
		param.setProfile("");
		
		userDAO.updUser(param);
	}
	//프로필 삭제
	public void delProfile(HttpSession hs) {
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		String realPath = hs.getServletContext().getRealPath("/");
		String imgFolder = realPath + "/resources/img/user/" + loginUser.getI_user();
		
		UserVO dbUser = userDAO.login(loginUser);
		if(!"".equals(dbUser.getProfile())) {
			String imgPath = imgFolder + "/" + dbUser.getProfile();
			Utils.deleteFile(imgPath);
		}
	}
	
	public void uploadProfile(MultipartFile file, HttpSession hs) {
		
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		delProfile(hs);
		
		String realPath = hs.getServletContext().getRealPath("/");
		String imgFolder = realPath + "/resources/img/user/"+loginUser.getI_user();
		
		String fileNm = Utils.saveFile(imgFolder, file);
		
		UserVO param = new UserVO();
		param.setI_user(loginUser.getI_user());
		param.setProfile(fileNm);
		
		userDAO.updUser(param);
	}
	
	public String getProfileImg(HttpSession hs) {
		String profileImg = null;
		
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		UserVO dbResult = userDAO.login(loginUser);
		
		profileImg = dbResult.getProfile();
		
		if(profileImg == null || profileImg.equals("")) {
			profileImg = "/resources/img/base_profile.jpg";
		} else {
			profileImg = "/resources/img/user/" + loginUser.getI_user() + "/" + profileImg;
		}
		return profileImg;
	}
	*/
}
