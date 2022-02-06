<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/list.css">

<title>이미지 게시판</title>
</head>
<body>
	
	<div id="container">

        <div id="logo">
        
            <div>
                <a href="/board/list">승현's 포트폴리오</a>
            </div>
            
        </div>

        <div id="content">
  			
  			<div>
				<a href="/board/imgBoard"><button>글쓰기</button></a>
	        </div>
	            
            <div id="content_2">
                       
	            <c:forEach items="${img}" var="item">
	            	
	            	<div onclick="moveToDetail(img_board)">
	            		<a href="/board/imgDetail">
	            			<img id="imgsize" src="/resources/img/board/${item.img}">
	            		</a>
	            	</div>
	            	
	            </c:forEach>
    
            </div>
            
        </div>

        <div id="footer">
            <div>&copy; 승현's 포트폴리오</div>
            <div>대구시 달서구 감삼동 702</div>
            <div>010-2052-2719</div>
         </div>

    </div>
    
    <script>
    	function moveToDetail(img_board){
    		location.href="/board/imgDetail="+img_board
    	}
    </script>
</body>
</html>