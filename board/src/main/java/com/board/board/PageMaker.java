package com.board.board;

public class PageMaker {
	private int totalCount;
	private int startPage;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	private int displayPageNum=10;
	private Criteria criteria;
	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}
	/*1차적으로 displayPage랑 criteria안의 현재페이지 두개로 endPage를 계산할수있다.
	하지만 총 게시물의 개수에 따라 오류가 생기기 때문에 
	ex) 현재5page, 한페이지당 10게시물, displayPageNum=10인 경우, endPage는 10이 된다.
	하지만 총 게시물 수가 100개보다 안되면 끝페이지는 잘못된거다.
	*/
	private void calcData() {
		endPage=(int)(Math.ceil(criteria.getPage()/(double)displayPageNum)*displayPageNum);
		startPage=(endPage-displayPageNum)+1; //끝페이지를 구해놓으면 시작페이지는 알수있음, 총게시물개수 상관없이 일단 구해놓고
		int tmpEndPage=(int)(Math.ceil(totalCount/(double)criteria.getPerPageNum())); //아예 마지막페이지번호를 구함
		if(endPage>tmpEndPage) //벗어나면
			endPage=tmpEndPage;
		
		prev=startPage==1?false:true; //1페이지만아니면 prev버튼 있음
		next=endPage*criteria.getPerPageNum() >= totalCount ? false : true; //끝페이지번호가 맨끝만아니면 있음
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		calcData();
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public Criteria getCriteria() {
		return criteria;
	}
	
	
	
}
