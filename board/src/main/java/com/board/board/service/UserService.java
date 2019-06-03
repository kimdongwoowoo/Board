package com.board.board.service;

import com.board.board.LoginDTO;
import com.board.board.UserV0;

public interface UserService {
	void register(UserV0 userV0) throws Exception;
	UserV0 login(LoginDTO loginDTO) throws Exception;
	
}
