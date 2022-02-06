package com.jang.portfolio.common;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletWebRequest;
import org.springframework.web.multipart.MultipartFile;

import com.jang.portfolio.user.service.impl.UserVO;

public class Utils {

	public UserVO getInfo() {

		ServletWebRequest servletContainer = (ServletWebRequest) RequestContextHolder.getRequestAttributes();

		HttpServletRequest request = servletContainer.getRequest();

		HttpSession hs = request.getSession();
		UserVO vo = (UserVO) hs.getAttribute("loginUser");

		return vo;
	}

	// 리턴값 : 지정된 파일명
	// "/resources/user/pk값/파일명
	public static String saveFile(String path, MultipartFile file) {

		String fileNm = null;
		UUID uuid = UUID.randomUUID(); // 유일한 식별자 생성

		// 확장자 얻기
		// file의 확장자를 얻는다
		String ext = FilenameUtils.getExtension(file.getOriginalFilename());
		System.out.println("ext : " + ext);

		// 유일한 식별자.확장자
		fileNm = String.format("%s.%s", uuid, ext);
		System.out.println("fileNm : " + fileNm);

		// 파일주소
		String saveFileNm = String.format("%s/%s", path, fileNm);
		System.out.println("saveFileNm : " + saveFileNm);

		File saveFile = new File(saveFileNm);
		saveFile.mkdirs();

		try {
			file.transferTo(saveFile); // 파일 데이터를 지정한 file로 저장
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

		return fileNm;
	}

	public static boolean deleteFile(String filePath) {

		boolean result = false;

		File file = new File(filePath);

		if (file.exists()) {
			result = file.delete();
		}

		return result;
	}
}
