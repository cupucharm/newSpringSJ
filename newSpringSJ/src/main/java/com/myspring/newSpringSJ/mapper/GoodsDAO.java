package com.myspring.newSpringSJ.mapper;

import java.util.List;

import com.myspring.newSpringSJ.entity.GoodsVO;
import com.myspring.newSpringSJ.entity.ImageFileVO;


public interface GoodsDAO {
	List<GoodsVO> selectGoodsList(int goods_status);

	GoodsVO selectGoodsDetail(String _goods_id);

	List<ImageFileVO> selectGoodsDetailImage(String _goods_id);

	List<String> selectKeywordSearch(String keyword);

	List<GoodsVO> selectGoodsBySearchWord(String searchWord);
}
