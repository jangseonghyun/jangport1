<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/excelDown.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>엑셀다운로드</title>
</head>
<body>
	<div class="container">

        <jsp:include page="../common/header.jsp" flush="false" />
        
        <div class="content">
        		
        		<p>게시판 정보 엑셀파일로 받기</p>
        		<form id="frm" class="frm" onsubmit="chk()">
        		
        			<label>
        				<input type="checkbox" name="list[]" value="i_board">
        				<a>보드넘버</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="title">
        				<a>제목</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="ctnt">
        				<a>내용</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="r_dt">
        				<a>등록일시</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="cnt">
        				<a>조회수</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="i_user">
        				<a>작성자정보1</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="nm">
        				<a>작성자정보2</a>
        			</label>
        			
        			<label>
        				<input type="checkbox" name="list[]" value="is_del">
        				<a>삭제여부</a>
        			</label>
        			
        			<input type="button" onclick="chk()" value="엑셀 다운로드">
        			
        		</form>
        </div>
        
        <jsp:include page="../common/footer.jsp" flush="false" />

    </div>
    
    <script>
    	function chk(){
    		const frm = document.getElementById('frm');
    		let list = document.getElementsByName('list[]');
    		
    		frm.method = "POST";
    		frm.action = "/board/excelDown";
    		frm.submit();
    	}
    	
    </script>
</body>
</html>