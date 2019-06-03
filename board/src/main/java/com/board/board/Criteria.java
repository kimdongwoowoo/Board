package com.board.board;

//현재 페이지, 한페이지에 몇 개의 글을 뿌릴 것인가를 결정하는 클래스.
//페이지를 바꿀때도 계속 크리테리아 객체는 살아있다. 파라미터로 계속 토스해야함.
public class Criteria {
	private int page;
	private int perPageNum;
	public Criteria() {
		this.page=1; //첫페이지는 1
		this.perPageNum=10; //한페이지에 10개 게시글
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		if(page<=0)
			this.page=1;
		else
			this.page = page;
	}
	
	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	
	
	/*아래 두 메소드로 한 페이지의 목록을 갖고온다. 
	  LIMIT start번호=startNumber, 개수=perPageNum
	  
	 */
	/*기본 멤버 getter가 아니고 추후 DB매퍼에서 #{startNumber}를 쓸때 사용하기위한 메소드.
	pageStart -> 자동으로 getStartNumber 를 호출하게된다.*/
	public int getStartNumber() {
		return (this.page-1)*perPageNum; //(현재페이지-1)*한페이지에 뿌릴 게시물개수==시작번호
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	
}
