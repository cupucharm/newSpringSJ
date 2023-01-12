package com.myspring.newSpringSJ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.myspring.newSpringSJ.entity.GoodsVO;
import com.myspring.newSpringSJ.service.GoodsService;

/**
 * Handles requests for the application home page.
 */
@Controller("mainController")
public class MainController extends BaseController {
	@Autowired
	private GoodsService goodsService;
	
	@RequestMapping("/")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		HttpSession session;
		
		session=request.getSession();
		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		
		model.addAttribute("goodsMap", goodsMap);
		return "/main/main";
	}
	
}