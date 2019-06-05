package com.board.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AuthInterceptor extends HandlerInterceptorAdapter {
	Logger logger=LoggerFactory.getLogger(AuthInterceptor.class);
	@Override
	//프리핸들에서 빠꾸시켜버리면되기때문에 포스트핸들은 필요도없다.
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("auth intercepted...!");
		HttpSession httpSession=request.getSession();
		if(httpSession.getAttribute("login")==null) {
			logger.info("no authority");
			response.sendRedirect("login");
			return false;
			
		}
		return super.preHandle(request, response, handler);
	}
	
	


}
