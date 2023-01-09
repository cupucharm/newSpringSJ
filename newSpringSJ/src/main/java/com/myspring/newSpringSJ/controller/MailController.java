package com.myspring.newSpringSJ.controller;


import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.newSpringSJ.service.MailService;


@Controller("mailController")
@EnableAsync	//비동기로 호출되어서 동작함
@RequestMapping("/mail")
public class MailController {

	@Autowired
	MailService mailService;

	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public Map<String, String> mailCheck(@RequestBody HashMap<String, String> emailMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		String toMail = emailMap.get("email");
		
		Random random = new Random();
		String checkNum = Integer.toString(random.nextInt(888888) + 111111);
		
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/mail/emailValidation.html"), "utf-8"));
		StringBuilder str = new StringBuilder();
		reader.lines().forEach(lineText -> {
			str.append(lineText);
		});
		
		String content =  str.toString();
		content = content.replace("${checkNum}", checkNum);
		
        String title = "[BOOKDUKE] 부크듀크 서점 회원가입 인증 이메일입니다.";
        
        mailService.sendMail(toMail, title, content);
        
        map.put("num", checkNum);
        return map;
	}
		
	
	@RequestMapping("/registerMail.do")
	@ResponseBody
	public Map<String, String> registerMail(@RequestBody HashMap<String, String> emailMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		String toMail = emailMap.get("email");	
		String member_id = emailMap.get("member_id");
		String member_name = emailMap.get("member_name");
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/mail/registerSuccess.html"), "utf-8"));
		StringBuilder str = new StringBuilder();
		reader.lines().forEach(lineText -> {
			str.append(lineText);
		});
		
		String content =  str.toString();
		content = content.replace("${member_id}", member_id);
		content = content.replace("${member_name}", member_name);
		
        String title = "[BOOKDUKE] 부크듀크 서점 회원가입을 축하드립니다.";
        
        mailService.sendMail(toMail, title, content);
        
        return map;
	}
	
	@RequestMapping("/changePw.do")
	@ResponseBody
	public Map<String, String> changePw(@RequestBody HashMap<String, String> emailMap) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		
		String toMail = emailMap.get("email");
		
		Random random = new Random();
		String checkNum = Integer.toString(random.nextInt(888888) + 111111);
		
		
		BufferedReader reader = new BufferedReader(new InputStreamReader(getClass().getResourceAsStream("/mail/changePw.html"), "utf-8"));
		StringBuilder str = new StringBuilder();
		reader.lines().forEach(lineText -> {
			str.append(lineText);
		});
		
		String content =  str.toString();
		content = content.replace("${checkNum}", checkNum);
		
        String title = "[BOOKDUKE] 부크듀크 서점 비밀번호 변경 이메일입니다.";
        
        mailService.sendMail(toMail, title, content);
        
        map.put("num", checkNum);
        return map;
	}
	
}