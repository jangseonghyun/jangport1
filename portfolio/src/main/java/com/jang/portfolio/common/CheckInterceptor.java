package com.jang.portfolio.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jang.portfolio.user.service.impl.UserVO;

public class CheckInterceptor extends HandlerInterceptorAdapter{

	@Override
	 public boolean preHandle(HttpServletRequest request,
	   HttpServletResponse response, Object handler) throws Exception {
	
		HttpSession hs = request.getSession();
		UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		
		if(loginUser != null) {
			return true;
		}
		
		response.sendRedirect("/user/login");
		return false;
	}
}
