package com.board.board.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.board.BoardV0;

@Repository
public class BoardDAOImpl implements BoardDAO {

	@Inject
	private SqlSession sqlSession;

	private static String namespace = "board.board.mapper.BoardMapper";

	@Override
	public void create(BoardV0 boardV0) throws Exception {
		sqlSession.insert(namespace + ".create", boardV0);
	
	}

	@Override
	public BoardV0 read(Integer number) throws Exception {
		BoardV0 boardV0=sqlSession.selectOne(namespace + ".read", number);
		boardV0.setViewCnt(boardV0.getViewCnt()+1);
		System.out.println(boardV0.getViewCnt());
		sqlSession.update(namespace+".update",boardV0);
		return boardV0;
	}

	@Override
	public void update(BoardV0 boardV0) throws Exception {
		
		sqlSession.update(namespace + ".update", boardV0);

	}

	@Override
	public void delete(Integer number) throws Exception {
		sqlSession.delete(namespace + ".delete", number);
	}

	@Override
	public List<BoardV0> listAll() throws Exception {
		return sqlSession.selectList(namespace + ".listAll");

	}

}