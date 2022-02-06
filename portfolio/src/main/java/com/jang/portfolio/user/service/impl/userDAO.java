package com.jang.portfolio.user.service.impl;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Repository;

@Repository("userDAO")
public class userDAO extends AbstractUserDAO {

	public String join(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException{
		return (String)selectOne("userDAO.join", vo);	
	}
	
	public UserVO login(UserVO vo) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		return (UserVO)selectOne("userDAO.login", vo);
	}
	
	public String dupleId(UserVO vo) { 
		
		return (String)selectOne("userDAO.dupleId", vo); 
	}
	
	public UserVO kakaoIdChk(String kakaoId) {
		return selectOne("userDAO.kakaoIdChk", kakaoId);
	}
	public int updUser(UserVO vo) {
		return 1;
	}
	
	public String chkpw(UserVO vo) {
		return null;
	}
	
	public UserVO searchId(UserVO vo) {
		return null;
	}
	
	public UserVO searchPw(UserVO param) {
		return null;
	}
	
}
