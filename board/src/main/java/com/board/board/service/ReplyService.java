package com.board.board.service;

import java.util.List;

import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;

public interface ReplyService {
	public void createReply(ReplyV0 repyV0) throws Exception;
	List<ReplyWrapper> readReplys(Integer number) throws Exception;
	public void deleteReply(Integer number) throws Exception;
	//public List<ReplyV0> listAllReply() throws Exception;
	public ReplyV0 lastReply() throws Exception;
	public ReplyV0 readReply(Integer number) throws Exception;
	public void updateReply(ReplyV0 replyV0) throws Exception;
}
