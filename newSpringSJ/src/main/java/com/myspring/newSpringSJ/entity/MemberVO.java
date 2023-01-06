package com.myspring.newSpringSJ.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private String member_id;
	private String member_pw;
	private String member_name;
	private String member_gender;
	private String member_birth;
	private String member_phone;
	private String email;
	private String zipcode;
	private String roadAddress;
	private String jibunAddress;
	private String namujiAddress;
	private String joinDate;
	private String member_condition;
	private String member_grade;
	private String member_logintime;
	
}
