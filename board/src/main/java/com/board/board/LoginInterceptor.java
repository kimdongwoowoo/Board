package com.board.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("intercepted...!");
		
		
		
		/*HttpSession httpSession=request.getSession();
		ModelMap modelMap=modelAndView.getModelMap();
		Object userV0=modelMap.get("user"); //login컨트롤러에서 로그인성공시 매핑해놓은 정보
		if(userV0!=null) {
			logger.info("new login session");
			logger.info(httpSession.toString());
			httpSession.setAttribute(LOGIN, userV0);
			//이거 수행후 콜백함수로 돌아감
		}
		else
			logger.info("session error");
		*/
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		/*	
		HttpSession httpSession = request.getSession();
		if (httpSession.getAttribute(LOGIN) != null) // 기존에 로그인했으면 제거
		{
			logger.info("clear login data before");
			httpSession.removeAttribute(LOGIN);
		}
		*/
		return true;
		
	}
	

}
