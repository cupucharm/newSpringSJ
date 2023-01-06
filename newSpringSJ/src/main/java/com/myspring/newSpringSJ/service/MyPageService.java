package com.myspring.newSpringSJ.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.newSpringSJ.entity.MemberVO;
import com.myspring.newSpringSJ.entity.OrderVO;
import com.myspring.newSpringSJ.mapper.MyPageDAO;


@Service("myPageService")
public class MyPageService {

	@Autowired
	private MyPageDAO myPageDAO;

	public List<OrderVO> listMyOrderGoods(String member_id) {
		return myPageDAO.selectMyOrderGoodsList(member_id);
	}

	public MemberVO myDetailInfo(String member_id) throws Exception {
		return myPageDAO.selectMyDetailInfo(member_id);
	}

	public MemberVO modifyMyInfo(Map<String, String> memberMap) {
		String member_id = (String) memberMap.get("member_id");
		myPageDAO.updateMyInfo(memberMap);
		return myPageDAO.selectMyDetailInfo(member_id);
	}

}
