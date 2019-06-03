package com.board.board.controller.user;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.board.LoginDTO;
import com.board.board.UserV0;
import com.board.board.service.UserService;

@Controller
public class UserLoginController {
	@Inject
	UserService userService;
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginGET() throws Exception{
		return "login"; //login.jsp
	}
	
	
	@RequestMapping(value="login",method=RequestMethod.POST)
	@ResponseBody
	public int loginPOST(LoginDTO loginDTO) throws Exception{
		UserV0 userV0=userService.login(loginDTO);
		if(userV0==null)
			return 2;
		else if(!userV0.getUserPw().equals(loginDTO.getUserPw()))
			return 3;
		return 1;
	}
	
	
	
}
