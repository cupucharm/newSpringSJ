package com.myspring.newSpringSJ.entity;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderVO {
	private int order_seq_num;
	private String member_id;
	private int order_id;
	private int goods_id;
	private String goods_title;
	private int goods_sales_price;
	private int total_goods_price;
	private int cart_goods_qty; 
	private int order_goods_qty; 
	private String orderer_name;
	private String receiver_name;
	private String receiver_phone;
	
	private String delivery_address;
	private String delivery_message;
	private String delivery_method;
	private String gift_wrapping;
	private String pay_method;
	private String card_com_name;
	private String card_pay_month;
	private String pay_orderer_hp_num; 
	private String pay_order_time;
	private String delivery_state;  
	
	private String final_total_price;
	private int goods_qty;
	private String goods_fileName;
	private String orderer_hp;
	
}
