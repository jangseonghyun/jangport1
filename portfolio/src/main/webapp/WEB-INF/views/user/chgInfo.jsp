<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/chgInfo.css">
<title>정보변경</title>
</head>
<body>

	<div id="container">

        <div id="logo">
            
            <div id="logo_1">
                <a href="/board/list">승현's 포트폴리오</a>
            </div>

            <div id="dropdown" class="logo_2">
                <button id="dropbtn">정보변경</button>
                <div id="dropdown_content">
                    <a href="/user/chgInfo">기본 정보변경</a>
                    <a href="/user/chgpw">비밀번호 변경</a>
                    <a href="/user/profile">프로필 변경</a>
                </div>
            </div>

        </div>

        <div id="content">
			
			<div id="content_1">
			
				<div id="content_1_1">
					<h2>정보변경</h2>
				</div>
				
	            <div id="content_1_2">
	                
	                <form id="frm" action="/user/chgInfo" method="POST" onsubmit="return chk()">
	                    <div><input type="text" name="nm" placeholder="이름" value="${loginUser.nm}"></div>
	                    <div><input type="text" name="ph" placeholder="휴대폰번호" value="${loginUser.ph}"></div>
	                    <div><input type="text" name="addr" placeholder="주소" value="${loginUser.addr}"></div>
                        <div><input type="submit" value="정보수정"></div>
                        <div id="cancel"><a href="/user/myinfo"><button>취소</button></a></div>
	                    <!-- 비동기통신 하고싶다...
	                    <div>
	                        <input type="password" name="e_mail">
	                        <button type="button"></button>
	                    </div>
	                    -->
	                </form>
	                
	            </div>
			</div> 
        </div>

        <div id="footer">
            <div>&copy;승현's 포트폴리오</div>
            <div>대구시 달서구 감삼동 702</div>
            <div>010-2052-2719</div>
        </div>

    </div>
    
    <script>
    	var nm = frm.nm.value
    	var ph = frm.ph.value
    	var addr  = frm.addr.value
    	
    	if(nm == ''){
    		alert('이름을 입력해주세요')
    		return false
    	} else if(ph == ''){
    		alert('휴대폰 번호를 입력해주세요');
    		return false
    	} else if(addr == ''){
    		alert('주소를 입력해주세요');
    		return false
    	}
    </script>
</body>
</html>