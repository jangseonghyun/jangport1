package com.jang.portfolio.board.service.impl;

import java.util.List;
import org.springframework.stereotype.Repository;

import com.jang.portfolio.board.service.BoardImgVO;
import com.jang.portfolio.board.service.BoardRatingVO;
import com.jang.portfolio.user.service.impl.AbstractUserDAO;

@Repository("BoardDAO")
public class BoardDAO extends AbstractUserDAO {
	
		//글쓰기
		public int insBoard(BoardVO vo) {
			return insert("BoardDAO.insBoard", vo);
		}
		
		//리스트	
		public List<BoardVO> selBoardList(BoardVO vo){
			return selectList("BoardDAO.selBoardList", vo);
		}
		
		//글 갯수
		public int getBoardListCnt() {
			return selectOne("BoardDAO.getBoardListCnt");
		}
		
		//디테일
		public List<BoardVO> selBoard(BoardVO vo) {
			return selectList("BoardDAO.selBoard", vo);
		}
		
		public List<BoardVO> ajaxSearch(BoardVO vo) {
			return selectList("BoardDAO.ajaxSearch", vo);
		}
		
		public int getAjaxSearchCnt(BoardVO vo) {
			return selectOne("BoardDAO.getAjaxSearchCnt", vo);
		}
		
		//엑셀다운로드
		public List<BoardVO> excelDownLoad(String[] param) {
			List<BoardVO> vo = selectList("BoardDAO.excelDownLoad", param);
			return vo;
		}
		
		//글삭제
		public void delBoard(BoardVO vo) {
			
			selectOne("BoardDAO.delBoard", vo);
		}
		
		//이미지삭제
		public void delImg(BoardImgVO vo) {
			
		}
		
		//이미지 업로드
		public int uploadImg(BoardImgVO vo) {
			return 1;
		}
		
		//이미지 리스트
		public List<BoardImgVO> selImgList(BoardImgVO vo) {
			return null;
		}
		
		//별점 및 댓글작성
		public int rating(BoardRatingVO vo) {
			return 1;
		}
		
		//댓글보기
		public List<BoardRatingVO> selRating(BoardRatingVO vo) {
			return null;
		}
}
