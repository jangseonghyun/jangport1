<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/resources/css/insBoard.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src=" https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.18/lang/summernote-ko-KR.min.js"></script>
<script src="/resources/summernote/summernote-lite.js"></script>
<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
  
<title>글쓰기</title>
</head>
<body>
	
	<div class="container">

        <jsp:include page="../common/header.jsp" flush="false"/>

        
        <form class="content" action="/board/insBoard" method="POST" enctype="multipart/form-data">
        	
        	<c:choose>
        	
	        	<c:when test="${empty modBoard.title}">
	        	
			        	<input class="title" type="text" name="title" placeholder="제목" >
			        	<textarea class="summernote" name="ctnt" >
			        	
			        	</textarea>
			        	
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">
			        	
			    </c:when>
		    	
		    	<c:otherwise>
		    	
		    			<input class="title" type="text" name="title" placeholder="제목" value="${modBoard.title }">
			        	<textarea class="summernote" name="ctnt" >
			        		${modBoard.ctnt }
			        	</textarea>
			        	
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">
			        	<input type="file" name="file[]" multiple="multiple" onchange="fileUpload(this)">

		    	</c:otherwise>
		    </c:choose>
		    
        	<div class="subBtn">
	        	<input type="button" value="취소" onclick="location.href='/board/list'">
	        	<input type="submit" value="글쓰기">
        	</div>
        	
			<!--
            <div id="content_1">
                <a href="/board/list"><button>목록</button></a>
            </div>

            <div id="content_2">
                <form action="/board/insBoard" method="POST" onsubmit="return chk()">
                    <input type="text" name="title" value="">
                    <textarea name="ctnt"></textarea>
                  	 이미지만 받을 수 있게 설정
                    <input type="file" name="uploadImg" accept="image/*">
                    <input type="submit" value="글쓰기">

                </form>
            </div>
            -->
        </form>

        <jsp:include page="../common/footer.jsp" flush="false" />
        
    </div>
	
	<script>
	
	function fileUpload(ths){
		
		let temp = ths.value;
		let fileType = temp.lastIndexOf(".");

		if(temp.substring(fileType+1, ths.length).toLowerCase() == "exe"){
			alert('허용되지 않은 확장자 입니다..');
			ths.value = "";
			return false;
		}
		
	}
	
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
	
	// 툴바생략
	var setting = {
		 width:1200,
		 maxWidth:1200,
		 minWidth:1200,
         height : 400,
         minHeight : 400,
         maxHeight : 400,
         focus : true,
         lang : 'ko-KR',

         //콜백 함수
         callbacks : { 
         	onImageUpload : function(files, editor, welEditable) {
               // 파일 업로드(다중업로드를 위해 반복문 사용)        
	           for (var i = files.length - 1; i >= 0; i--) {
	           		uploadSummernoteImageFile(files[i], this);
	           }
          	}
         }
      }
	
      $('.summernote').summernote(setting);
      
	  //등록 이미지 갯수
	  let imgCnt = 0;
	  
	  //이미지 삭제 시 등록이미지 갯수 빼기
	  let noteRemove = document.querySelector('.note-remove');
	  
	  noteRemove.onclick = function() {
		  imgCnt--;
	  }
	  
      function uploadSummernoteImageFile(file, el) {
    	
    	
		var data = new FormData();
		data.append("file", file);
		
		$.ajax({
			 type : "POST",
			 url:"/board/uploadSummernoteImageFile",
			 data : data,
			 contentType : false,
			 enctype: "multipart/form-data",
			 processData: false,
			 success : function(data) {
				imgCnt++;
				if(data.responseCode == "success" && imgCnt < 4){
					$(el).summernote('editor.insertImage', data.url);
				} else {
					alert('등록 이미지 3개 초과');
				}
			  	
			 }
		})
      }
	</script>
</body>
</html>