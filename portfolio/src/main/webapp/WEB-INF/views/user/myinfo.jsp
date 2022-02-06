<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내정보</title>
<link rel="stylesheet" type="text/css" href="/resources/css/myinfo.css">
</head>
<body>
	<div id="container">

        <div id="logo">
            <div><a href="/board/list">승현's 포트폴리오</a></div>
        </div>

        <div id="content">

            <div id="content_1">
                
                <div id="profile">
                    
                    <div id="myprofile">
                        <h2>나의 프로필</h2>
                    </div>

                    <div id="myprofile" class="myprofile_layout">
                    
                        <div id="myprofile_1">
                            <img id="profileImg" src="${myInfoProfile}">
                        </div>
                        
                        <div id="myprofile_2">   
                            	${loginUser.nm}
                        </div>
                        
                    </div>

                    <div id="myprofile">
                        <a href="/user/profile"><button formmethod="GET">수정</button></a>
                    </div>

                </div>

                <div id="otherInfo">
                    
                    <div id="info">
                        <h2>정보 변경</h1>
                    </div>

                    <div id="info" class="layout">
                        
                        <div class="info_content">
                        	<div class="info_content_1">
                        		이름 
                        	</div>
                        	
                        	<div class="info_content_1">
                        		${loginUser.nm}
                        	</div>
                        </div>
                        
                        <div class="info_content">
                        	<div class="info_content_1">
                        		주소
                        	</div>
                        	
                        	<div class="info_content_1">
                        		${loginUser.addr}
                        	</div>
                        </div>
                        
                        <div class="info_content">
                        	<div class="info_content_1">
                        		휴대폰
                        	</div>
                        	
                        	<div class="info_content_1">
                        		${loginUser.ph}
                        	</div>
                        </div>
                        
                    </div>

                    <div id="info">
                        <a href="/user/chgInfo"><button style="width:200px; height:24px;">수정</button></a>
                    </div>
                </div>
                
            </div>

            <div id="content_2">


                    <div id="chgpw">
                        
                        <div id="chgpw_1">
                            <h2>비밀번호</h2>
                        </div>

                        <div id="chgpw_1">

                        </div>

                        <div id="chgpw_1">
                            <a href="/user/chgpw"><button>변경하기</button></a>
                        </div>

                    </div>

                    <div id="blank">
                    
                    </div>

            </div>

        </div>

        <div id="footer">
            <div>&copy;승현's 포트폴리오</div>
            <div>대구시 달서구 감삼동 702</div>
            <div>010-2052-2719</div>
        </div>

    </div>
</body>
</html>