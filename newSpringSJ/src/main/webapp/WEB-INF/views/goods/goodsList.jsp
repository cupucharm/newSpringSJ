<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
     //치환 변수 선언합니다.
      pageContext.setAttribute("crcn", "\r\n"); //Space, Enter
      pageContext.setAttribute("br", "<br/>"); //br 태그
%> 
<head>
 <title>BOOKDUKE : 도서 목록</title>
</head>
<body id="searchDiv">
<div style="margin-left: 4rem;">
<input type="hidden" name="isLogOn" id="isLogOn" value="${isLogOn}"/>
<c:choose>
			   <c:when test="${ empty goodsList  }" >
					<div id="book">
						<h1 style="text-align: center; width: 100%; height: 100%;">찾으시는 제품이 없습니다.</h1>
					  </div>
			   </c:when>
			   <c:otherwise>
			   <h1
			style="text-align: center; font-size: 30px; font-weight: 600; color: #4e73df; margin-top: 3rem; margin-bottom: 2rem;">${searchWord }</h1>
	<table id="list_view">
		<tbody>
		
		
		  <c:forEach var="item" items="${goodsList }"> 
			<tr>
					<td class="goods_image">
						<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id}">
							   <img width="75" alt="" src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
						</a>
					</td>
					<td class="goods_description">
						<h2>
							<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">${item.goods_title }</a>
						</h2>
						<c:set var="goods_pub_date" value="${item.goods_published_date }" />
					   <c:set var="arr" value="${fn:split(goods_pub_date,' ')}" />
						<div class="writer_press"  >${item.goods_writer }저
							|${item.goods_publisher }|<c:out value="${arr[0]}" />
						</div>
					</td>
					<td class="price"><span>${item.goods_price }원</span><br>
						<strong>
						 <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="discounted_price" />
					   <fmt:parseNumber var="percent" integerOnly="true" value="${ (item.goods_price - item.goods_sales_price) /item.goods_price * 100 }"/>
				               ${discounted_price}원
						</strong><br>(${percent }% 할인)
						
					</td>
					<td><input type="checkbox" value=""></td>
					<td class="buy_btns">
						<UL>
							<li style="float: left;"><a id="addCaart" data-id="${item.goods_id }" onclick="add_cart(this)" >장바구니</a></li>
							<li style="float: left;">
							<a class="buy" 
							data-id="${item.goods_id }" data-title="${item.goods_title }"
							data-price="${ item.goods_price}" data-sale="${ item.goods_sales_price}"
							data-fileName="${item.goods_fileName}" data-delivery="${item.goods_delivery_price}"
							onclick="fn_order_each_goods(this)">구매하기</a></li>
						</UL>
					</td>
			</tr>
			</c:forEach>
			
		</tbody>
	</table>
	<div class="clear"></div>

	 </c:otherwise>
			 </c:choose>
			 </div>
			 
<script type="text/javascript">

function add_cart(obj) {
	let goods_id = obj.getAttribute('data-id');
		fetch("${contextPath}/cart/addGoodsInCart.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"goods_id": goods_id
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				if(jsonResult.result=='add_success'){
					  if (confirm("장바구니에 추가했습니다. \n장바구니로 이동하시겠습니까?")) {
						  location.href = '${contextPath}/cart/myCartList.do';
				        }
				}else if(jsonResult.result=='already_existed'){
					if (confirm("이미 장바구니에 담긴 상품입니다. \n장바구니로 이동하시겠습니까?")) {
						  location.href = '${contextPath}/cart/myCartList.do';
				        }
				} else if(jsonResult.result=='please_login'){
					alert("로그인 해주세요.");
					location.href = jsonResult.url;
				}
			});
}

function fn_order_each_goods(obj){
	var isLogOn=document.getElementById("isLogOn").value;
	
	 if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다");
		location.href="/member/loginForm.do"
	} 
	
		
	fetch("${contextPath}/order/orderEachGoods.do", {
		//option
		method: 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			"goods_id": obj.getAttribute('data-id'),
			"goods_title": obj.getAttribute('data-title'),
			"goods_price": obj.getAttribute('data-price'),
			"goods_sales_price": obj.getAttribute('data-sale'),
			"goods_fileName": obj.getAttribute('data-fileName'),
			"order_goods_qty": "1",
			"goods_delivery_price": obj.getAttribute('data-delivery')
		})
	})
		.then(response => response.json())
		.then(jsonResult => {
			location.href = jsonResult.url;
		});

	}	
</script>