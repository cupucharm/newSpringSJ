package com.myspring.newSpringSJ.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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

import com.myspring.newSpringSJ.entity.GoodsVO;
import com.myspring.newSpringSJ.service.GoodsService;

@Controller("goodsController")
@RequestMapping("/goods")
public class GoodsController extends BaseController {
	
	@Autowired
	private GoodsService goodsService;

	@RequestMapping("/goodsDetail.do")
	public String goodsDetail(@RequestParam("goods_id") String goods_id, HttpServletRequest request,
			HttpServletResponse response, Model model) throws Exception {

		HttpSession session = request.getSession();
		Map<String, Object> goodsMap = goodsService.goodsDetail(goods_id);
		model.addAttribute("goodsMap", goodsMap);
		GoodsVO goodsVO = (GoodsVO) goodsMap.get("goodsVO");
		//addGoodsInQuick(goods_id, goodsVO, session);
		return "/goods/goodsDetail";
	}

	@RequestMapping(value = "/keywordSearch.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> keywordSearch(@RequestBody HashMap<String, String> searchMap) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		String keyword = searchMap.get("keyword");
		if (keyword == null || keyword.equals("") ||keyword.length()==0) {
			return map;
		}
		keyword = keyword.toUpperCase();
		List<String> keywordList = goodsService.keywordSearch(keyword);

		map.put("keyword", keywordList);
		return map;
	}

	@RequestMapping(value = "/searchGoods.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> searchGoods(@RequestBody HashMap<String, String> searchMap, HttpSession session) throws Exception {
		String searchWord = searchMap.get("searchWord");
		String goods_status = searchMap.get("goods_status");
		Map<String, Object> map = new HashMap<>();
		
		List<GoodsVO> goodsList = goodsService.searchGoods(searchMap);
		
		if (goods_status!=null && searchWord.equals("%")) {
			searchWord = "전체 도서 목록";
		} else if (goods_status!=null && searchWord.equals("1")) {
			searchWord = "베스트 셀러";
		} else if (goods_status!=null && searchWord.equals("2")) {
			searchWord = "스테디 셀러";
		} else if (goods_status!=null && searchWord.equals("3")) {
			searchWord = "새로 나온 도서";
		} else {
			searchWord = "'"+searchWord +"'" + " 검색 결과";
		}
		
		
		session.setAttribute("searchWord", searchWord);
		session.setAttribute("goodsList", goodsList);
		
		return map;

	}
	
	@RequestMapping("/goodsList.do")
	public String goodsList() throws Exception {
		return "/goods/goodsList";
	}

}
