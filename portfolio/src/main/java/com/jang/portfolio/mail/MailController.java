package com.jang.portfolio.mail;

import java.io.IOException;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/member")
public class MailController {

	@Inject
	private JavaMailSender mailSender;
	
	private String rand = "";
	private String email = "";
	private static final int CNT = 4;		//인증번호 자리수
	private static final Logger logger = 
	LoggerFactory.getLogger(MailController.class);
	
	//mailsend
	@RequestMapping(value="/auth", method = RequestMethod.POST)
	public String mailSending(Model model, HttpServletRequest request
			, HttpServletResponse response_email) throws IOException{
		
		for(int i=0; i<CNT; i++) {
			int a = (int)(Math.random() *10);
			rand += a;
		}
		
		System.out.println("rand:" +rand);
		
		String setfrom = "tmd2052@gmail.com";
		String tomail = request.getParameter("e_mail");
		String title = "회원가입 인증메일 입니다.";
		String content = "인증번호는 " +rand+ " 입니다";
		
		email = tomail;
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "utf-8");
			
			messageHelper.setFrom(setfrom);
			messageHelper.setTo(tomail);
			messageHelper.setSubject(title);
			messageHelper.setText(content);
			
			mailSender.send(message);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		
		return "member/email_injeung";
	}

	@RequestMapping(value="/email" , method = RequestMethod.GET)
	public String email() {
		return "member/email";
	}
	
	//이메일로 받은 인증번호를 입력하고 전송버튼을 누르면 매핑되는 메소드
	//내가 입력한 인증번호와 메일로 입력한 인증번호가 맞는지 확인해서 맞으면 회원가입 페이지로 넘어가고,
	//틀리면 다시 원래 페이지로 돌아오는 메소드
	//@PathVariable은 
	//@RequestMapping(value="/member/join_injeung={rand}", method = RequestMethod.POST)
	//@PathVariable
	@RequestMapping(value="/join_injeung", method = RequestMethod.POST)
	public String join_injeung(Model model, String inputNum
			, HttpServletResponse response_equals, HttpServletRequest request) throws IOException{
		
		System.out.println("랜덤한 인증번호 :" +rand);
		System.out.println("사용자 입력 인증번호 : " +inputNum);
		
		//인증번호가 일치할 경우
		//만약 인증번호가 같다면 이메일을 회원가입 페이지로 같이 넘겨준다.
		if(inputNum.equals(rand)) {
		
			model.addAttribute("mail", email);
			
			rand = "";
			email = "";
			
			return "user/join";

		} else if (inputNum != rand) {
	       
            model.addAttribute("injeung", "인증번호가 일치하지 않습니다.");
  
            return "member/email_injeung";
            
		}
		return null;
	}
	
	@RequestMapping(value="/email_injeung", method = RequestMethod.GET)
	public String join_injeung() {
		return "member/email_injeung";
	}
}
