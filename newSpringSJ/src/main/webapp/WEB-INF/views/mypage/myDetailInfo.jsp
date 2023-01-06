<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script>
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

   


function fn_modify_member_info(attribute){
	var value;
	// alert(member_id);
	// alert("mod_type:"+mod_type);
		var frm_mod_member=document.frm_mod_member;
		if(attribute=='member_pw'){
			value=frm_mod_member.member_pw.value;
			//alert("member_pw:"+value);
		}else if(attribute=='member_gender'){
			var member_gender=frm_mod_member.member_gender;
			for(var i=0; member_gender.length;i++){
			 	if(member_gender[i].checked){
					value=member_gender[i].value;
					break;
				} 
			}
			
		}else if(attribute=='member_birth'){
			var member_birth_y=frm_mod_member.member_birth;
			
		}else if(attribute=='member_phone'){
			var tel1=frm_mod_member.member_phone;
			
			value=tel1.value;
		}else if(attribute=='email'){
			var email=frm_mod_member.email;
			
			value_email=email.value;
		}else if(attribute=='address'){
			var zipcode=frm_mod_member.zipcode;
			var roadAddress=frm_mod_member.roadAddress;
			var namujiAddress=frm_mod_member.namujiAddress;
			
			value_zipcode=zipcode.value;
			value_roadAddress=roadAddress.value;
			value_jibunAddress=jibunAddress.value;
			value_namujiAddress=namujiAddress.value;
			value=value_zipcode+","+value_roadAddress+","+value_jibunAddress+","+value_namujiAddress;
		}
		console.log(attribute);
		

		fetch("${contextPath}/mypage/modifyMyInfo.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"attribute" : attribute,
				"value" : value
			})
		})
		.then(response => response.json())
		.then(jsonResult => {
			if(jsonResult.message=='mod_success'){
				alert("회원 정보를 수정했습니다.");
			}else if(jsonResult.message=='failed'){
				alert("다시 시도해 주세요.");	
			}
		});	
} 
</script>
</head>

<body>
<div id=holePage  style="display: flex;
    flex-wrap: wrap;
    text-align: center;
    justify-content: center;">
	<div style="width: 100%; margin-bottom: 2rem; font-size: 40px; font-weight: 600;">마이페이지</div>
<form name="frm_mod_member">	
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
						<input name="member_id" type="text" size="20" value="${memberInfo.member_id }"  disabled/>
					</td>
					 <td>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td>
					  <input name="member_pw" type="password" size="20" value="${memberInfo.member_pw }" />
					</td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('member_pw')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td>
					  <input name="member_name" type="text" size="20" value="${memberInfo.member_name }"  disabled />
					 </td>
					 <td>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td>
					  <c:choose >
					    <c:when test="${memberInfo.member_gender =='M' }">
					      <input type="radio" name="member_gender" value="F" />
						  여성 <span style="padding-left:30px"></span>
					   <input type="radio" name="member_gender" value="M" checked />남성
					    </c:when>
					    <c:otherwise>
					      <input type="radio" name="member_gender" value="F"  checked />
						   여성 <span style="padding-left:30px"></span>
					      <input type="radio" name="member_gender" value="M"  />남성
					   </c:otherwise>
					   </c:choose>
					</td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('member_gender')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">생년월일</td>
					<td>
					   
					</td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('member_birth')" />
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td>
					   <input type="text"name="member_phone"  size=20 value="${memberInfo.member_phone }"><br> <br>
				    </td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('member_phone')" />
					</td>	
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td>
					   <input type="text" name="email" size=20 value="${memberInfo.email }" />
					   
					</td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('email')" />
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					   <input type="text" id="zipcode" name="zipcode" size=5 value="${memberInfo.zipcode }" > <a href="javascript:execDaumPostcode()">우편번호검색</a>
					  <br>
					  <p> 
					   지번 주소:<br><input type="text" id="roadAddress"  name="roadAddress" size="50" value="${memberInfo.roadAddress }"><br><br>
					  도로명 주소: <input type="text" id="jibunAddress" name="jibunAddress" size="50" value="${memberInfo.jibunAddress }"><br><br>
					  나머지 주소: <input type="text"  name="namujiAddress" size="50" value="${memberInfo.namujiAddress }" />
					   </p>
					</td>
					<td>
					  <input type="button" value="수정하기" onClick="fn_modify_member_info('address')" />
					</td>
				</tr>
			</tbody>
		</table>
		</div>
		<div class="clear">
		<br><br>
		<table align=center>
		<tr>
			<td >
				<input type="hidden" name="command"  value="modify_my_info" /> 
				<input name="btn_cancel_member" type="button"  value="수정 취소">
			</td>
		</tr>
	</table>
	</div>
	<input  type="hidden" name="h_tel1" value="${memberInfo.member_phone}" />
</form>
</div>	
</body>
</html>
