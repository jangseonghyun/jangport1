package com.jang.portfolio.board.service.impl;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.jang.portfolio.board.service.BoardImgVO;
import com.jang.portfolio.board.service.BoardRatingVO;
import com.jang.portfolio.board.service.BoardService;
import com.jang.portfolio.common.Utils;
import com.jang.portfolio.user.service.impl.UserVO;
import com.jang.portfolio.util.LoginUserSession;


@Service("BoardService")
public class BoardServiceImpl implements BoardService{

	@Resource(name="BoardDAO")
	private BoardDAO boardDAO;
	
	@Resource(name="LoginUserSession")
	private LoginUserSession hs;
	//CRUD
	
	//글등록
	public int insBoard(BoardVO vo) {
		
		UserVO loginUser = (UserVO)hs.userSession().getAttribute("loginUser");
		
		vo.setNm(loginUser.getNm());
		vo.setI_user(loginUser.getI_user());	
		
		int result = boardDAO.insBoard(vo);
	
		return result;
		
	}
	
	//글 갯수
	public int getBoardListCnt() {
		return boardDAO.getBoardListCnt();
	}
		
	//게시판
	public List<BoardVO> selBoardList(BoardVO vo) {
		return boardDAO.selBoardList(vo);
	}
	
	//게시판 디테일
	public List<BoardVO> selBoard(BoardVO param) {
		
		//UserVO loginUser = (UserVO)hs.getAttribute("loginUser");
		//param.setI_user(loginUser.getI_user());
		
		return boardDAO.selBoard(param);
	}
	
	//아작스 검색
	public List<BoardVO> ajaxSearch(BoardVO vo) {
		
		return boardDAO.ajaxSearch(vo);
	}
	
	public int getAjaxSearchCnt(BoardVO vo) {
		return boardDAO.getAjaxSearchCnt(vo);
	}
	
	//엑셀다운로드
	public void excelDownLoad(BoardVO vo, HttpServletResponse response, String[] param) {
        		
		try {
	        Workbook workbook = new HSSFWorkbook();
	        //시트생성
	        Sheet sheet = workbook.createSheet("게시판");
	        
	        //행, 열, 열번호
	        Row row = sheet.createRow((short)0);
	        Cell cell = null;
	        
	        // 테이블 헤더용 스타일
	        CellStyle headStyle = workbook.createCellStyle();
	
	        // 가는 경계선을 가집니다.
	        headStyle.setBorderTop(BorderStyle.THIN);
	        headStyle.setBorderBottom(BorderStyle.THIN);
	        headStyle.setBorderLeft(BorderStyle.THIN);
	        headStyle.setBorderRight(BorderStyle.THIN);
	
	        // 배경색은 노란색입니다.
	        headStyle.setFillForegroundColor(HSSFColorPredefined.YELLOW.getIndex());
	        headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
	
	        // 데이터는 가운데 정렬합니다.
	        headStyle.setAlignment(HorizontalAlignment.CENTER);
	
	        // 데이터용 경계 스타일 테두리만 지정
	        CellStyle bodyStyle = workbook.createCellStyle();
	        bodyStyle.setBorderTop(BorderStyle.THIN);
	        bodyStyle.setBorderBottom(BorderStyle.THIN);
	        bodyStyle.setBorderLeft(BorderStyle.THIN);
	        bodyStyle.setBorderRight(BorderStyle.THIN);
	        
	        //헤더 정보 구성
	        
	        for(int i = 0; i < param.length; i++) {
	        	
	        	cell = row.createCell(i);
		        cell.setCellValue(param[i].toString());
		        cell.setCellStyle(headStyle);
		        
	        }
	        
	        int cnt = 0;
	        
	        List<BoardVO> voList = boardDAO.excelDownLoad(param);
	        
		    for(int rowIdx = 0; rowIdx < voList.size(); rowIdx++) {
		    	
				vo = (BoardVO)voList.get(rowIdx);
				
				//행 생성
				row = sheet.createRow(rowIdx+1);
				
				for(int i = 0; i < param.length; i++) {
					
					cell = row.createCell(cnt++);

					//잊지말자..문자열 비교는 .equlas() == 이거 아니다...				
					if(param[i].equals("i_board")) {
						cell.setCellValue(vo.getI_board());
					} else if(param[i].equals("title")){
						cell.setCellValue(vo.getTitle());
					} else if(param[i].equals("ctnt")){
						cell.setCellValue(vo.getCtnt());
					} else if(param[i].equals("r_dt")){
						cell.setCellValue(vo.getR_dt());
					} else if(param[i].equals("cnt")){
						cell.setCellValue(vo.getCnt());
					} else if(param[i].equals("i_user")){
						cell.setCellValue(vo.getI_user());
					} else if(param[i].equals("nm")){
						cell.setCellValue(vo.getNm());
					} else if(param[i].equals("is_del")){
						cell.setCellValue(vo.getIs_del());
					} 
				}
				
				cnt = 0;
		    }
				
	        String fileName ="boardInfo.xls";
	       
	        response.setContentType("ms_vnd/excel");
	        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\";");
	        
	        // 엑셀 출력
	        workbook.write(response.getOutputStream());
	        workbook.close();
	        
		} catch (IOException e) {
	        e.printStackTrace();
	    }
        
	}
	
	//별점 및 댓글작성
	public int rating(BoardRatingVO param) {
		return 1;
	}
	
	//
	public List<BoardRatingVO> selRating(BoardRatingVO param){	
		return boardDAO.selRating(param);
	}	
	
	
		
	//이미지 리스트
	public List<BoardImgVO> selImgList(BoardImgVO param){
		
		return boardDAO.selImgList(param);
	}
		
	//이미지 업로드
	public int uploadImg(MultipartFile file) {
		
		UserVO loginUser = (UserVO)hs.userSession().getAttribute("loginUser");
		
		String realPath = hs.userSession().getServletContext().getRealPath("/");
		String imgFolder = realPath + "/resources/img/board";
		
		String fileNm = Utils.saveFile(imgFolder, file);
		
		BoardImgVO param = new BoardImgVO();
		param.setI_user(loginUser.getI_user());
		param.setImg(fileNm);
		
		int result = boardDAO.uploadImg(param);
		
		return result;
	}
	
	//게시글 삭제
	public void delBoard(BoardVO vo) {
		
		boardDAO.delBoard(vo);

	}
		
	//이미지 삭제
	public void delImg(BoardImgVO param) {
		
		boardDAO.delImg(param);
	}
		
}
