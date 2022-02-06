package com.jang.portfolio.board.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartFile;

import com.jang.portfolio.board.service.impl.BoardVO;

public interface BoardService {
	
	//글쓰기
	public int insBoard(BoardVO vo);
	
	//리스트
	public List<BoardVO> selBoardList(BoardVO vo);
	
	//글 갯수
	public int getBoardListCnt();
	
	//디테일
	public List<BoardVO> selBoard(BoardVO param);
	
	//아작스 검색
	public List<BoardVO> ajaxSearch(BoardVO vo);
	
	//아작스 검색 갯수
	public int getAjaxSearchCnt(BoardVO vo);
	
	//이미지 리스트
	public List<BoardImgVO> selImgList(BoardImgVO param);
	
	//엑셀다운로드
	public void excelDownLoad(BoardVO vo, HttpServletResponse response, String[] param);
	//이미지 업로드
	public int uploadImg(MultipartFile file);	
	
	//글삭제
	public void delBoard(BoardVO vo);
	
	//이미지삭제
	public void delImg(BoardImgVO param);
	
	//별점 및 댓글작성
	public int rating(BoardRatingVO param);
	
	//댓글보기
	public List<BoardRatingVO> selRating(BoardRatingVO param);
	
		
}
