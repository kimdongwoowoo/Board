package com.board.board.controller.user;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.board.LoginDTO;
import com.board.board.UserV0;
import com.board.board.service.UserService;
import com.sun.xml.internal.bind.v2.runtime.unmarshaller.Intercepter;

@Controller
public class UserLoginController {
	
	Logger logger=LoggerFactory.getLogger(UserRegisterController.class);
	
	@Inject
	UserService userService;
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginGET() throws Exception{
		logger.info("loginGET...");
		return "login"; //login.jsp
	}
	
	@RequestMapping(value="interceptorTest",method=RequestMethod.GET)
	public String intercepterTest() throws Exception{
		return "interceptor_test";
	}
	
	
	@RequestMapping(value="loginPost",method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> loginPOST(LoginDTO loginDTO,HttpServletRequest request) throws Exception{
		logger.info("loginPost...");
		Map<String,Object> map=new HashMap<>();
		UserV0 userV0=userService.login(loginDTO);
		if(userV0==null)
			map.put("code",new Integer(2));
		
		else if(!userV0.getUserPw().equals(loginDTO.getUserPw()))
			map.put("code",new Integer(3));
		
		
		//검증이 끝난후에 세션에 키밸류 추가
		HttpSession httpSession = request.getSession();
		if (httpSession.getAttribute("login") != null) // 기존에 로그인했으면 제거
		{
			logger.info("clear login data before...");
			httpSession.removeAttribute("login");
		}
		logger.info("login session making...");
		httpSession.setAttribute("login", userV0);
		map.put("code",new Integer(1));
		map.put("destination", httpSession.getAttribute("destination"));
		return map;
	}
	
	@RequestMapping(value="logout",method=RequestMethod.GET)
	public void logout(HttpServletRequest request,HttpServletResponse response) throws Exception {
		request.getSession().removeAttribute("login");
		response.sendRedirect("/board");
	}
	
	
}
