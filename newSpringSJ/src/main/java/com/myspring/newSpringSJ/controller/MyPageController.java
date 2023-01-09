package com.myspring.newSpringSJ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.newSpringSJ.entity.MemberVO;
import com.myspring.newSpringSJ.entity.OrderVO;
import com.myspring.newSpringSJ.service.MyPageService;

@Controller("myPageController")
@RequestMapping("/mypage")
public class MyPageController extends BaseController {

	@Autowired
	private MyPageService myPageService;

	@RequestMapping("/myPageMain.do")
	public String myPageMain(@RequestParam(required = false, value = "message") String message,
			HttpServletRequest request, Model model) throws Exception {

		HttpSession session = request.getSession();
		session = request.getSession();
		session.setAttribute("side_menu", "my_page");

		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();

		List<OrderVO> myOrderList = myPageService.listMyOrderGoods(member_id);

		model.addAttribute("message", message);
		model.addAttribute("myOrderList", myOrderList);

		return "/mypage/myPageMain";
	}

	@RequestMapping("/myDetailInfo.do")
	public String myDetailInfo() throws Exception {
		return "/mypage/myDetailInfo";
	}

	@RequestMapping("/beforeUpdate.do")
	public String beforeUpdate() throws Exception {
		return "/mypage/beforeUpdate";
	}
	
	@RequestMapping("/beforeDelete.do")
	public String beforeDelete() throws Exception {
		return "/mypage/beforeDelete";
	}

	@RequestMapping("/updateMyInfo.do")
	public String updateMyInfo() throws Exception {
		return "/mypage/updateMyInfo";
	}
	
	
	@RequestMapping(value = "/deletePwChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> deletePwChk(@RequestBody HashMap<String, String> deleteMemberMap,
			HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		Map<String, String> memberMap = new HashMap<String, String>();
		String member_pw = deleteMemberMap.get("member_pw");

		HttpSession session = request.getSession();
		session = request.getSession();
		MemberVO tempMember = (MemberVO) session.getAttribute("memberInfo");

		memberMap.put("member_id", tempMember.getMember_id());
		memberMap.put("member_pw", member_pw);

		MemberVO memberVO = myPageService.isPwCorrect(memberMap);

		if (memberVO != null) {
			map.put("status", "true");
		} else {
			map.put("status", "false");
			map.put("message", "일치하는 회원정보가 없습니다.");
		}
		return map;
	}
	
	@RequestMapping(value = "/deleteMember.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> deleteMember(@RequestBody HashMap<String, String> deleteMemberMap,
			HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		Map<String, String> memberMap = new HashMap<String, String>();
		String member_pw = deleteMemberMap.get("member_pw");
		HttpSession session = request.getSession();
		session = request.getSession();
		MemberVO tempMember = (MemberVO) session.getAttribute("memberInfo");
		memberMap.put("member_id", tempMember.getMember_id());
		memberMap.put("member_pw", member_pw);
		MemberVO memberVO = myPageService.deleteMember(memberMap);
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");
		
		if (memberVO == null) {
			map.put("status", "true");
			map.put("message", "탈퇴되었습니다. 안녕히가세요.");
			map.put("url", "/");
		} else {
			map.put("status", "false");
			map.put("message", "탈퇴를 실패했습니다.");
		}
		return map;
	}

	@RequestMapping(value = "/updatePwChk.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updatePwChk(@RequestBody HashMap<String, String> updateMemberMap,
			HttpServletRequest request) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		Map<String, String> memberMap = new HashMap<String, String>();
		String member_pw = updateMemberMap.get("member_pw");

		HttpSession session = request.getSession();
		session = request.getSession();
		MemberVO tempMember = (MemberVO) session.getAttribute("memberInfo");

		memberMap.put("member_id", tempMember.getMember_id());
		memberMap.put("member_pw", member_pw);

		MemberVO memberVO = myPageService.isPwCorrect(memberMap);

		if (memberVO != null) {
			map.put("status", "true");
			map.put("url", "/mypage/updateMyInfo.do");
		} else {
			map.put("status", "false");
			map.put("message", "일치하는 회원정보가 없습니다.");
		}
		return map;
	}

	@RequestMapping(value = "/modifyMyInfo.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> modifyMyInfo(@RequestBody HashMap<String, String> modifyMap, HttpServletRequest request)
			throws Exception {
		Map<String, String> memberMap = new HashMap<String, String>();
		Map<String, String> resultMap = new HashMap<String, String>();
		String val[] = null;
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();

		String attribute = modifyMap.get("attribute");
		String value = modifyMap.get("value");

		if (attribute.equals("address")) {
			val = value.split(",");
			memberMap.put("zipcode", val[0]);
			memberMap.put("roadAddress", val[1]);
			memberMap.put("jibunAddress", val[2]);
			memberMap.put("namujiAddress", val[3]);
		} else {
			memberMap.put(attribute, value);
		}

		memberMap.put("member_id", member_id);

		memberVO = (MemberVO) myPageService.modifyMyInfo(memberMap);
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);

		if (memberVO != null) {
			resultMap.put("message", "mod_success");
			resultMap.put("url", "/mypage/myDetailInfo.do");
		} else {
			resultMap.put("message", "failed");
		}
		return resultMap;
	}

	@RequestMapping(value = "/updateMember.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> updateMember(@RequestBody HashMap<String, String> modifyMap, HttpServletRequest request)
			throws Exception {
		Map<String, String> resultMap = new HashMap<String, String>();
		String val[] = null;
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
		String member_id = memberVO.getMember_id();

		val = modifyMap.get("address").split(",");
		modifyMap.put("zipcode", val[0]);
		modifyMap.put("roadAddress", val[1]);
		modifyMap.put("jibunAddress", val[2]);
		modifyMap.put("namujiAddress", val[3]);

		modifyMap.put("member_id", member_id);

		memberVO = (MemberVO) myPageService.updateMember(modifyMap);
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);

		if (memberVO != null) {
			resultMap.put("message", "mod_success");
			resultMap.put("url", "/mypage/myDetailInfo.do");
		} else {
			resultMap.put("message", "failed");
		}
		return resultMap;
	}
}
