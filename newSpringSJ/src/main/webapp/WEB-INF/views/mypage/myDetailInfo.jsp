<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"
	isELIgnored="false"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html >
<html>
<head>
<meta charset="utf-8">

<title>BOOKDUKE : 마이페이지</title>
</head>

<body>
<div id=holePage  style="display: flex;
    flex-wrap: wrap;
    text-align: center;
    justify-content: center;">
	<div style="width: 100%; margin-bottom: 1rem; margin-top:2rem; font-size: 40px; font-weight: 600; color: #6667AB;">${memberInfo.member_name }님</div>
<form name="frm_mod_member">	
	<div id="detail_table">
		<table>
			<tbody>
				<tr class="dot_line">
					<td class="fixed_join">아이디</td>
					<td>
						<input name="member_id" type="text" size="23" value="${memberInfo.member_id }"  disabled="disabled"/>
					</td>
					 
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">비밀번호</td>
					<td>
					  <input name="member_pw" type="password" size="23" value="${memberInfo.member_pw }" disabled="disabled"/>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이름</td>
					<td>
					  <input name="member_name" type="text" size="23" value="${memberInfo.member_name }"  disabled="disabled" />
					 </td>
					 
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">성별</td>
					<td>
					  <c:choose >
					    <c:when test="${memberInfo.member_gender =='M' }">
					   <input type="text" name="member_gender" value="남성" disabled="disabled" size=23/>
					    </c:when>
					    <c:otherwise>
					       <input type="text" name="member_gender" value="여성" disabled="disabled" size=23/>
					   </c:otherwise>
					   </c:choose>
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">생년월일</td>
					<td>
					   <input name="member_birth" type="text" size=23 value="${memberInfo.member_birth }" disabled="disabled"/>
					</td>
				</tr>
				
				<tr class="dot_line">
					<td class="fixed_join">휴대폰번호</td>
					<td>
					   <input type="text"name="member_phone"  size=23 value="${memberInfo.member_phone }" disabled="disabled">
				    </td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">이메일<br>(e-mail)</td>
					<td>
					   <input type="text" name="email" size=23 value="${memberInfo.email }" disabled="disabled"/>
					   
					</td>
				</tr>
				<tr class="dot_line">
					<td class="fixed_join">주소</td>
					<td>
					  우편 번호 : <input type="text" id="zipcode" name="zipcode" size=5 value="${memberInfo.zipcode }" disabled="disabled">
					  <br><br>
					  <p> 
					   지번 주소:<br><input type="text" id="roadAddress"  name="roadAddress" size="40" value="${memberInfo.roadAddress }" disabled="disabled"><br><br>
					  도로명 주소: <br><input type="text" id="jibunAddress" name="jibunAddress" size="40" value="${memberInfo.jibunAddress }" disabled="disabled"><br><br>
					  나머지 주소: <br><input type="text"  name="namujiAddress" size="40" value="${memberInfo.namujiAddress }" disabled="disabled" />
					   </p>
					</td>
				</tr>
			</tbody>
		</table>
		<br><br>
		</div>
		<div class="clear">
		<table align=center>
		<tr>
			<td >
				<input name="updateMemberBtn" id="updateMemberBtn" type="button"  value="수정하기" onclick="location.href='<c:url value='/mypage/beforeUpdate.do'/>'">
			</td>
		</tr>	</table>

	</div>
</form>
</div>	
</body>
</html>
