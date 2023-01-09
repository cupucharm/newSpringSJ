<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	 isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/login.css'/>">
<title>BOOKDUKE : 로그인</title>
</head>
<body>

 <div class="main">
 <%-- <a href="${contextPath}/">
		<img  alt="bookduke" src="${contextPath}/resources/image/duke_normal.png">
		</a> --%>
		<p id="loginPtag">로그인<p>
		<div class="container">
		
			<div class="frmLogin">
				<form action="${contextPath}/member/login.do" method="post" encType="UTF-8" name="loginForm">
					<input type="text" placeholder="ID" id="member_id" name="member_id" class="account" autofocus="autofocus" required="required"
						autocomplete="none">
					<input type="password" placeholder="Password" id="member_pw" name="member_pw"
						class="account" autofocus="autofocus" required="required">
						<div id="loginfail" style="color: red; margin: 1em 0; text-align: center;"></div>
					<input type="submit" value="Login" id="loginbtn" class="loginbtn">
				</form>
			</div>
			<div class="bottomDiv">
				<button id="register" class="accountPlus" onclick="location.href='${contextPath}/member/memberForm.do'">회원가입</button>
				<button id="searchId" class="accountPlus" onclick="location.href='../member/searchIdForm.do'">아이디찾기</button>
				<button id="searchPw" class="accountPlus" onclick="location.href='../member/searchPwForm.do'">비밀번호찾기</button>
			</div>
		</div>
	</div>
 
 	<script type="text/javascript">
	let loginbtn = document.querySelector("#loginbtn");
	if (loginbtn != null) {
		loginbtn.onclick = (e) => {
			login(e);
		}
	}

	function login(e) {
		e.preventDefault();
		let param = {
			"member_id": member_id.value,
			"member_pw": member_pw.value
		};

		fetch("${contextPath}/member/login.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify(param)
		})
			.then(response => response.json())
			.then(jsonResult => {
				if (jsonResult.status == "blank") {
					loginfail.innerHTML = jsonResult.message;
				} else {
					alert(jsonResult.message);
					location.href = jsonResult.url;
				}
			});
		}
	</script>		
</body>
</html>