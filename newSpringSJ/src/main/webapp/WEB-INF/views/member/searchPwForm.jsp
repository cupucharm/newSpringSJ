<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<title>BOOKDUKE : 비밀번호 찾기</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/search.css'/>">
</head>
<body>
	<div class="main">
<hr>
		<div class="searchPwDiv">
			<input name="user_id" class="searchPwCondition" type="text"
					id="user_id" placeholder="아이디" required="required"
					autocomplete="none">
			<input name="user_name" class="searchPwCondition" type="text"
					id="user_name" placeholder="이름" required="required"
					autocomplete="none"> <input name="user_phone"
					class="searchPwCondition" type="number" id="user_phone"
					placeholder="전화번호" required="required" autocomplete="none">
			
		</div>


		<div class="searchPwBtnDiv">
			<div>
				<input type="submit" name="searchPwBtn" id="searchPwBtn"
					class="searchPwBtn" value="비밀번호 찾기">
			</div>
		</div>


		<div id="checkPw"></div>

		<div class="changePage">
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='searchIdForm.do'">아이디 찾기</button>
			<button id="login" class="changePageBtn"
				onclick="location.href='loginForm.do'">로그인</button>
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='registerForm.do'">회원가입</button>
		</div>
	</div>
</body>
</html>