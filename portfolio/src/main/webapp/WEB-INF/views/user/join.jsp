<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" type="text/css" href="/resources/css/join.css">
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	
	<div class="container">
	
		<jsp:include page="../common/header.jsp" flush="false" />
		
		<div class="content">	
				
			<h2 class="content_title">회원가입</h2>

			<p>${joinf}</p>
			
			<form id="frm" class="frm" action="/user/join" method="post" onsubmit="return chk()">
				<input type="text" id="uid" name="uid" placeholder="&emsp;아이디" onblur="dupleChk()" required>
				<p id="idDupleRes"></p>
				<input type="password" name="upw" placeholder="&emsp;비밀번호" required>
				<input type="password" name="reupw" placeholder="&emsp;비밀번호 확인" required>
				<!--
				<div>
					<input type="email" name="email" placeholder="이메일" value="${mail}" readonly>
					<!-- <button type="button" onclick="sendAuthMail()">인증번호 보내기</button>
				</div>
				<div>
					<input type="number" name="email_injeung" placeholder="인증번호">
					<button type="button" onclick="join_injeung${rand}">인증하기</button>
				</div>
				 -->
				<input type="text" name="nm" placeholder="&emsp;이름" required>
				<input type="text" name="ph" placeholder="&emsp;휴대폰 번호" required>
				
				<div>
                  	<div>
                  		<input type="text" id="zoneCode" name="zoneCode" placeholder="&emsp;우편번호"  readonly required>
                    	<button type="button" onclick="postcodeOpen()">주소검색</button>
                  	</div>
                    <input type="text" name="roadAddr" id="roadAddr" placeholder="&emsp;주소" readonly required>
                    <input type="text" name="detailAddr" id="detailAddr" placeholder="&emsp;상세 주소" required>
                </div>
            
				<div>
					<input type="submit" value="회원가입">
				</div>
			</form>
				
			
		</div>
		
		<jsp:include page="../common/footer.jsp" flush="false" />
				
	</div>
	
	<script>
	$(function(){
		 var joinSuc = "<c:out value="${joinSuc}" />";
		 var joinf = "<c:out value="${joinf}" />";
		 
		 	if(joinSuc != ""){
			 	alert(joinSuc)
				location.href = "/user/login"
			}
		 
		 	if(joinf != ""){
			 	alert(joinf)
				location.href = "redirect:/user/join"
			}
		 	
	    })	 
 
	function chk(){
		
		let idDupleRes = document.getElementById('idDupleRes');
		
		if(idDupleRes.innerText == "중복 된 아이디입니다."){
			alert('중복 된 아이디입니다.');
			return;
		}

	}
	
	function dupleChk(){
		
		const uid = document.getElementById('uid').value;
		let idDupleRes = document.getElementById('idDupleRes');
		
		if(uid == "") {
			return;
		}
		
		$.ajax({
			type: "POST",
			dataType : "json",
			url: "/duple/id",
			data: { uid : uid },
			contentType: "application/x-www-form-urlencoded; charset=UTF-8",
			success: function(res){

				if(res.res == "dupleSuc"){
					idDupleRes.innerText = "사용 가능한 아이디입니다.";
					idDupleRes.style.color = "blue";
					return;
				} else {
					idDupleRes.innerText = "중복 된 아이디입니다.";
					idDupleRes.style.color = "red";
					return;
				}
				
			},
            error: function(err){
                console.log(err);
            }
		});
	}
	
	function postcodeOpen(){

	      const zoneCode = document.getElementById('zoneCode');
	      const roadAddr = document.getElementById('roadAddr');

	      new daum.Postcode({
	        oncomplete: function(data) {
	            zoneCode.value = data.zonecode;
	            roadAddr.value = data.roadAddress;
	        }
	      }).open();

	}
	
	</script>
</body>
</html>