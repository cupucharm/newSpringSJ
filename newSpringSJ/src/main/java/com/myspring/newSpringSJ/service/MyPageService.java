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

	public MemberVO isPwCorrect(Map<String, String> memberMap) {
		MemberVO memberVO = myPageDAO.selectMyDetailInfo(memberMap.get("member_id"));

		if (memberVO != null) {
			if (memberMap.get("member_pw").equals(memberVO.getMember_pw())) {
				return memberVO;
			} else {
				return null;
			}
		}
		return memberVO;
	}

	public MemberVO updateMember(Map<String, String> memberMap) {
		String member_id = (String) memberMap.get("member_id");
		
		myPageDAO.updateMember(memberMap);
		return myPageDAO.selectMyDetailInfo(member_id);
	}

	public MemberVO deleteMember(Map<String, String> memberMap) {
		String member_id = (String) memberMap.get("member_id");
		
		myPageDAO.deleteMember(memberMap);
		return myPageDAO.selectMyDetailInfo(member_id);
	}

	public void cancelOrder(String order_id) {
		myPageDAO.updateMyOrderCancel(order_id);
	}

}
