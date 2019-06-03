package com.board.board.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.board.LoginDTO;
import com.board.board.UserV0;
import com.board.board.dao.UserDAO;

@Service
public class UserServiceImpl implements UserService{
	@Inject
	UserDAO userDAO;
	
	@Override
	public void register(UserV0 userV0) throws Exception {
		userDAO.register(userV0);
		
	}
	@Override
	public UserV0 login(LoginDTO loginDTO) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.login(loginDTO);
	}
}
