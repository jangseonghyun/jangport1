package com.jang.portfolio.board.service.impl;

public class BoardVO {
	
	private int i_user;
	private int i_board;
	private String title;
	private String ctnt;
	private String r_dt;
	private String nm;
	private String img;
	private int cnt;
	private int is_del;
	private int boardPrev;
	private String file1;
	private String file2;
	private String file3;
	private String[] fileNm;
	
	public String getFile1() {
		return file1;
	}
	
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	
	public String getFile2() {
		return file2;
	}
	
	public void setFile2(String file2) {
		this.file2 = file2;
	}
	
	public String getFile3() {
		return file3;
	}
	
	public void setFile3(String file3) {
		this.file3 = file3;
	}

	
	
	public String[] getFileNm() {
		return fileNm;
	}
	public void setFileNm(String[] fileNm) {
		this.fileNm = fileNm;
	}

	private int boardNxt;
	//페이징
	private int listSize = 2;
	private int rangeSize = 5;
	private int page;
	private int range;
	private int listCnt;
	private int pageCnt;
	private int startPage;
	private int startList;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	public int getBoardPrev() {
		return boardPrev;
	}
	public void setBoardPrev(int boardPrev) {
		this.boardPrev = boardPrev;
	}
	public int getBoardNxt() {
		return boardNxt;
	}
	public void setBoardNxt(int boardNxt) {
		this.boardNxt = boardNxt;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getI_user() {
		return i_user;
	}
	public void setI_user(int i_user) {
		this.i_user = i_user;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public int getI_board() {
		return i_board;
	}
	public void setI_board(int i_board) {
		this.i_board = i_board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCtnt() {
		return ctnt;
	}
	public void setCtnt(String ctnt) {
		this.ctnt = ctnt;
	}
	public String getR_dt() {
		return r_dt;
	}
	public void setR_dt(String r_dt) {
		this.r_dt = r_dt;
	}
	public int getCnt() {
		return cnt;
	}
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}
	public int getIs_del() {
		return is_del;
	}
	public void setIs_del() {
		this.cnt = is_del;
	}
	
	//페이징
	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	public int getRangeSize() {
		return rangeSize;
	}
	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRange() {
		return range;
	}
	public void setRange(int range) {
		this.range = range;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getStartList() {
		return startList;
	}
	public void setStartList(int startList) {
		this.startList = startList;
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

	public void pageInfo(int page, int range, int listCnt) {

		this.page = page;

		this.range = range;

		this.listCnt = listCnt;

		//전체 페이지수 listSize = 2 23/2 = 11.5 -> 12
		this.pageCnt = (int)Math.ceil(listCnt/(double)listSize);

		//시작 페이지 rangeSize = 5
		this.startPage = (range - 1) * rangeSize + 1 ;

		//끝 페이지
		this.endPage = range * rangeSize;
		
		//게시판 시작번호
		this.startList = (page - 1) * listSize;

		//이전 버튼 상태
		this.prev = range == 1 ? false : true;

		//다음 버튼 상태
		this.next = endPage > pageCnt ? false : true;
		
		if (this.endPage > this.pageCnt) {

			this.endPage = this.pageCnt;
			this.next = false;
		}
	}
}