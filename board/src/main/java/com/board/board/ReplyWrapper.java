package com.board.board;

import java.util.List;

public class ReplyWrapper {
	ReplyV0 replyV0; //본댓글
	List<ReplyV0> subReplys; //대댓글
	public ReplyV0 getReplyV0() {
		return replyV0;
	}
	public void setReplyV0(ReplyV0 replyV0) {
		this.replyV0 = replyV0;
	}
	public List<ReplyV0> getSubReplys() {
		return subReplys;
	}
	public void setSubReplys(List<ReplyV0> subReplys) {
		this.subReplys = subReplys;
	}
	
}
