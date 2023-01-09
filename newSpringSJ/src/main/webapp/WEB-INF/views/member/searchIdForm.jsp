<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<title>BOOKDUKE : 아이디 찾기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>">
</head>
<body>
	<div class="main">
		<a id="logo" href="/">BOOKDUKE</a>
	
		<!-- <hr> -->
		<div class="searchIdDiv">
				<input name="user_name" class="searchIdCondition" type="text"
					id="user_name" placeholder="이름" required="required"
					autocomplete="none"> 
					</div>
		<div class="searchIdDiv">			
				<input name="email"
					class="searchIdCondition" type="text" id="email"
					placeholder="이메일" required="required" autocomplete="none">
		</div>


		<div class="searchIdBtnDiv">
			<div>
				<input type="submit" name="searchIdBtn" id="searchIdBtn"
					class="searchIdBtn" value="아이디 찾기">
			</div>
		</div>


		<div id="checkId"></div>

		<div class="changePage">
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='searchPwForm.do'">비밀번호 찾기</button>
			<button id="login" class="changePageBtn"
				onclick="location.href='loginForm.do'">로그인</button>
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='memberForm.do'">회원가입</button>
		</div>
	</div>
	
	<script type="text/javascript">
	let searchIdBtn = document.querySelector("#searchIdBtn");
	let checkId = document.querySelector("#checkId");
	
	if (searchIdBtn != null) {
		searchIdBtn.onclick = (e) => {
			searchId(e);
		}
	}

	function searchId(e) {
		e.preventDefault();
		
		let user_name = document.querySelector("#user_name").value;
		if (user_name==null || user_name=='' || user_name.length == 0){
			checkId.innerHTML = "이름을 입력하세요";
	   		return;
	    }
		
		let user_email = document.querySelector("#email").value;
		if (user_email==null || user_email=='' || user_email.length == 0){
			checkId.innerHTML = "이메일을 입력하세요";
	   		return;
	    }

		fetch("${contextPath}/member/searchId.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"member_name": user_name,
				"email": user_email
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				checkId.innerHTML = jsonResult.message;
			});
		}
	</script>	
</body>
</html>