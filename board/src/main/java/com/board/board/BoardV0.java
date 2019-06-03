package com.board.board;

import java.util.Date;

import org.springframework.context.annotation.Configuration;

public class BoardV0 {
	private Integer number;
	private String title;
	private String content;
	private String writer;
	private String password;
	private Date regDate;
	private int replyCnt;
	private int viewCnt;
	public int getReplyCnt() {
		return replyCnt;
	}
	public void setReplyCnt(int replyCnt) {
		this.replyCnt = replyCnt;
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
	
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getViewCnt() {
		return viewCnt;
	}
	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}
	public void setNumber(Integer number) {
		this.number = number;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public BoardV0() {
		// TODO Auto-generated constructor stub
	}
	
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String toString() {
		String ret="";
		ret+="번호:"+this.number+"\n";
		ret+="제목:"+this.title+"\n";
		ret+="내용:"+this.content+"\n";
		ret+="작성자:"+this.writer+"\n";
		ret+="조회수:"+this.viewCnt+"\n";
		return ret;
	}
}
