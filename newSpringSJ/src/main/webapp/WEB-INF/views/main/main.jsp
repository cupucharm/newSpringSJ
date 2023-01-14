<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BOOKDUKE</title>

</head>
<body>

<div id="holeMain" style="margin-left:7rem;margin-right:5rem;">
<div class="main_book">
   <c:set  var="goods_count" value="0" />
	<h3>베스트셀러</h3>
	<c:forEach var="item" items="${goodsMap.bestseller }">
	   <c:set  var="goods_count" value="${goods_count+1 }" />
		<div class="book">
			<a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
			<img class="link"  src="${contextPath}/resources/image/1px.gif"> 
			</a> 
				<img width="121" height="154" 
				     src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">

			<div class="title">${item.goods_title }</div>
			<div class="price" style="text-decoration: line-through;">
				  <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
		  	   <fmt:parseNumber var="percent" integerOnly="true" value="${ (item.goods_price - item.goods_sales_price) /item.goods_price * 100 }"/>
				             ${goods_sales_price}원(${percent}%할인)
			</div>
		</div>
	   <c:if test="${goods_count==15   }">
         <div class="book">
           <font size=20> <a onclick="showGoods(this)" data-value="1">더보기</a></font>
         </div>
     </c:if>
  </c:forEach>
</div>
<div class="clear"></div>

<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3>새로 출판된 책</h3>
	<c:forEach var="item" items="${goodsMap.newbook }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
		<div class="book">
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="121" height="154" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price" style="text-decoration: line-through;">
				  <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
		  	   <fmt:parseNumber var="percent" integerOnly="true" value="${ (item.goods_price - item.goods_sales_price) /item.goods_price * 100 }"/>
				             ${goods_sales_price}원(${percent}%할인)
			</div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="book">
       <font size=20> <a onclick="showGoods(this)" data-value="3">더보기</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>

<div class="clear"></div>



<div class="main_book" >
<c:set  var="goods_count" value="0" />
	<h3>스테디셀러</h3>
	<c:forEach var="item" items="${goodsMap.steadyseller }" >
	   <c:set  var="goods_count" value="${goods_count+1 }" />
		<div class="book">
		  <a href="${contextPath}/goods/goodsDetail.do?goods_id=${item.goods_id }">
	       <img class="link"  src="${contextPath}/resources/image/1px.gif"> 
	      </a>
		 <img width="121" height="154" 
				src="${contextPath}/thumbnails.do?goods_id=${item.goods_id}&fileName=${item.goods_fileName}">
		<div class="title">${item.goods_title }</div>
		<div class="price" style="text-decoration: line-through;">
				  <fmt:formatNumber  value="${item.goods_price}" type="number" var="goods_price" />
		          ${goods_price}원
			</div>
			<div class="price">
		  	   <fmt:formatNumber  value="${item.goods_sales_price}" type="number" var="goods_sales_price" />
		  	   <fmt:parseNumber var="percent" integerOnly="true" value="${ (item.goods_price - item.goods_sales_price) /item.goods_price * 100 }"/>
				             ${goods_sales_price}원(${percent}%할인)
			</div>
	</div>
	 <c:if test="${goods_count==15   }">
     <div class="book">
       <font size=20> <a onclick="showGoods(this)" data-value="2">더보기</a></font>
     </div>
   </c:if>
	</c:forEach>
</div>
</div>
<script type="text/javascript">
<script type="text/javascript">


function showGoods(item) {
	
	fetch("${contextPath}/goods/searchGoods.do", {
		//option
		method: 'POST',
		headers: {
			'Content-Type': 'application/json;charset=utf-8'
		},
		body: JSON.stringify({
			"searchWord": item.getAttribute('data-value'),
			"pageNum" : "1",
			"goods_status" : "goods_status"
		})
	})
	.then(response => response.json())
	.then(jsonResult => {
		location.href = "/goods/goodsList.do";
	});
	
	}
</script>

</body>
</html>