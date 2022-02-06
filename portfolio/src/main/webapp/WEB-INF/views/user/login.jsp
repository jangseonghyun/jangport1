<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
	<link rel="stylesheet" type="text/css" href="/resources/css/login.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	
	<div class="container">
        
        <jsp:include page="../common/header.jsp" flush="false" />
		
		<div class="content">
			
			<div class="content_1">
                
                <div class="login">
                    <h1>로그인</h1>
                </div>

				<div class="content_1_1">
                    ${logfail}
					<form class="frm" action="/user/login" method="post" onsubmit="return loginChk()">
						<div><input type="text" name="uid" placeholder="아이디"></div>
						<div><input type="password" name="upw" placeholder="비밀번호"></div>
						<div><input type="submit" value="로그인"></div>
					</form>
					
					<button type="button" onclick="kakaoLogin()">카카오 로그인</button>	
					<button type="button" onclick="send()">회원가입</button>
					<!-- <button type="button" onclick="">아이디/비밀번호 찾기</button> -->
					
				</div>
				
			</div>
					
		</div>
		
		<jsp:include page="../common/footer.jsp" flush="false" />
		
	</div>
	
	<script>
	    
		function kakaoLogin(){
			
			$.ajax({
				url : "/user/getKakaoAuthUrl",
				type : "GET",
				async : false,
				dataType : "text",
				success : function(res){
					location.href = res;
				}
			})
		}
		
		function moveSearch(){
				location.href = "/user/search"
		}
		
		function send(){
			
			location.href = "/user/join";
						
		}
		
		function loginChk(){
			
			var uid = frm.uid.value
			var upw = frm.upw.value
			
			if(uid == ''){
				alert('아이디를 입력해주세요')
				return false
			} else if(upw == ''){
				alert('비밀번호를 입력해주세요')
				return false
			}
		}
	</script>
</body>
</html>