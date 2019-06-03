package com.board.board.controller.user;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.board.UserV0;
import com.board.board.service.UserService;

@Controller
public class UserRegisterController {
	@Inject
	UserService userService;
	
	@RequestMapping(value="register", method=RequestMethod.GET)
	public String registerGET() throws Exception{
		return "register"; //register.jsp
	}
	
	@RequestMapping(value="register", method=RequestMethod.POST)
	@ResponseBody
	public int registerPOST(UserV0 userV0) throws Exception{
		//암호화 해야됨		
		userService.register(userV0);
		return 1;
	}
	
}
