package com.board.board.dao;

import java.util.List;

import com.board.board.ReplyV0;

public interface ReplyDAO {
	public void createReply(ReplyV0 replyV0) throws Exception;
	List<ReplyV0> readReplys(Integer number) throws Exception;
	public void deleteReply(Integer number) throws Exception;
	//public List<ReplyV0> listAllReply() throws Exception;
	List<ReplyV0> readSubReplys(Integer boardNumber,Integer parentNumber) throws Exception;
	ReplyV0 lastReply() throws Exception;
	ReplyV0 readReply(Integer number) throws Exception;
	public void updateReply(ReplyV0 replyV0) throws Exception;
	int getBoardNumber(Integer replyNumber) throws Exception;
}
