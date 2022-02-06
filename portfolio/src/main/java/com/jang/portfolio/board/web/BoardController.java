package com.jang.portfolio.board.web;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.json.JSONObject;
import org.json.simple.JSONArray;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jang.portfolio.board.service.BoardService;
import com.jang.portfolio.board.service.impl.BoardVO;
import com.jang.portfolio.user.service.impl.UserVO;
import com.jang.portfolio.util.ApiExplorer;
import com.jang.portfolio.util.LoginUserSession;

@Controller
public class BoardController {

	@Resource(name="BoardService")
	private BoardService service;
	
	@Resource(name="publicData")
	private ApiExplorer pd;
	
	@Resource(name="LoginUserSession")
	private LoginUserSession hs;
	
	//private static final String FILE_PATH = "/var/webapp/resources/fileUpload/";
	
	//일반 글쓰기GET
	@RequestMapping(value="/board/insBoard", method = RequestMethod.GET)
	public String insBoard(ModelMap model,
						   BoardVO vo) {
		
		List<BoardVO> newVO = service.selBoard(vo);
		//수정
		if(vo.getI_board() > 0) {
			model.addAttribute("modBoard", newVO);
			return "/board/insBoard";
		}
		
		//일반
		return "/board/insBoard";
	}
	
	//글쓰기POST
	@RequestMapping(value="/board/insBoard", method = RequestMethod.POST)
	public String insBoard(BoardVO vo,
					 	   HttpSession request,
						   ModelMap model,
						   @RequestParam("file[]")List<MultipartFile> file) throws IOException {
		
		//파일 어디 저장되는건지 찾기(찾음), 절대경로 설정하기
		String[] fileName = new String[file.size()];
		String uuid = "";		
		String[] splFileNm;
		
		
		for(int i = 0; i < file.size(); i++) {
			
			if(!file.get(i).getOriginalFilename().toString().equals("")) {
				
				uuid = UUID.randomUUID().toString().replaceAll("-", "");
				
				//파일명 공백제거
				fileName[i] = file.get(i).getOriginalFilename().toString().replaceAll(" ", "_");
				
				splFileNm = fileName[i].split("\\.");
				
				String fileNmBox = "";
				
				//최종 파일명
				if(splFileNm.length > 2) {
					
					for(int z = 0; z <= splFileNm.length-2; z++) {
						fileNmBox += splFileNm[z];
					}
					
				}
				
				//확장자 파일명 사이 UUID 추가 - 중복방지
				fileName[i] = fileNmBox + uuid + "." + splFileNm[splFileNm.length-1];
				
				String contextRoot = request.getServletContext().getRealPath("/");
				String fileRoot = contextRoot+"resources/fileUpload/";
				
				file.get(i).transferTo(new File(fileRoot, fileName[i]));
				
			}
		}
		
		vo.setFileNm(fileName);
		
		int result = service.insBoard(vo);
		
		return "redirect:/board/list";
	}
	
	//게시판 리스트
	@RequestMapping(value="/board/list", method = RequestMethod.GET)
	public String list(BoardVO vo, ModelMap model
			, @RequestParam(required = false, defaultValue = "1") int page
			, @RequestParam(required = false, defaultValue = "1") int range) {
		
		int listCnt = service.getBoardListCnt();
		
		vo.pageInfo(page, range, listCnt);
		model.addAttribute("pagination", vo);
		
		List<BoardVO> newVO = service.selBoardList(vo);
		model.addAttribute("newData", newVO);
		
		return "/board/list";
		
		/*
		vo.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", vo);
		List<BoardVO> newVO = service.selBoardList(vo);
		model.addAttribute("data", newVO);
		*/
		
	}
	
