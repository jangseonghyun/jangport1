<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디/비밀번호 찾기</title>
<link rel="stylesheet" type="text/css" href="/resources/css/search.css">
</head>
<body>
	
	<div id="container">
		
		<div id="logo">
			<a href="/user/login">승현's 포트폴리오</a>
		</div>
		
		<div id="content">
			${userId.uid}
			${userPw.upw}
			<div id="content_1">
				
				<form id="frmid" action="/user/searchId" method="post" onsubmit="return chkID()">
					<div><input type="text" name="nm" placeholder="이름"></div>
					
					<div>
						<input type="text" name="email" placeholder="이메일">
						<!--<button type="button" onclick="sendMailAuthNumber()">인증번호 보내기</button>-->
					</div>
					
					<div><input type="submit" value="아이디 찾기"></div>
				</form>
				
			</div>
			
			<div id="content_2">
			
				<form id="frmpw" action="/user/searchPw" method="post" onsubmit="return chkPW()">
					
					<div><input type="text" name="uid" placeholder="아이디"></div>
					<div><input type="text" name="nm" placeholder="이름"></div>
					
					<div>
						<input type="text" name="email" placeholder="이메일">
						<!--<button type="button" onclick="sendMailAuthNumber()">인증번호 보내기</button>-->
					</div>
					
					<div><input type="submit" value="비밀번호 찾기"></div>
				</form>
			</div>
			
		</div>
		
		<div id="footer">
		   <div>&copy;승현's 포트폴리오</div>
		   <div>대구시 달서구 감삼동 702</div>
		   <div>010-2052-2719</div>     
		</div>
		
	</div>

	<script>

		function chkID(){
				
			var email = frmid.email.value
			var nm = frmid.nm.value
			

			if(email == ''){
				alert('이메일를 입력해주세요')
				return false
			} else if(nm == ''){
				alert('이름를 입력해주세요')
				return false
			} 
		}

		function chkPW(){
			
			var uid = frmpw.uid.value
			var email = frmpw.email.value
			var nm = frmpw.nm.value
			
			if(uid == ''){
				alert('이메일를 입력해주세요')
				return false
			} else if(email == ''){
				alert('이메일를 입력해주세요')
				return false
			} else if(nm == ''){
				alert('이름를 입력해주세요')
				return false
			} 
		}
		
		function sendMailAuthNumber(){
			location.href ="/member/email"
		}

	</script>
</body>
</html>