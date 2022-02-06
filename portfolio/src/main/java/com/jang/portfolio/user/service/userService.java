package com.jang.portfolio.user.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import com.jang.portfolio.user.service.impl.UserVO;

public interface userService {
	
	public String login(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException ;
	public String join(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException;
	public String dupleId(UserVO vo);
	public UserVO searchId(UserVO vo);
	public UserVO searchPw(UserVO vo);
	public int chgpw(UserVO vo, HttpSession hs, String chgpw);
	public int chgInfo(UserVO vo, HttpSession hs);
	public UserVO kakaoIdChk(String kakaoId);
}
