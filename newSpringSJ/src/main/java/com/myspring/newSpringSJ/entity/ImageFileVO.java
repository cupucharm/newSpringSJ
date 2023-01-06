package com.myspring.newSpringSJ.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ImageFileVO {
	private int goods_id;
	private int image_id;
	private String fileName;
	private String fileType;
	private String reg_id;
}
