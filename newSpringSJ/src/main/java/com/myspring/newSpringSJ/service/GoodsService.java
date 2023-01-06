package com.myspring.newSpringSJ.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myspring.newSpringSJ.entity.GoodsVO;
import com.myspring.newSpringSJ.entity.ImageFileVO;
import com.myspring.newSpringSJ.mapper.GoodsDAO;

@Service("goodsService")
public class GoodsService {
	
	@Autowired
	private GoodsDAO goodsDAO;
	
	public Map<String, List<GoodsVO>> listGoods() {
		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList(1);
		goodsMap.put("bestseller",goodsList);
		
		goodsList=goodsDAO.selectGoodsList(3);
		goodsMap.put("newbook",goodsList);
		
		goodsList=goodsDAO.selectGoodsList(2);
		goodsMap.put("steadyseller",goodsList);
		return goodsMap;
	}
	
	public Map<String, Object> goodsDetail(String _goods_id) throws Exception {
		Map<String, Object>  goodsMap=new HashMap<>();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(_goods_id);
		goodsMap.put("goodsVO", goodsVO);
		
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(_goods_id);
		goodsMap.put("imageList", imageList);
		return goodsMap;
	}

	public List<String> keywordSearch(String keyword) {
		return goodsDAO.selectKeywordSearch(keyword);
	}

	public List<GoodsVO> searchGoods(String searchWord) {
		return goodsDAO.selectGoodsBySearchWord(searchWord);
	}
}