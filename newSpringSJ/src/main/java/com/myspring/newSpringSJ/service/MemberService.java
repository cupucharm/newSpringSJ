package com.myspring.newSpringSJ.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.newSpringSJ.entity.MemberVO;
import com.myspring.newSpringSJ.mapper.MemberDAO;

@Service("memberService")
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;

	public MemberVO login(Map<String, String> loginMap) {
		MemberVO memberVO = memberDAO.login(loginMap);

		if (memberVO != null) {
			if (loginMap.get("member_pw").equals(memberVO.getMember_pw())) {
				return memberVO;
			} else {
				return null;
			}
		}
		return memberVO;
	}

	public void addMember(HashMap<String, String> registerMap) throws Exception {
		String ph1 = registerMap.get("member_phone").substring(0, 3);
		String ph2 = registerMap.get("member_phone").substring(3, 7);
		String ph3 = registerMap.get("member_phone").substring(7, 11);

		StringBuilder phone = new StringBuilder();
		phone.append(ph1).append("-").append(ph2).append("-").append(ph3);
		registerMap.put("member_phone", phone.toString());

		memberDAO.insertNewMember(registerMap);
	}

	public String overlapped(String id) throws Exception {
		return memberDAO.selectOverlappedID(id);
	}

	public String searchId(HashMap<String, String> searchIdMap) {
		MemberVO memberVO = memberDAO.selectEmail(searchIdMap.get("email"));

		if (memberVO != null) {
			if (searchIdMap.get("member_name").equals(memberVO.getMember_name())) {
				return memberVO.getMember_id();
			} else {
				return null;
			}
		}
		return null;
	}

	public String isMailExist(HashMap<String, String> isMailExistMap) {
		return memberDAO.isMailExist(isMailExistMap);
	}

	public MemberVO isExistId(HashMap<String, String> searchPwMap) {
		MemberVO memberVO = memberDAO.login(searchPwMap);
		
		if (memberVO != null) {
			if (searchPwMap.get("member_name").equals(memberVO.getMember_name()) 
					&& searchPwMap.get("email").equals(memberVO.getEmail())) {
				return memberVO;
			} else {
				return null;
			}
		}
		return memberVO;
	}

	public String changePw(HashMap<String, String> pwMap) {
		memberDAO.changePw(pwMap);
		return null;
	}

	public void setLoginTime(Map<String, String> loginTimeMap) {
		memberDAO.setLoginTime(loginTimeMap);
	}

	public String isLoginDo(String member_id) {
		return memberDAO.isLoginDo(member_id);
	}


}
