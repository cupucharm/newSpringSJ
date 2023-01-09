package com.myspring.newSpringSJ.mapper;

import java.util.List;
import java.util.Map;

import com.myspring.newSpringSJ.entity.MemberVO;
import com.myspring.newSpringSJ.entity.OrderVO;


public interface MyPageDAO {
	List<OrderVO> selectMyOrderGoodsList(String member_id);

	public MemberVO selectMyDetailInfo(String member_id);

	void updateMyInfo(Map<String, String> memberMap);

	void updateMember(Map<String, String> memberMap);

	void deleteMember(Map<String, String> memberMap);

}