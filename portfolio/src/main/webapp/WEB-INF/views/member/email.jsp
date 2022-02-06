<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 인증</title>
</head>
<body>
	
		<div style="text-align:center;">
                
			<form id="frm" action="/member/auth" method="post" onsubmit="return chk()"> 
				
				<div>
					이메일 : <input type="email" name="e_mail"
                                placeholder=" 이메일주소를 입력하세요.">
				</div>                                                    
				
				<div>	
					<button type="submit" name="submit">이메일 인증받기 (이메일 보내기)</button>
 
                </div>
                
			</form>
		</div>
	
	<script>
		var email = frm.e_mail.value
		
		if(email == ''){
			alert('이메일을 입력해주세요')
			return false
		}
	</script>

</body>
</html>