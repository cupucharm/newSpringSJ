package com.myspring.newSpringSJ.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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

//	@RequestMapping(value = "/modifyMyInfo.do", method = RequestMethod.POST)
//	@ResponseBody
//	public Map<String, String> modifyMyInfo(@RequestBody HashMap<String, String> modifyMap, HttpServletRequest request,
//			HttpServletResponse response) throws Exception {
//		Map<String, String> memberMap = new HashMap<String, String>();
//		String val[] = null;
//		HttpSession session = request.getSession();
//		MemberVO memberVO = (MemberVO) session.getAttribute("memberInfo");
//		String member_id = memberVO.getMember_id();
//
//		memberMap.put(modifyMap.get("attribute"), modifyMap.get("value"));
//		memberMap.put("member_id", member_id);
//
//		memberVO = (MemberVO) myPageService.modifyMyInfo(memberMap);
//		session.removeAttribute("memberInfo");
//		session.setAttribute("memberInfo", memberVO);
//
//		String message = null;
//		ResponseEntity resEntity = null;
//		HttpHeaders responseHeaders = new HttpHeaders();
//		message = "mod_success";
//		resEntity = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
//		return resEntity;
//	}
}
