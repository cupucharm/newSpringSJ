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
	<a id="logo" href="/">BOOKDUKE</a>
<!-- <hr> -->
		
		<div class="searchPwCondition">
		<div class="searchPwDiv">
			<input name="user_id"  type="text" class="inputClass"
					id="user_id" placeholder="아이디" required="required"
					autocomplete="none">
					</div>
					<div id="putId"></div>
			<div class="searchPwDiv">
			<input name="user_name"type="text" class="inputClass"
					id="user_name" placeholder="이름" required="required"
					autocomplete="none"> 
					</div>
					<div id="putName"></div>
			<div class="searchPwDiv">
				<div class="emailbox">
					<input name="email"  type="text" id="emailPw" placeholder="이메일" class="inputClass" required="required" autocomplete="none">
					<input type="button" id="searchPwEmailBtn" class="inputClass" value="인증번호 전송" onclick="searchPwEmail()">
					</div>
			</div>
			
			<div class="searchPwDiv">
				<div class="emailbox">
				<div class="mail_check_input_box" id="mail_check_input_box_false">
					<input type="text" id="mail_check_input" placeholder="이메일 인증번호를 입력하세요" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/(\..*)\./g, '$1');" maxlength='6' disabled="disabled" class="inputClass" required="required" autocomplete="none">
					</div>
					<span id="timer"></span>
					<input type="button" id="searchPwEmailChk" class="inputClass" disabled="disabled" value="인증번호 확인" onclick="checkEmailVaild()">
					</div>
					<span id="mail_check_input_box_warn"></span>
			</div>
			</div>


		<div class="searchPwBtnDiv">
			<div>
				<input type="submit" name="searchPwBtn" id="searchPwBtn"
					class="searchPwBtn" value="비밀번호 찾기" onclick="searchPw()">
			</div>
		</div>


		<div class="changePage">
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='searchIdForm.do'">아이디 찾기</button>
			<button id="login" class="changePageBtn"
				onclick="location.href='loginForm.do'">로그인</button>
			<button id="searchPw" class="changePageBtn"
				onclick="location.href='memberForm.do'">회원가입</button>
		</div>
	</div>
	
	
	<script type="text/javascript">

	function searchPwEmail() {
		let user_id = document.querySelector("#user_id").value;
		if (user_id==null || user_id=='' || user_id.length == 0){
			putId.innerHTML = "아이디를 입력하세요";
	   		return;
	    }
		
		let user_name = document.querySelector("#user_name").value;
		if (user_name==null || user_name=='' || user_name.length == 0){
			putName.innerHTML = "이름을 입력하세요";
			putId.style.display = "none";
	   		return;
	    }
		
		let user_email = document.querySelector("#emailPw").value;
		if (user_email==null || user_email=='' || user_email.length == 0){
			putId.style.display = "none";
			putName.style.display = "none";
			alert("이메일을 입력하세요");
	   		return;
	    }

		fetch("${contextPath}/member/isExistId.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"member_id" : user_id,
				"member_name": user_name,
				"email": user_email
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				if(jsonResult.status == 'fail') {
					alert(jsonResult.message);
				} else {
					sendMail();
				}
			});
		}
	
	var code = "";
	
	function sendMail() {
		let checkBox = document.querySelector("#mail_check_input");
		let boxWrap = document.querySelector(".mail_check_input_box");
		
		alert("이메일 인증 메일을 보냈습니다. \n\n최대 1분 소요 예정입니다. \n확인 후 5분 이내에 아래 칸에 입력해주세요.")
		sendAuthNum();
		
		fetch("${contextPath}/mail/changePw.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"email": emailPw.value
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				checkBox.removeAttribute("disabled");
				boxWrap.setAttribute("id", "mail_check_input_box_true");
				searchPwEmailChk.removeAttribute("disabled");
				code = jsonResult.num;
			});
	}
	
	function checkEmailVaild() {
		let inputCode = document.querySelector("#mail_check_input").value;
		let checkResult = document.querySelector("#mail_check_input_box_warn");
		let searchPwEmailBtn = document.querySelector("#searchPwEmailBtn");
		
		
		if(inputCode == code){                            // 일치할 경우
	        checkResult.innerHTML = "인증번호가 일치합니다.";
	        checkResult.setAttribute("class", "correct");
	        searchPwEmailBtn.setAttribute("disabled", "true");
	    } else {                                            // 일치하지 않을 경우
	        checkResult.innerHTML= "인증번호를 다시 확인해주세요.";
	        checkResult.setAttribute("class", "incorrect");
	    }  
	}
	
	var timer;
	var isRunning = false;
	 
	// 인증번호 발송하고 타이머 함수 실행
	function sendAuthNum(){
	    	// 남은 시간
		var leftSec = 60 * 5,
		display = document.querySelector('#timer');
		// 이미 타이머가 작동중이면 중지
		if (isRunning){
		   	clearInterval(timer);
		} else {
	    	isRunning = true;
	    }
	    startTimer(leftSec, display);
	}
	 
	function startTimer(count, display) {
		let checkBox = document.querySelector("#mail_check_input");
		let boxWrap = document.querySelector(".mail_check_input_box");
		
		let checkResult = document.querySelector("#mail_check_input_box_warn");
		
	    var minutes, seconds;
	    timer = setInterval(function () {
	    	minutes = parseInt(count / 60, 10);
	    	seconds = parseInt(count % 60, 10);
	 
	    	minutes = minutes < 10 ? "0" + minutes : minutes;
	    	seconds = seconds < 10 ? "0" + seconds : seconds;
	 
	    	display.textContent = minutes + ":" + seconds;
	        
	    	 if(checkResult.getAttribute("class") == "correct") {
	     		checkBox.setAttribute("disabled", "true");
	     		boxWrap.setAttribute("id", "mail_check_input_box_false");
	     		clearInterval(timer);
	   		  }
	 
	    	 // 타이머 끝
	   	 	 if (--count < 0) {
		  	    clearInterval(timer);
		   		display.textContent = "";
		     	 
		   	  	alert("시간이 초과되었습니다. 이메일 인증을 다시 진행해주세요.");
		  	  	checkBox.setAttribute("disabled", "disabled");
				boxWrap.setAttribute("id", "mail_check_input_box_false");
		  	   	isRunning = false;
	     	 }
	 	}, 1000);
	        isRunning = true;
	}
	
	function searchPw(){
		let searchPwEmailBtn = document.querySelector("#searchPwEmailBtn");
		
		let user_id = document.querySelector("#user_id").value;
		if (user_id==null || user_id=='' || user_id.length == 0){
			putId.innerHTML = "아이디를 입력하세요";
	   		return;
	    }
		
		let user_name = document.querySelector("#user_name").value;
		if (user_name==null || user_name=='' || user_name.length == 0){
			putName.innerHTML = "이름을 입력하세요";
			putId.style.display = "none";
	   		return;
	    }
		
		let user_email = document.querySelector("#emailPw").value;
		if (user_email==null || user_email=='' || user_email.length == 0){
			putId.style.display = "none";
			putName.style.display = "none";
			alert("이메일을 입력하세요");
	   		return;
	    }
		
		if ( searchPwEmailBtn.getAttribute("disabled") == "true") {
			
			fetch("${contextPath}/member/searchPw.do", {
				//option
				method: 'POST',
				headers: {
					'Content-Type': 'application/json;charset=utf-8'
				},
				body: JSON.stringify({
					"member_id": user_id
				})
			})
				.then(response => response.json())
				.then(jsonResult => {
					location.href = jsonResult.url;
				});
			
		} else {
			alert("이메일 인증을 확인해주세요")
			putId.style.display = "none";
			putName.style.display = "none";
		}
		
	}
	</script>	
</body>
</html>