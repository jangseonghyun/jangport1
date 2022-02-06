<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>디테일</title>
<link rel="stylesheet" type="text/css" href="/resources/css/Detail.css">
</head>
<body>

	<div class="container">
		
		<div class="logo">
            <div>
                <a href="/board/list">승현's 포트폴리오</a>
            </div>
	   	</div>

		<div class="content">
			
			<div class="content_1">
				
				<div class="content_1_1">
                    <p>제목</p>
                    <p>${data.title}</p>
                </div>
				
				 <div class="content_1_2">
				 	<p>작성자</p>
				 	<p>${data.nm}</p>
				 	<p>작성일</p>
                    <p>${data.r_dt}</p>
                </div>
                
				<div class="content_1_3">
					<p>내용</p>
					<p>${data.ctnt}</p>
				</div>
				
                <div class="content_1_4">
                	<c:if test="${loginUser.i_user == data.i_user}">
						<div><a href="/board/mod?i_board=${data.i_board}"><button>수정</button></a></div>
						<div><a href="/board/del?i_board=${data.i_board}"><button>삭제</button></a></div>
					</c:if>
				</div>
				<!-- 
				<div class="content_1_5">
					<a href="/board/list"><button>목록</button></a>
				</div>
				
				<div class="comment" class="layout">
					
					<form action="/cmt/inscmt" method="post" onsubmit="return chk()">
                        <textarea name="cmt"></textarea>
                        <input type="submit" value="댓글쓰기">
                    </form>
                    
				
				${cmt.ctnt}
				${cmt.nm}
				${cmt.r_dt}
				
				
					
				</div>
				-->
			</div>
			
		</div>
		
		<div class="footer">
           <div>&copy; 승현's 포트폴리오</div>
		   <div>대구시 달서구 감삼동 702</div>
		   <div>010-2052-2719</div>
		</div>
		
	</div>
</body>
</html>