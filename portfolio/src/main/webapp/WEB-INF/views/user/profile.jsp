<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/profile.css">
<title>프로필 변경</title>
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
                프로필 사진
            </div>

            <div id="content_2">

                <div id="content_2_1">
                    <img id="id_profile" src="${myProfile}">
                </div>
                 
                <div id="content_2_2">

                    <a href="/user/delProfile"><button>기본 이미지 설정</button></a>
            
                    <form id="frm" action="/user/profile" method="post" enctype="multipart/form-data" onsubmit="return chk()">
                        <input type="file" name="uploadProfile" accept="image/*">
                        <input type="submit" value="적용">
                    </form>

                </div>
        
            </div>

        </div>
        
        
		
		<div id="footer">
			<div>&copy; 승현's 포트폴리오</div>
			<div>대구시 달서구 감삼동 702</div>
			<div>010-2052-2719</div>
		</div>
		
	</div>
	
	<script>
		function chk(){
			
			if(frm.uploadProfile.value == ''){
				alert('이미지를 선택해 주세요')
				return false
			}
		}
	</script>
</body>
</html>