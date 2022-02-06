<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
</head>
<body>
	
	${injeung}
	<a href="/user/login">승현's 포트폴리오</a>
	<div style="text-align:center;">
		<form action="/member/join_injeung" method="post">                  
			
			<div>
				인증번호 입력 : 
				<input type="number" name="inputNum" placeholder="인증번호를 입력하세요.">
			</div>         
			
			<div>                               
				<button type="submit" name="submit">인증번호 전송</button>
 			</div>
                  
        </form>
	</div>
</body>
</html>