package com.board.board.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.board.board.ReplyV0;

@Repository
public class ReplyDAOImpl implements ReplyDAO {

	@Inject
	private SqlSession sqlSession;
	private static String namespace = "board.board.mapper.BoardMapper";

	@Override
	public void createReply(ReplyV0 replyV0) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert(namespace + ".createReply", replyV0);

	}
	@Override
	public ReplyV0 readReply(Integer number) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".readReply",number);
	}
	@Override
	public ReplyV0 lastReply() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace+".readLastReply");
	}

	@Override
	public List<ReplyV0> readReplys(Integer number) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(namespace + ".readReplys", number);
	}

	@Override
	public void deleteReply(Integer number) throws Exception {
		// TODO Auto-generated method stub

	}

	@Override
	public List<ReplyV0> readSubReplys(Integer boardNumber, Integer parentNumber) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNumber", boardNumber);
		map.put("parentNumber", parentNumber);

		return sqlSession.selectList(namespace + ".readSubReplys", map);
	}

}
