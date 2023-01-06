package com.myspring.newSpringSJ.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyPageVO {
	private String member_id;
	private String beginDate;
	private String endDate;
	
}
