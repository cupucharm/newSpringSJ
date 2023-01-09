package com.myspring.newSpringSJ.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import com.myspring.newSpringSJ.service.MemberService;



@Controller("memberController")
@RequestMapping("/member")
public class MemberController extends BaseController {
	

	@Autowired
	private MemberService memberService;
	

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> login(@RequestBody HashMap<String, String> loginMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		MemberVO memberVO = memberService.login(loginMap);

		if (loginMap.get("member_id") == null || loginMap.get("member_id").length() <= 0) {
			map.put("status", "blank");
			map.put("message", "아이디를 입력하세요.");
		} else if (loginMap.get("member_pw") == null || loginMap.get("member_pw").length() <= 0) {
			map.put("status", "blank");
			map.put("message", "비밀번호를 입력하세요.");
		} else if (memberVO != null && memberVO.getMember_id() != null) {
			HttpSession session = request.getSession();
			session = request.getSession();
			session.setAttribute("isLogOn", true);
			session.setAttribute("memberInfo", memberVO);
			map.put("status", "success");
			map.put("message", memberVO.getMember_name() + "님 어서오세요!");

			map.put("url", "/");

		} else {
			map.put("status", "fail");
			map.put("message", "회원정보가 일치하지 않습니다. 다시 로그인해주세요.");
			map.put("url", "loginForm.do");
		}
		return map;
	}
	
	@RequestMapping(value = "/isExistId.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> isExistId(@RequestBody HashMap<String, String> searchPwMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		MemberVO memberVO = memberService.isExistId(searchPwMap);

		if (memberVO != null) {
			map.put("status", "success");
		} else {
			map.put("status", "fail");
			map.put("message", "일치하는 회원정보가 없습니다.");
		}
		return map;
	}

	@RequestMapping("/loginForm.do")
	public String loginForm() throws Exception {
		return "/member/loginForm";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception {

		HttpSession session = request.getSession();
		session.setAttribute("isLogOn", false);
		session.removeAttribute("memberInfo");

		return "redirect:/";
	}

	@RequestMapping("/memberForm.do")
	public String memberForm() throws Exception {
		return "/member/memberForm";
	}
	
	@RequestMapping("/searchIdForm.do")
	public String searchIdForm() throws Exception {
		return "/member/searchIdForm";
	}
	
	@RequestMapping("/searchPwForm.do")
	public String searchPwForm() throws Exception {
		return "/member/searchPwForm";
	}
	
	@RequestMapping("/changePwForm.do")
	public String changePwForm() throws Exception {
		return "/member/changePwForm";
	}
	
	@RequestMapping("/searchPw.do")
	@ResponseBody
	public Map<String, String> searchPw(@RequestBody HashMap<String, String> changePwMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", changePwMap.get("member_id"));
		map.put("url", "/member/changePwForm.do");
		return map;
	}

	@RequestMapping(value = "/addMember.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> addMember(@RequestBody HashMap<String, String> registerMap, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		Map<String, String> map = new HashMap<String, String>();
		String pw = registerMap.get("member_pw");
		String pwChk = registerMap.get("pwdConfirm");

		if (incorrectPw(pw, pwChk)) {
			map.put("pwd", "fail");
			map.put("message", "비밀번호가 일치하지 않습니다.");
		} else {		
			if (notNullCheck(registerMap)) {
				memberService.addMember(registerMap);
				map.put("status", "success");
				map.put("message", registerMap.get("member_name") + "님 회원가입을 축하드립니다.");
				map.put("url", "loginForm.do");
			
			} else {
				map.put("message", "빈칸을 작성해주세요.");
			}
		}
		return map;
	}

	@RequestMapping("/overlapped.do")
	@ResponseBody
	public Map<String, String> overlapped(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		String result = memberService.overlapped(id);
		map.put("result", result);
		return map;
	}
	
	
	
	@RequestMapping(value = "/searchId.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> searchId(@RequestBody HashMap<String, String> searchIdMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		String member_name = searchIdMap.get("member_name");
		String member_id = memberService.searchId(searchIdMap);

		if (member_id != null) {
			map.put("message", member_name+ "님의 ID는 [" +member_id + "]입니다.");
		} else {
			map.put("message", "일치하는 회원정보가 없습니다.");
		}
		return map;
	}

	
	
	@RequestMapping(value = "/isMailExist.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> isMailExist(@RequestBody HashMap<String, String> isMailExistMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();

		String mailExist = memberService.isMailExist(isMailExistMap);
		if (mailExist.equals("true")) {
			map.put("status", "true");
			map.put("message", "이미 가입한 회원입니다.");
		} else {
			map.put("status", "false");
		}
		return map;
	}
	
	
	@RequestMapping(value = "/changePw.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> changePw(@RequestBody HashMap<String, String> pwMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		if (!pwMap.get("member_pw").equals(pwMap.get("pwdConfirm"))) {
			map.put("status", "false");
			map.put("message", "비밀번호가 불일치합니다");
		} else {
			memberService.changePw(pwMap);
			map.put("status", "true");
			map.put("message", "비밀번호가 변경되었습니다");
			map.put("url", "/member/loginForm.do");
		}
		
		
		
		return map;
	}
	
	
	
	
	public boolean notNullCheck(HashMap<String, String> registerMap) {
		String a = registerMap.get("member_id");
		String b = registerMap.get("member_pw");
		String c = registerMap.get("member_name");
		String d = registerMap.get("member_gender");
		String e = registerMap.get("member_birth");
		String f = registerMap.get("member_phone");
		String g = registerMap.get("email");
		String h = registerMap.get("zipcode");
		String i = registerMap.get("roadAddress");
		String j = registerMap.get("jibunAddress");
		String k = registerMap.get("namujiAddress");
		
		if (a == null || a.length() <= 0 || b == null || b.length() <= 0 || c == null || c.length() <= 0 || d == null
				|| d.length() <= 0 || e == null || e.length() <= 0 || f == null || f.length() <= 0 || g == null
				|| g.length() <= 0 || h == null || h.length() <= 0 || i == null || i.length() <= 0 || j == null
				|| j.length() <= 0 || k == null || k.length() <= 0) {
			return false;
		} else {
			return true;
		}
	}
	
	public boolean incorrectPw(String pw1, String pw2) {
		if (pw1.equals(pw2)) {
			return false;
		} else {
			return true;
		}
	}

}