	//게시판 디테일
	@RequestMapping(value="/board/detail", method = RequestMethod.POST)
	public String selBoard(BoardVO vo, ModelMap model) {
		
		List<BoardVO> listVo = service.selBoard(vo);
		
		model.addAttribute("detail", listVo);
		
		UserVO newVo = (UserVO)hs.userSession().getAttribute("loginUser");
		
		if(listVo.get(1).getI_user() == newVo.getI_user()){
			model.addAttribute("nmChk", "ok");
		}		
		
		return "jsonView";
	}
	
	//아작스 페이징
	@RequestMapping(value="/board/ajaxPaging", method = RequestMethod.GET)
	public String ajaxPaging(BoardVO vo, ModelMap model
			, @RequestParam(required = false, defaultValue = "1") int page
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "1") int rangeSize) {
		
		int listCnt = service.getBoardListCnt();
		
		vo.pageInfo(page, range, listCnt);
		model.addAttribute("pagination", vo);
		
		List<BoardVO> newVO = service.selBoardList(vo);
		model.addAttribute("newData", newVO);
		
		return "jsonView";
	}
		
	//서머노트 이미지 업로드
	@RequestMapping(value="/board/uploadSummernoteImageFile", method = RequestMethod.POST)
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, 
			 HttpSession request, ModelMap model) {
		/*
		//HttpServletRequest request
		String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
		String fileRoot = contextRoot+"resources/fileupload/";
		*/
		
		String contextRoot = request.getServletContext().getRealPath("/");
		//String fileRoot = contextRoot+"resources/fileupload/";
		String fileRoot = "C:\\resources/fileUpload\\";		//이거는 된다.
		
		//오리지날 파일명
		String originalFileName = multipartFile.getOriginalFilename();	
		//파일 확장자
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		//저장될 파일 명
		String savedFileName = UUID.randomUUID() + extension;	
		
		File targetFile = new File(fileRoot + savedFileName);
		
		//multipartFile.transferTo(new File(fileRoot, savedFileName));
		try {
			InputStream fileStream = multipartFile.getInputStream();
			//파일 저장
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			// contextroot + resources + 저장할 내부 폴더명
			System.out.println(fileRoot+savedFileName);
			model.addAttribute("url", "/resources/fileupload/"+savedFileName); 
			model.addAttribute("responseCode", "success");
			
		} catch (IOException e) {
			//저장된 파일 삭제
			FileUtils.deleteQuietly(targetFile);	
			model.addAttribute("responseCode", "error");
			e.printStackTrace();
		}
		
		return "jsonView";
	}
	
	//아작스 검색
	@RequestMapping(value="/board/ajaxSearch", method = RequestMethod.POST)
	public String ajaxSearch(BoardVO vo, ModelMap model
			, @RequestParam(required = false, defaultValue = "1") int page
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "") String searchWord
			, @RequestParam(required = false, defaultValue = "") String selOption) { 
		
		if(selOption.equals("onlyTitle")) {
			vo.setTitle(searchWord);
		}
		
		if(selOption.equals("onlyCtnt")) {
			vo.setCtnt(searchWord);
		}
		
		if(selOption.equals("sumTitCtnt")) {
			vo.setTitle(searchWord);
			vo.setCtnt(searchWord);
		}
		
		int listCnt = service.getAjaxSearchCnt(vo);		
		
		if(listCnt <= 0) {
			model.addAttribute("newData", "");
			return "jsonView";
		}
		
		vo.pageInfo(page, range, listCnt);
		model.addAttribute("pagination", vo);
		
		List<BoardVO> result = service.ajaxSearch(vo);
		
		model.addAttribute("newData", result);
		
		return "jsonView";
	}
	
	//공공데이터
	@RequestMapping(value="/board/publicData", method = RequestMethod.GET)
	public String publicData(ModelMap model) throws IOException {
		
		//공공데이터
		String box = pd.apidata();
		
		//형변환
		JSONObject jsonObj = new JSONObject(box);
		
		//parse
		JSONParser parse = new JSONParser();
		
		//JSONArray jsonArr = (JSONArray)jsonObj.get("response");
		
		model.addAttribute("pubData", jsonObj);
		
		return "/board/publicData";
	}
	
	//db-Excel 다운로드
	@RequestMapping(value="/board/excelDown", method = RequestMethod.GET)
	public String excelDown() {
		
		return "/board/excelDown";
	}
	
	@RequestMapping(value="/board/excelDown", method = RequestMethod.POST)
	public void excelDown(BoardVO vo, HttpServletResponse response,
						@RequestParam(value = "list[]") String[] param) {
		
		service.excelDownLoad(vo, response, param);
	}
	
	//
	@RequestMapping(value="/board/delBoard", method = RequestMethod.GET)
	public String delBoard(BoardVO vo) {
		
		service.delBoard(vo);
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/board/modBoard", method = RequestMethod.GET)
	public String modBoard(BoardVO i_board) {
		
		
		return "/board/insBoard";
		
	}
		
	//파일 다운로드
	//responsebody적용 안하면 에러난다고함
	@ResponseBody
	@RequestMapping(value="/board/downLoad", method = RequestMethod.GET)
	public byte[] downLoad(HttpServletResponse response,
						   HttpSession request,
						   @RequestParam(value="down") String filename) throws IOException {
		
		String contextRoot = request.getServletContext().getRealPath("/");
		String fileRoot = contextRoot+"resources/fileUpload/";
		System.out.println(fileRoot);
		File file = new File(fileRoot, filename);
		
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		
		String fn = new String(file.getName().getBytes(), "utf-8");
		response.setHeader("Content-Disposition", "attachment;filename=\"" + fn + "\"");
		response.setContentLength(bytes.length);
		
		return bytes;
	}
	
	/*
	//이미지 글쓰기
	@RequestMapping(value="/board/imgBoard", method = RequestMethod.GET)
	public String uploadImg() {
		
		return "/board/imgBoard";
	}
	
	@RequestMapping(value="/board/imgBoard", method = RequestMethod.POST)
	public String uploadImg(@RequestParam("uploadImg") MultipartFile file
			, HttpSession hs) {
		
		service.uploadImg(file);
		
		return "redirect:/board/imglist";
	}
	
	
	//이미지 리스트
	@RequestMapping(value="/board/imglist", method = RequestMethod.GET)
	public String imglist(BoardImgVO param, Model model) {
		
		model.addAttribute("img", service.selImgList(param));
		
		return "board/imgList";
	}
	
	//이미지 디테일
	@RequestMapping(value="/board/imgdetail", method = RequestMethod.GET)
	public String imgDetail(BoardVO param) {
				
		return "/board/imgDetail";
	}
	
	
	//이미지 게시판 디테일
	@RequestMapping(value="/board/imgDetail" , method = RequestMethod.GET)
	public String imgDetail(Model model, BoardImgVO param) {
		
		//model.addAttribute("imgDetail", service.imgDetail(param);
		
		return "/board/imgDetail";
	}
		
	@RequestMapping(value="/board/delImg", method = RequestMethod.GET)
	public String delImg(BoardImgVO param) {
		
		service.delImg(param);
		
		return "redirect:/board/imgList";
	}
	
	@RequestMapping(value="/board/Rating", method= RequestMethod.GET)
	public String rating(Model model, BoardRatingVO param) {
		
		//model.addAttribute("rating", service.selRating(param));
		
		return "/board/Rating";
	}
		
	@RequestMapping(value="/board/usr_MoveDetailPro", method = RequestMethod.POST)
	public String rating(BoardRatingVO param) {

		param.setCmt_content("dd");
		param.setCmt_move("#살아있다");
		
		service.rating(param);
		
		return "/board/Rating";
	}
	
	@RequestMapping(value="/board/ajax_json", method = RequestMethod.GET)
	public String practice_json(){
		
		return "board/ajax_json";
	}
	
	@RequestMapping(value="/board/ajaxData", method = RequestMethod.POST)
	public String practice_json2(){
		
		return "board/ajaxData";
	}
	*/
}
