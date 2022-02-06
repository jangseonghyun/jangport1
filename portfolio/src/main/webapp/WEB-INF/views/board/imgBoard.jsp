<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/imgBoard.css">
<title>이미지 글작성</title>
</head>
<body>
	
	<div id="container">

        <div id="logo">
            <a href="/board/imglist">승현's 포트폴리오</a>
        </div>

        
        <div id="content">

            <div id="content_1">
                <a href="/board/list"><button>목록</button></a>
            </div>

            <div id="content_2">
            
                <form action="/board/imgBoard" method="POST" enctype="multipart/form-data" onsubmit="return chk()">

                    <input type="file" name="uploadImg" accept="image/*">
                    <input type="submit" value="이미지 올리기">

                </form>
                
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
		
		var title = frm.title.value
		var ctnt = frm.ctnt.value
		
		if(title == ''){
			alert('제목을 입력해주세요')
			return false
		} else if(ctnt == ''){
			alert('내용을 작성해주세요')
			return false
		}
		
	}
	</script>
	
</body>
</html>