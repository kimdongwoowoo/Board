package com.board.board;

import java.util.Date;

public class ReplyV0 {
	
	private Integer boardNumber; //소속 게시글 번호
	private Integer replyNumber; //댓글 고유번호
	private Integer parentNumber; //부모번호, 없으면 null
	private String content; 
	private String writer;
	private String password;
	private Date regDate;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Integer getBoardNumber() {
		return boardNumber;
	}
	public void setBoardNumber(Integer boardNumber) {
		this.boardNumber = boardNumber;
	}
	public Integer getReplyNumber() {
		return replyNumber;
	}
	public void setReplyNumber(Integer replyNumber) {
		this.replyNumber = replyNumber;
	}
	public Integer getParentNumber() {
		return parentNumber;
	}
	public void setParentNumber(Integer parentNumber) {
		this.parentNumber = parentNumber;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
}
