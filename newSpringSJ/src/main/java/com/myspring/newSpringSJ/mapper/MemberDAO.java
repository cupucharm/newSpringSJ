package com.myspring.newSpringSJ.mapper;

import java.util.HashMap;
import java.util.Map;

import com.myspring.newSpringSJ.entity.MemberVO;


public interface MemberDAO {

	MemberVO login(Map<String, String> loginMap);
	
	void insertNewMember(HashMap<String, String> registerMap);
	
	String selectOverlappedID(String id);

}
