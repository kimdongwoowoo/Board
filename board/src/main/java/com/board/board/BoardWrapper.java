package com.board.board;

import java.util.List;
public class BoardWrapper {
	BoardV0 boardV0; //본문
	List<ReplyWrapper> replys; //댓글
	public BoardV0 getBoardV0() {
		return boardV0;
	}
	public void setBoardV0(BoardV0 boardV0) {
		this.boardV0 = boardV0;
	}
	public List<ReplyWrapper> getReplys() {
		return replys;
	}
	public void setReplys(List<ReplyWrapper> replys) {
		this.replys = replys;
	}
	
}
