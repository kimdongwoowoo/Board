package com.board.board.dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.board.LoginDTO;
import com.board.board.UserV0;

@Repository
public class UserDAOImpl implements UserDAO {
	@Inject
	private SqlSession sqlSession;
	private static String namespace = "board.board.mapper.UserMapper";

	@Override
	public UserV0 login(LoginDTO loginDTO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".login",loginDTO);
	}

	@Override
	public void register(UserV0 userV0) throws Exception {
		sqlSession.insert(namespace + ".register", userV0);
		// TODO Auto-generated method stub

	}
}
