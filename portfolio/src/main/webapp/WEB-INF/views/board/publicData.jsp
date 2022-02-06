<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공공데이터</title>
<link rel="stylesheet" type="text/css" href="/resources/css/publicData.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div class="container">

        <jsp:include page="../common/header.jsp" flush="false" />
		
		
		
        <div class="content">
			
			<div style="width:100%; text-align:center;">공공데이터 - 기상청 지진정보 조회서비스</div>
			        	
        	<div>
        		<p>location</p>
        		<p>img</p>
        		<p>stnId</p>
        		<p>mt</p>
        		<p>cnt</p>
        		<p>lon</p>
        		<p>inT</p>
        		<p>dep</p>
        		<p>tmEqk</p>
        		<p>tmSeq</p>
        		<p>fcTp</p>
        		<p>rem</p>
        		<p>lat</p>
        	</div>
        	
        </div>
        
        <jsp:include page="../common/footer.jsp" flush="false" />
        
    </div>
    
   
    <script>
    	
    	//자바스크립트 JSON 파싱을 통한 데이터 처리
    	window.onload = function() {
    		
    		let pageNo,loc,img,stnId,mt,cnt,lon,inTt,dep,tmEqk,tmSeq,fcTp,rem,lat;
    		
    		//JSON 이렇게 선언해야한다
    		let a = '${pubData}';
    		
    		let temp = JSON.parse(a);
    		
    		//item length
    		let itemSize = temp.response.body.items.item.length;
    		
    		//html
    		let htmlTmp = "";
    		
    		let shortenJson = temp.response.body.items.item;
    		
    		for(let i = 0; i < itemSize; i++){
    			
    			loc = shortenJson[i].loc;
    			img = shortenJson[i].img;
    			stnId = shortenJson[i].stnId;
    			mt = shortenJson[i].mt;
    			cnt = shortenJson[i].cnt;
    			lon = shortenJson[i].lon;
    			inTt = shortenJson[i].inT;
    			dep = shortenJson[i].dep;
    			tmEqk = shortenJson[i].tmEqk;
    			tmSeq = shortenJson[i].tmSeq;
    			fcTp = shortenJson[i].fcTp;
    			rem = shortenJson[i].rem;
    			lat = shortenJson[i].lat;
    			
    			htmlTmp = "<div>";
    			htmlTmp += "<p>" + loc + "</p>";
    			htmlTmp += "<p><img src='" + img + "'</img></p>";
    			htmlTmp += "<p>" + stnId + "</p>";
    			htmlTmp += "<p>" + mt + "</p>";
    			htmlTmp += "<p>" + cnt + "</p>";
    			htmlTmp += "<p>" + lon + "</p>";
    			htmlTmp += "<p>" + inTt + "</p>";
    			htmlTmp += "<p>" + dep + "</p>";
    			htmlTmp += "<p>" + tmEqk + "</p>";
    			htmlTmp += "<p>" + tmSeq + "</p>";
    			htmlTmp += "<p>" + fcTp + "</p>";
    			htmlTmp += "<p>" + rem + "</p>";
    			htmlTmp += "<p>" + lat + "</p>";
    			
    			htmlTmp += "</div>";
    			
    			$('.content').append(htmlTmp);
    			
    			/*
    			console.log("loc : " +loc);
    			console.log("img : " +img);
    			console.log("stnId : " +stnId);
    			console.log("mt : " +mt);
    			console.log("cnt : " +cnt);
    			console.log("lon : " +lon);
    			console.log("inTt : " +inTt);
    			console.log("tmEqk : " +tmEqk);
    			console.log("tmSeq : " +tmSeq);
    			console.log("dep : " +dep);
    			console.log("fcTp : " +fcTp);
    			console.log("rem : " +rem);
    			console.log("lat : " +lat);
    			*/
    			
    		}
    		
    	}
    	
    	
    </script>
    
</body>
</html>