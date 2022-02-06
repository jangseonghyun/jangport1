<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>평점</title>
<style>
	img{
		width:50px;
		height:50px;
	}
</style>
</head>
<body>
	
	<form action="usr_MoveDetailPro" method="post" name="cmtform">
		<table width="700px">
			<tr>
				<td width="100px" rowspan="2">${loginUser.nm }</td>
				<td width="500px" height="50px" colspan="2">
					<div>
						<span>
							<img id=image1 onmouseover=show(1) onclick=mark(1) onmouseout=noshow(1) src="/resources/img/star0.png">
							<img id=image2 onmouseover=show(2) onclick=mark(2) onmouseout=noshow(2) src="/resources/img/star0.png">
							<img id=image3 onmouseover=show(3) onclick=mark(3) onmouseout=noshow(3) src="/resources/img/star0.png">
							<img id=image4 onmouseover=show(4) onclick=mark(4) onmouseout=noshow(4) src="/resources/img/star0.png">
							<img id=image5 onmouseover=show(5) onclick=mark(5) onmouseout=noshow(5) src="/resources/img/star0.png">
							<button type="button" onclick=chogiwha()>리셋</button>
						</span>
						<br>
						<input id="startext" type="hidden1">
					</div>
					<!-- 평점 -->
					<input id="num" type="hidden1" name="cmt_star">
				</td>
				
				<td width="100px" rowspan="2"><input type="submit" name="submit" value="submit"></td>
				<!-- 영화제목 -->
				<input type="hidden1" name="cmt_move" value="영화제목넣기">
			</tr>
			
			<tr>
				<c:if test="${loginUser.i_user == null}">
					<td widht="500px" height="100px" colspan="2">
						<textarea name="content" cols="65" rows="7" readonly>로그인 후 이용 가능한 서비스입니다.</textarea>
					</td>
				</c:if>
				
				<c:if test="${loginUser.i_user != null }">
					<td width="500px" height="100px" colspan="2">
						<textarea name="content" cols="65" rows="7"></textarea>
					</td>
				</c:if>
			</tr>
		</table>
		<!-- 
		${rating.cmt_num }
		${rating.cmt_wirtier}
		${rating.cmt_star}
		${rating.cmt_content}
		${rating.cmt_move}
		${rating.cmt_reg_date}
		 -->
	</form>
	
	<script>
		
		var locked = 0;
		
		//hover
		function show(star){
			
			var i;
			var image;
			var el;
			
			if(locked == 0){
				
				for(i=1; i<=star; i++){
					image = 'image'+i;
					el = document.getElementById(image);
					el.src = "/resources/img/star1.png";
				}
			
			} else{
				
				for(i=1; i<=5; i++){
					image = 'image'+i;
					el = document.getElementById(image);
					el.src = "/resources/img/star0.png";
				}
				
				for(i=1; i<=star; i++){
					image = 'image'+i;
					el = document.getElementById(image);
					el.src = "/resources/img/star1.png";
				}
			}
			
			
			//var e;
			//var stateMsg = '';
			
			//별 이미지
			
			
			/*
			switch(star){
				case 1:
					cmtform.startext.value = '괜히봤어요';
					cmtform.num.value = 1;
					break;
				case 2:
					cmtform.startext.value = '기대하진 마세요';
					cmtform.num.value = 2;
					break;
				case 3:
					cmtform.startext.value = '무난했어요';
					cmtform.num.value = 3;
					break;
				case 4:
					cmtform.startext.value = '기대해도 좋아요';
					cmtform.num.value = 4;
					break;
				case 5:
					cmtform.startext.value = '개꿀잼';
					cmtform.num.value = 5;
					break;
				default:
					stateMsg = '';
			}
			*/
		}
		
		//별 클릭전 마우스가 별 밖으로 이동했을 때 효과
		function noshow(star){
			
			if(locked){
				return;
			}
			
			var i;
			var image;
			var el;
			
			for(i = 1; i <= star; i++){
				image = 'image' + i;
				el = document.getElementById(image);
				el.src = "/resources/img/star0.png";
			}
		}
		
		//
		function lock(star){
			
			if(locked == 0){
				show(star);
				locked = 1;
			} else{
				show(star);
			}
		}
		
		//클릭시 효과
		function mark(star){
			lock(star);
			document.cmtform.num.value = star;
			
			switch(star){
			case 1:
				cmtform.startext.value = '괜히봤어요';
				break;
			case 2:
				cmtform.startext.value = '기대하진 마세요';
				break;
			case 3:
				cmtform.startext.value = '무난했어요';
				break;
			case 4:
				cmtform.startext.value = '기대해도 좋아요';
				break;
			case 5:
				cmtform.startext.value = '개꿀잼';
				break;
			}
		}
		
		//리셋버튼
		function chogiwha(){
			location.href = "/board/Rating";
		}

	</script>
</body>
</html>