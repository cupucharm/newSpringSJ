package com.myspring.newSpringSJ.service;

import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.newSpringSJ.entity.MemberVO;
import com.myspring.newSpringSJ.mapper.MemberDAO;


@Service("memberService")
public class MemberService {
	
	@Autowired
	private MemberDAO memberDAO;

	public MemberVO login(Map<String, String> loginMap) {
		return memberDAO.login(loginMap);
	}

	public void addMember(HashMap<String, String> registerMap) throws Exception{
		String ph1 = registerMap.get("member_phone").substring(0, 3);
		String ph2 = registerMap.get("member_phone").substring(3, 7);
		String ph3 = registerMap.get("member_phone").substring(7, 11);
		
		StringBuilder phone =  new StringBuilder();
		phone.append(ph1).append("-").append(ph2).append("-").append(ph3);
		registerMap.put("member_phone",phone.toString());
		
		memberDAO.insertNewMember(registerMap);
	}
	
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}

}
