package com.myspring.newSpringSJ.mapper;

import java.util.HashMap;
import java.util.Map;

import com.myspring.newSpringSJ.entity.MemberVO;


public interface MemberDAO {

	MemberVO login(Map<String, String> loginMap);
	
	void insertNewMember(HashMap<String, String> registerMap);
	
	String selectOverlappedID(String id);

	String isMailExist(HashMap<String, String> isMailExistMap);

	MemberVO selectEmail(String string);

	void changePw(HashMap<String, String> pwMap);

	void setLoginTime(Map<String, String> loginTimeMap);

	String isLoginDo(String member_id);

}
