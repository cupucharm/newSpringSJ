package com.myspring.newSpringSJ.service;

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
		return memberDAO.login(loginMap);
	}

	public void addMember(HashMap<String, String> registerMap) throws Exception{
		memberDAO.insertNewMember(registerMap);
	}
	
	public String overlapped(String id) throws Exception{
		return memberDAO.selectOverlappedID(id);
	}

}
