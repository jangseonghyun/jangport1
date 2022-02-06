<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시판</title>
<link rel="stylesheet" type="text/css" href="/resources/css/list.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<body>
	<div class="container">

        <jsp:include page="../common/header.jsp" flush="false" />

        <div class="content">
        
            <p>${loginUser.nm }님 어서오세요!</p>
            
            <div>
	            <a href="/user/logout"><button>로그아웃</button></a>
	            <a href="/board/publicData"><button>공공데이터</button></a>
	            <a href="/board/excelDown"><button>DB-Excel 다운로드</button></a>
	            <!-- 
	            <a href="/user/myinfo"><button>내 정보</button></a>
	            <a href="/board/imglist"><button>이미지 보드</button></a>
	            <a href="/board/Rating">레이팅</a> 
	            -->
            </div>
            
            <div class="content_1">
                <div class="layout">NO</div>
                <div class="layout">제목</div>
                <div class="layout">작성자</div>
                <div class="layout">작성일자</div>
                <!--
                <div id="content_1_5" class="layout">조회수</div>
                <div id="content_1_6">좋아요</div>
                -->
            </div>
			
			<div class="mainContent">
			
            <c:forEach items="${newData}" var="item">
            
	            <div class="content_1" onclick="moveToDetail(${item.i_board})">
	            		
		                <div id="itemIdx" class="layout">${item.i_board}</div>
		                <div id="itemTitle" class="layout">${item.title}</div>
		                <div id="itemNm" class="layout">${item.nm}</div>
		                
		                <c:set var="value" value="${item.r_dt }"/>
		                <c:set var="day" value="${fn:substring(value, 0, 16)}"/>
		                
		                <div id="itemDay" class="layout">${day}</div>
		                <!--
		                <div class="layout">${item.cnt}</div>
		                <div id="content_1_6"></div>
	                	-->
				</div>
				
			</c:forEach>
			
			</div>
			
			<div class="modal-boss" id="modal-boss" style="position:absolute; display:none;">
			
				<div class="modal-child">
					
					<div class="cancel" onclick="cancel()">
						X
					</div>
					
					<div class="modal-child1">
	                    <p>제목</p>
	                    <p id="title"></p>
	                </div>
					
				 	<div class="modal-child2">
					 	<p>작성자</p>
					 	<p id="writer"></p>
					 	<p>작성일</p>
	                    <p id="regDate"></p>
	                </div>
	                
					<div class="modal-child3">
						<p>내용</p>
						<p id="regContent"></p>
					</div>
				
	                <div class="modal-child4">        
						
					</div>
					
					<div class="modal-uploadFile">
					
					</div>
					
					 <div class="modal-child5">
					 	
					 </div>
					 
				</div>
				
			</div>
			 
			<!-- ajax 페이징 -->
			<div class="pagingList">
				
					<c:if test="${pagination.prev}">
						<div class="li_deco">
							<a href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a>
						</div>
					</c:if>
	
					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<div class="li_deco"<c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
							<a href="#" onclick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')"> ${idx} </a>
						</div>
					</c:forEach>
	
					<c:if test="${pagination.next}">
						<div class="li_deco">
							<a href="#" onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')" >Next</a>
						</div>
					</c:if>
				
			</div>

            <div class="content_2">
                <a href="/board/insBoard"><button>글쓰기</button></a>
            </div>
            
            <form id="frm2" class="content_3">
            	<select name="selOption" id="selOption">
            		<option value="onlyTitle">제목</option>
            		<option value="onlyCtnt">내용</option>
            		<option value="sumTitCtnt">제목+내용</option>
            	</select>
            	<input type="text" id="searchWord" name="searchWord" placeholder="검색어를 입력하세요" onKeypress="javascript:if(event.keyCode==13) { return false; }">
            	<button type="button" onclick="searchFrm()">검색</button>
            </form>
            
        </div>

        <jsp:include page="../common/footer.jsp" flush="false" />

    </div>
    
    <script>
    //서치 이전Range
    function sch_prev(page, range, rangeSize, selOption, searchWord){
    	
    	let prevRange = range - 1;
    	let prevPage = page - 1;
    	
    	let contents = '';
    	let itemIdx = document.getElementById('itemIdx');
    	let itemTitle = document.getElementById('itemTitle');
    	let itemNm = document.getElementById('itemNm');
    	let itemDate = document.getElementById('itemDate');
    	
    	$.ajax({
       		type : 'POST',
       		dataType : "json",
       		url : "/board/ajaxSearch",
       		data :{ 
       			searchWord : searchWord,
       			selOption : selOption,
       			page : prevPage,
       			range : prevRange
       		},
       		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       		success : function(data) {
       			
       			//초기화
				contents = '';
				
				//페이징
				let paging = '';
				let range = data.pagination.range;
				let page = data.pagination.page;
				let startpage = data.pagination.startPage;
				let endpage = data.pagination.endPage;
				let rangeSize = data.pagination.rangeSize;
				let totRange = Math.ceil(data.pagination.pageCnt / rangeSize);
     
       			for(let num = 0; num < data.newData.length; num++){
       				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
       				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
       				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
   		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
   		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
       			}
       			
       			//이전 Range
				if(prevRange > 1){
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="sch_prev(' + page + ', ' + prevRange + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Previous</a>';
					paging += '</div>';
				}
       		
       			for (let num = startpage; num <= endpage; num++) {
   					paging += '<div class="li_deco">';
   					paging += '<a href="#" onclick="sch_pagination(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')">' + num + '</a>';
   					paging += '</div>';
   					
   					//다음 range가 있는지
   	    			if(range < totRange && num == endpage){
   		    			paging += '<div class="">';
   		    			paging += '<a href="#" onclick="sch_next(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Next</a>';
   		    			paging += '</div>'
   		    		}
   					
                 }
       			 
       			 $('.mainContent').html(contents);
    	         $('.pagingList').html(paging);
       		},
       		error : function(err){
       			console.log(err);
       		}
       	})
       	
    }
    
    //다음 Range 
    function sch_next(page, range, rangeSize, selOption, searchWord){
    	
    	let nxtRange = range + 1;
    	let nxtPage = page + 1;
    	
    	let contents = '';
    	let itemIdx = document.getElementById('itemIdx');
    	let itemTitle = document.getElementById('itemTitle');
    	let itemNm = document.getElementById('itemNm');
    	let itemDate = document.getElementById('itemDate');
    	
    	$.ajax({
       		type : 'POST',
       		dataType : "json",
       		url : "/board/ajaxSearch",
       		data :{ 
       			searchWord : searchWord,
       			selOption : selOption,
       			page : nxtPage,
       			range : nxtRange
       		},
       		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       		success : function(data) {
       			
       			//초기화
				contents = '';
				
				//페이징
				let paging = '';
				let range = data.pagination.range;
				let page = data.pagination.page;
				let startpage = data.pagination.startPage;
				let endpage = data.pagination.endPage;
				let rangeSize = data.pagination.rangeSize;
				let totRange = data.pagination.pageCnt / rangeSize;
				
       			for(let num = 0; num < data.newData.length; num++){
       				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
       				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
       				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
   		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
   		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
       			}
     			
				//이전 Range
				if(range > 1){
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="sch_prev(' + page + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Previous</a>';
					paging += '</div>';
				}
				
       			for (let num = startpage; num <= endpage; num++) {
   					paging += '<div class="li_deco">';
   					paging += '<a href="#" onclick="sch_pagination(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')">' + num + '</a>';
   					paging += '</div>';
   					
   					//다음 range가 있는지
   	    			if(range < totRange && num == endpage){
   		    			paging += '<div class="">';
   		    			paging += '<a href="#" onclick="sch_next(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Next</a>';
   		    			paging += '</div>'
   		    		}
   					
                 }
       			 
       			 $('.mainContent').html(contents);
    	         $('.pagingList').html(paging);
       		},
       		error : function(err){
       			console.log(err);
       		}
       	})
       	
    }
    
    function sch_pagination(page, range, rangeSize, selOption, searchWord) {
    	
    	let prevRange = range - 1;
    	//게시판
    	let contents = '';
    	let itemIdx = document.getElementById('itemIdx');
    	let itemTitle = document.getElementById('itemTitle');
    	let itemNm = document.getElementById('itemNm');
    	let itemDate = document.getElementById('itemDate');
    	
   		$.ajax({
       		type : 'POST',
       		dataType : "json",
       		url : "/board/ajaxSearch",
       		data :{ 
       			searchWord:searchWord,
       			selOption:selOption,
       			page:page,
       			range:range
       		},
       		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       		success : function(data) {
       			
       			//초기화
				contents = '';
				
				//페이징
				let paging = '';
				let range = data.pagination.range;
				let page = data.pagination.page;
				let startpage = data.pagination.startPage;
				let endpage = data.pagination.endPage;
				let rangeSize = data.pagination.rangeSize;
				let totRange = data.pagination.pageCnt / rangeSize;
       			
				//이전 Range
				if(range > 1){
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="sch_prev(' + page + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Previous</a>';
					paging += '</div>';
				}
				
       			for(let num = 0; num < data.newData.length; num++){
       				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
       				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
       				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
   		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
   		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
       			}
       			
       			for (let num = startpage; num <= endpage; num++) {
   					paging += '<div class="li_deco">';
   					paging += '<a href="#" onclick="sch_pagination(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')">' + num + '</a>';
   					paging += '</div>';
   					
   					//다음 range가 있는지
   	    			if(range < totRange && num == endpage){
   		    			paging += '<div class="">';
   		    			paging += '<a href="#" onclick="sch_next(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Next</a>';
   		    			paging += '</div>'
   		    		}
   					
                 }
       			 
       			 $('.mainContent').html(contents);
    	         $('.pagingList').html(paging);
       		},
       		error : function(err){
       			console.log(err);
       		}
       	})
    	
    }
    
    function searchFrm(){
    	
    	let searchWord = document.getElementById('searchWord').value;
    	let selOption = document.getElementById('selOption').value;
    	
    	//게시판
		let contents = '';
		let itemIdx =  document.getElementById('itemIdx');
    	let itemTitle =  document.getElementById('itemTitle');
    	let itemNm =  document.getElementById('itemNm');
    	let itemDate =  document.getElementById('itemDate');
		
   		$.ajax({
       		type : "POST",
       		dataType : "json",
       		url : "/board/ajaxSearch",
       		data : { 
       			searchWord:searchWord,
       			selOption:selOption,
       		},
       		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
       		success : function(data) {
   
       			if(data.newData.length <= 0){
       				alert('검색 결과가 없습니다.');
       				return;
       			} 
       			
       			//초기화
				contents = '';
				
				//페이징
				let paging = '';
				let range = data.pagination.range;
				let page = data.pagination.page;
				let startpage = data.pagination.startPage;
				let endpage = data.pagination.endPage;
				let rangeSize = data.pagination.rangeSize;
				let totRange = data.pagination.pageCnt / rangeSize;
       			
       			for(let num = 0; num < data.newData.length; num++){
       				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
       				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
       				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
   		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
   		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
       			}
       			
       			for (let num = startpage; num <= endpage; num++) {
   					paging += '<div class="li_deco">';
   					paging += '<a href="#" onclick="sch_pagination(' + num + ', ' + range + ', ' + rangeSize + ',' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')">' + num + '</a>';
   					paging += '</div>';
   					
   					//다음 range가 있는지
   	    			if(range < totRange && num == endpage){
   		    			paging += '<div class="li_deco">';
   		    			paging += '<a href="#" onclick="sch_next(' + num + ', ' + range + ', ' + rangeSize + ', ' + "'" + selOption + "'" + ', ' + "'" + searchWord + "'" + ')"> Next</a>';
   		    			paging += '</div>'
   		    		}
   					
                 }
       			 
       			 $('.mainContent').html(contents);
    	         $('.pagingList').html(paging);
       		},
       		error : function(err){
       			console.log(err);
       		}
       	})

    }
    
  	//이전 버튼 이벤트
    function fn_prev(page, range, rangeSize) {

    	let prevPage = ((range - 2) * rangeSize) + 1;
   		let prevRange = range - 1;
   		
   		$.ajax({
   			type : 'GET',
   			url : '/board/ajaxPaging',
   			dataType : 'json',
   			data : {
   				page : prevPage,
   				range : prevRange
   			},
   			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   			success : function(data) {
   			//html 소스
    			//게시판
    			let contents = '';
    			let itemIdx =  document.getElementById('itemIdx');
		    	let itemTitle =  document.getElementById('itemTitle');
		    	let itemNm =  document.getElementById('itemNm');
		    	let itemDate =  document.getElementById('itemDate');
		    	
		    	//페이징
    			let paging = '';
    			let page = data.pagination.page;
    			let startpage = data.pagination.startPage;
    			let endpage = data.pagination.endPage;
    			let totRange = Math.ceil(data.pagination.pageCnt / data.pagination.rangeSize);
    			
    			for(let num = 0; num < data.newData.length; num++){
    				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
    				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
    				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
    			}
    			
    			//이전 Range
				if(prevPage > 1){
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_prev(' + page + ', ' + prevRange + ', ' + rangeSize + ')"> Previous</a>';
					paging += '</div>';
				}
    			
    			console.log("endpage : "+endpage);
    			console.log("range : " +range);
    			console.log("totRange : "+totRange);
    			
    			for (let num = startpage; num <= endpage; num++) {
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_pagination(' + num + ', ' + prevRange + ', ' + rangeSize + ')">' + num + '</a>';
					paging += '</div>';
					
					console.log(num);
					//다음 range가 있는지
	    			if(prevRange < totRange && num == endpage){
		    			paging += '<div class="">';
		    			paging += '<a href="#" onclick="fn_next(' + num + ', ' + prevRange + ', ' + rangeSize + ')"> Next</a>';
		    			paging += '</div>'
		    		}
					
                 }
    			 
    			 $('.mainContent').html(contents);
 	             $('.pagingList').html(paging);
   			}, 
   			error : function (err) {
   				console.log(err);
   			}
   		})
   		
		/*
   		let Page = ((range - 2) * rangeSize) + 1;
   		let range = range - 1;
   		let url = "${pageContext.request.contextPath}/board/list";
   		
   		url = url + "?page=" + prevPage;
   		url = url + "&range=" + range;

   		location.href = url;
   		*/
    }

  	//페이지 번호 클릭
	function fn_pagination(page, range, rangeSize) {
	
		$.ajax({
    		url: "/board/ajaxPaging",
    		dataType :"json",
    		type : "GET",
    		data : {
    			page : page,
    			range : range
    		},
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		success: function(data){
    			//html 소스
    			//게시판
    			let contents = '';
    			let itemIdx =  document.getElementById('itemIdx');
		    	let itemTitle =  document.getElementById('itemTitle');
		    	let itemNm =  document.getElementById('itemNm');
		    	let itemDate =  document.getElementById('itemDate');
		    	
		    	//페이징
    			let paging = '';
    			let page = data.pagination.page;
    			let startpage = data.pagination.startPage;
    			let endpage = data.pagination.endPage;
    			let totRange = Math.ceil(data.pagination.pageCnt / data.pagination.rangeSize);
    			
    			for(let num = 0; num < data.newData.length; num++){
    				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
    				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
    				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
    			}
    			
    			//이전 Range
				if(range > 1){
					let prevRange = range;
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_prev(' + page + ', ' + prevRange + ', ' + rangeSize + ')"> Previous</a>';
					paging += '</div>';
				}
    			
    			for (let num = startpage; num <= endpage; num++) {
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_pagination(' + num + ', ' + range + ', ' + rangeSize + ')">' + num + '</a>';
					paging += '</div>';
					
					//다음 range가 있는지
	    			if(range < totRange && num == endpage){
		    			paging += '<div class="">';
		    			paging += '<a href="#" onclick="fn_next(' + num + ', ' + range + ', ' + rangeSize + ')"> Next</a>';
		    			paging += '</div>'
		    		}
                 }  			
    			 
    			 $('.mainContent').html(contents);
 	             $('.pagingList').html(paging);
    		},
    		error : function(err) {
    			console.log(err);
    		}
    	})
	  	/*
    	var url = "${pageContext.request.contextPath}/board/list";
    	url = url + "?page=" + page;
   		url = url + "&range=" + range;
    	
   		location.href = url;
   		*/
    }

   	//다음 버튼 이벤트
	//page = 페이지, range = 몇번째 칸?인지 ex 1~5=> 1 6~10 => 2, rangeSize = range 몇개가 한 묶음인지
   	function fn_next(page, range, rangeSize) {
   		
   		let nxtPage = parseInt((range * rangeSize)) + 1;
   		let nxtRange = parseInt(range) + 1;
   		
   		$.ajax({
   			type : 'GET',
   			url : '/board/ajaxPaging',
   			dataType : 'json',
   			data : {
   				page : nxtPage,
   				range : nxtRange
   			},
   			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
   			success : function(data) {
   			//html 소스
    			//게시판
    			let contents = '';
    			let itemIdx =  document.getElementById('itemIdx');
		    	let itemTitle =  document.getElementById('itemTitle');
		    	let itemNm =  document.getElementById('itemNm');
		    	let itemDate =  document.getElementById('itemDate');
		    	
		    	//페이징
    			let paging = '';
    			let page = data.pagination.page;
    			let startpage = data.pagination.startPage;
    			let endpage = data.pagination.endPage;
    			let totRange = Math.ceil(data.pagination.pageCnt / data.pagination.rangeSize);
    			
    			for(let num = 0; num < data.newData.length; num++){
    				contents += '<div class="content_1" onclick="moveToDetail('+ data.newData[num].i_board +')">';
    				contents += '<div id="itemIdx" class="layout">'+ data.newData[num].i_board +'</div>';
    				contents += '<div id="itemTitle" class="layout">'+ data.newData[num].title +'</div>';	
		            contents += '<div id="itemNm" class="layout">'+ data.newData[num].nm +'</div>';
		            contents += '<div id="itemDay" class="layout">'+ data.newData[num].r_dt +'</div></div>';
    			}
    			
    			//이전 Range
				if(nxtRange > 1){
					
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_prev(' + page + ', ' + nxtRange + ', ' + rangeSize + ')"> Previous</a>';
					paging += '</div>';
				}
    			
    			for (let num = startpage; num <= endpage; num++) {
    				
					paging += '<div class="li_deco">';
					paging += '<a href="#" onclick="fn_pagination(' + num + ', ' + nxtRange + ', ' + rangeSize + ')">' + num + '</a>';
					paging += '</div>';
					
					//다음 range가 있는지
	    			if(nxtRange < totRange && num == endpage){
		    			paging += '<div class="">';
		    			paging += '<a href="#" onclick="fn_next(' + num + ', ' + nxtRange + ', ' + rangeSize + ')"> Next</a>';
		    			paging += '</div>'
		    		}
					
                 }
 
    			 $('.mainContent').html(contents);
 	             $('.pagingList').html(paging);
   			}, 
   			error : function (err) {
   				console.log(err);
   			}
   		})
		/*
   		var page = parseInt((range * rangeSize)) + 1;
   		var range = parseInt(range) + 1;
		var url = "${pageContext.request.contextPath}/board/list";

   		url = url + "?page=" + page;
   		url = url + "&range=" + range;

   		location.href = url;
   		*/
   	}
    
	//디테일 모달창
    function moveToDetail(i_board){
    	
    	const modalBoss = document.getElementById('modal-boss');
    	const title = document.getElementById('title');
    	const writer = document.getElementById('writer');
    	const regDate = document.getElementById('regDate');
    	const regContent = document.getElementById('regContent');
    	const modal4 = document.querySelector('.modal-child4');
    	const previous = document.getElementById('prevWriting');
    	const next = document.getElementById('nextWriting');
    	
    	modalBoss.style.display = "flex";
    	
    	$.ajax({
    		type : "post",
    		dataType : "json",
    		url : "/board/detail",
    		data : { i_board : i_board },
    		contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    		success : function(data) {
    			
    			let modal = "";
    			let modal2 = "";
    			let fileUpload = "";
    			let prevNum,nextNum,prevTitle,nextTitle;
    			
    			//업로드 파일 배열
    			let fileArr = new Array();
    			
    			//오름차순 글 생성
    			if(data.detail.length == 3){    
    				
	    			title.innerText = data.detail[1].title;
	    			writer.innerText = data.detail[1].nm;
	    			regDate.innerText = data.detail[1].r_dt;
	    			regContent.innerHTML = data.detail[1].ctnt;
	    			
	    			fileArr = [data.detail[1].file1, data.detail[1].file2, data.detail[1].file3];
	    			
	    			for(let a = 0; a < fileArr.length; a++){
	    				fileUpload += '<a href="' + "/board/downLoad?down=" + fileArr[a] + '"><div>' + fileArr[a] + '</div></a>';	
	   				}
	    			
	    			prevNum = data.detail[0].i_board;
	    			nextNum = data.detail[2].i_board;
	    			prevTitle = data.detail[0].title;
	    			nextTitle = data.detail[2].title;
	    			
	    		//다음글 없음
    			} else if(data.detail.length == 2 && i_board > data.detail[0].i_board){
    				
    				title.innerText = data.detail[1].title;
	    			writer.innerText = data.detail[1].nm;
	    			regDate.innerText = data.detail[1].r_dt;
	    			regContent.innerHTML = data.detail[1].ctnt;
	    			
	    			fileArr = [data.detail[1].file1, data.detail[1].file2, data.detail[1].file3];
	    			
	   				for(let a = 0; a < fileArr.length; a++){
	   					fileUpload += '<a href="' + "/board/downLoad?down=" + fileArr[a] + '"><div>' + fileArr[a] + '</div></a>';	
	   				}
	    			
	    			prevNum = data.detail[0].i_board;
	    			prevTitle = data.detail[0].title;
	    			
	    		//이전글 없음
    			} else if(data.detail.length == 2 && i_board < data.detail[1].i_board){
    				title.innerText = data.detail[0].title;
	    			writer.innerText = data.detail[0].nm;
	    			regDate.innerText = data.detail[0].r_dt;
	    			regContent.innerHTML = data.detail[0].ctnt;
	    			
	    			fileArr = [data.detail[0].file1, data.detail[0].file2, data.detail[0].file3];
	    			
	    			for(let a = 0; a < fileArr.length; a++){
	   					fileUpload += '<a href="' + "/board/downLoad?down=" + fileArr[a] + '"><div>' + fileArr[a] + '</div></a>';	
	   				}
	    			
	    			nextNum = data.detail[1].i_board;
	    			nextTitle = data.detail[1].title;
    			}
    				
    			//수정삭제버튼
    			if(data.nmChk == "ok"){
	    			modal = '<div><button type="button" onclick="modBoard(' + i_board + ')">수정</button></div>';
					modal += '<div><button type="button" onclick="delBoard(' + i_board + ')">삭제</button></div>';
    			}

    			//다음글
    			if(nextNum != undefined) {
    				modal2 += '<div onclick="moveToDetail(' + nextNum + ')">';
    				modal2 += '<p>다음글</p>';
    				modal2 += '<p>' + nextTitle + '</p></div>';
    			} else {
	   				modal2 += '<div>';
	   				modal2 += '<p>다음글</p>';
	   				modal2 += '<p>다음글이 없습니다.</p></div>';
    			}
    			
    			//이전글
    			if(prevNum != undefined ) {
    				modal2 += '<div onclick="moveToDetail(' + prevNum + ')">';
    				modal2 += '<p>이전글</p>';
    				modal2 += '<p>'+ prevTitle + '</p></div>';
    			} else {
    				modal2 += '<div>';
    				modal2 += '<p>이전글</p>';
    				modal2 += '<p>이전글이 없습니다.</p></div>';
    			}
    			
    			$('.modal-child4').html(modal);
    			$('.modal-child5').html(modal2);
    			$('.modal-uploadFile').html(fileUpload);
				
    		},
    		error : function(err) {
    			console.log(err);
    		}
    	}) 			
    	
    }
    
    function cancel(){
    	
    	const modalBoss = document.getElementById('modal-boss');
    	modalBoss.style.display = "none";
    }
    
    function modBoard(num){
    	alert('수정 : '+num);
    	location.href="/board/insBoard?i_board="+num;
    }
    
    function delBoard(num){
    	location.href="/board/delBoard?i_board="+num;
    }
    </script>
</body>
</html>