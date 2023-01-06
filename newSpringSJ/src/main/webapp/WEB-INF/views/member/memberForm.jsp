<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="<c:url value='/resources/css/memberInsert.css'/>">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
/* let registerBtn = document.querySelector("#registerBtn");
if (registerBtn != null) {
	registerBtn.onclick = () => {
		alert("wrewrw");
		register(); 
	}
} */

function execDaumPostcode() {
	  new daum.Postcode({
	    oncomplete: function(data) {
	      // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	      // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
	      // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	      var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
	      var extraRoadAddr = ''; // 도로명 조합형 주소 변수
	      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	        extraRoadAddr += data.bname;
	      }
	      // 건물명이 있고, 공동주택일 경우 추가한다.
	      if(data.buildingName !== '' && data.apartment === 'Y'){
	        extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	      }
	      // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	      if(extraRoadAddr !== ''){
	        extraRoadAddr = ' (' + extraRoadAddr + ')';
	      }
	      // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
	      if(fullRoadAddr !== ''){
	        fullRoadAddr += extraRoadAddr;
	      }
	      // 우편번호와 주소 정보를 해당 필드에 넣는다.
	      document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
	      document.getElementById('roadAddress').value = fullRoadAddr;
	      document.getElementById('jibunAddress').value = data.jibunAddress;
	      // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	      if(data.autoRoadAddress) {
	        //예상되는 도로명 주소에 조합형 주소를 추가한다.
	        var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	        document.getElementById('guide').innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	      } else if(data.autoJibunAddress) {
	          var expJibunAddr = data.autoJibunAddress;
	          document.getElementById('guide').innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	      } else {
	          document.getElementById('guide').innerHTML = '';
	      }
	      
	     
	    }
	 }).open();
}


async function register() {
	let sex= document.querySelector('input[name="member_gender"]:checked').value;
	let param = {
		"member_id": document.getElementById('member_id').value,
		"member_name": document.getElementById('member_name').value,
		"member_pw": document.getElementById('member_pw').value,
		"pwdConfirm": document.getElementById('pwdConfirm').value,
		"member_phone": document.getElementById('member_phone').value,
		"email": document.getElementById('email').value,
		"member_gender": sex,
		"member_birth": document.getElementById('member_birth').value,
		"zipcode" : document.getElementById('zipcode').value,
		"roadAddress" : document.getElementById('roadAddress').value,
		"jibunAddress" : document.getElementById('jibunAddress').value,
		"namujiAddress" : document.getElementById('namujiAddress').value
	};
	
	let member_id = document.getElementById("member_id").value;
    let response = await fetch('${contextPath}/member/overlapped.do?id=' + member_id);
	let jsonResult = await response.json();
	if (jsonResult.result == 'true') {
    	alert("이미 사용중인 아이디입니다.");
    } else {
    	fetch('${contextPath}/member/addMember.do', {
    		//option
    		method: 'POST',
    		headers: {
    			'Content-Type': 'application/json;charset=utf-8'
    		},
    		body: JSON.stringify(param)
    	})
    		.then(response => response.json())
    		.then(jsonResult => {
    			alert(jsonResult.message);
    			if (jsonResult.url != null) {
    				location.href = jsonResult.url;
    			}
    		});
    }
} 

async function fn_overlapped(){
	let member_id = document.querySelector("#member_id").value;
    if(member_id==null || member_id=='' || member_id.length <= 0){
   		alert("아이디를 입력하세요");
   		return;
    }
    let response = await fetch('${contextPath}/member/overlapped.do?id=' + member_id);
	let jsonResult = await response.json();
    if (jsonResult.result == 'true') {
    	alert("이미 사용중인 아이디입니다.");
    } else {
    	alert("사용 가능한 아이디입니다.");
    }
 }	
 


</script>
</head>
<body>

<div class="main">
<p id="regPtag">회원가입<p>
		<form action="${contextPath}/member/addMember.do" method="POST" class="register" onsubmit="return false;">
			<div class="fixed_join">
				<input type="text" name="member_id" id="member_id" placeholder="아이디" autofocus="autofocus" required="required" autocomplete="none">
			</div>
			<div class="fixed_join">
				<input type="button"  id="btnOverlapped" value="아이디 중복 확인하기" onClick="return fn_overlapped()" />
			</div>

			<div class="fixed_join">
				<input name="member_pw" id="member_pw" type="password" class="member_pw" placeholder="비밀번호" required="required">
			</div>

			<div class="fixed_join">
				<input name="pwdConfirm" id="pwdConfirm" type="password" class="member_pw" placeholder="비밀번호 확인" required="required">
			</div>
			
			<div id="pwd_valid_msg"></div>
			
			<div class="fixed_join">
				<input name=“member_name” type="text" id="member_name" placeholder="이름" required="required" autocomplete="none">
			</div>

			<div class="fixed_join">
				<input name="member_phone" type="number" id="member_phone" placeholder="전화번호" required="required">
			</div>

			<div class="fixed_join">
				<input name="email" type="text" id="email" placeholder="이메일" required="required">
			</div>

			<div class="fixed_join">
				<input type="radio" name="member_gender" id="member_genderF" value="F" checked="checked" /> 여자 
				<input type="radio" name="member_gender" id="member_genderM" value="M" /> 남자
			</div>

			<div class="fixed_join">
				<input name=“member_birth” type="date" id="member_birth" data-placeholder="생년월일" required="required" aria-required="true">
			</div>

			<div class="fixed_join">
				<input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly="readonly">
				<a href="javascript:execDaumPostcode()" id="searchZip">우편번호 검색</a><br>
				<p> 
					<br><input type="text" id="roadAddress"  name="roadAddress" class="addr" placeholder="지번 주소" readonly="readonly"><br><br>
					<input type="text" id="jibunAddress" name="jibunAddress" class="addr" placeholder="도로명 주소" readonly="readonly"><br><br>
					<input type="text" id="namujiAddress" name="namujiAddress" class="addr" placeholder="나머지 주소" />
				</p>
			</div>

			<input type="submit" id="registerBtn" class="registerBtn" onclick="register();" value="회 원 가 입" />
		</form>
	</div>
</body>
</html>