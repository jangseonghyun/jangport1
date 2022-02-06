<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="/resources/css/chgpw.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
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
                    <a href="/user/chgInfo">기본정보 변경</a>
                    <a href="/user/chgpw">비밀번호 변경</a>
                    <a href="/user/profile">프로필 변경</a>
                </div>

            </div>

        </div>

        <div id="content">

            <div id="content_1">
                
                <div id="content_1_1">
                    <h2>비밀번호 변경</h2>
                </div>

                <div id="content_1_2">

                    <form id="frm" action="/user/chgpw" method="post" onsubmit="return chk()">
                        <div><input type="password" placeholder="현재 비밀번호" name="upw"></div>
                        <div><input type="password" placeholder="변경할 비밀번호" name="chgUpw"></div>
                        <div><input type="password" placeholder="변경할 비밀번호 확인" name="rechgUpw"></div>
                        <div><input type="submit" value="변경"></div>
                        
                        <div id="cancel">
                        	<a href="/user/myinfo">
                        		<button type="button">취소</button>
                        	</a>
                        </div>
                        
                    </form>
                    
                </div>

            </div>

        </div>

        <div id="footer">
            
            <div>승현'S 포트폴리오</div>
            <div>010-2052-2719</div>
            <div>대구시 달서구 감삼동 702</div>

        </div>
    </div>
	
	<script>
    $(function(){
        var responseMessage = "<c:out value="${message}" />";
        if ("변경되었습니다" == responseMessage){
            alert(responseMessage)
            location.href = "/board/list"
        } else if("현재 비밀번호가 일치하지 않습니다" == responseMessage){
        	alert(responseMessage)
        	location.href= "/user/chgpw"
        }
    })
	</script>
	
    <script>

        function chk(){
            var upw = frm.upw.value
            var chgUpw = frm.chgUpw.value
            var rechgUpw = frm.rechgUpw.value

            if(upw == ''){
                alert('현재 비밀번호를 입력해주세요')
                return false
            } else if(chgUpw == ''){
                alert('변경할 비밀번호를 입력해주세요')
                return false
            } else if(rechgUpw == ''){
                alert('변경할 비밀번호 확인을 입력해주세요')
                return false
            } else if(chgUpw != rechgUpw){
                alert('변경할 비밀번호가 다릅니다')
                return false
            }
        }
        
    </script>
</body>
</html>