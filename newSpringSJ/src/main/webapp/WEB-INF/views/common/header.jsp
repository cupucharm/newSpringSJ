<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	var loopSearch=true;
	function keywordSearch(){
		if(loopSearch==false)
			return;
	 	
		var value=document.frmSearch.searchWord.value;
		fetch("${contextPath}/goods/keywordSearch.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"keyword": value
			})
		})
		.then(response => response.json())
		.then(jsonResult => {
			displayResult(jsonResult)
		});	
	}
	
	function displayResult(jsonInfo){
		if(jsonInfo.keyword != "") {
		    var html = '';
		    for(var i in jsonInfo.keyword){
			   html += "<a href=\"javascript:select('"+jsonInfo.keyword[i]+"')\">"+jsonInfo.keyword[i]+"</a><br/>";
		    }
		    var listView = document.getElementById("suggestList");
		    listView.innerHTML = html;
		    show('suggest');
		}else{
		    hide('suggest');
		} 
	}
	
	function select(selectedKeyword) {
		 document.frmSearch.searchWord.value=selectedKeyword;
		 loopSearch = false;
		 hide('suggest');
	}
		
	function show(elementId) {
		 var element = document.getElementById(elementId);
		 if(element) {
		  element.style.display = 'block';
		 }
		}
	
	function hide(elementId){
	   var element = document.getElementById(elementId);
	   if(element){
		  element.style.display = 'none';
	   }
	}
	
	
	/* 	let searchbtn = document.querySelector("#searchbtn");
	if (searchbtn != null) {
		searchbtn.onclick = (e) => {
			searchGoods(e);
		}
	}

	function search(e) {
		e.preventDefault();
		var value=document.frmSearch.searchWord.value;
		
		fetch("${contextPath}/goods/searchGoods.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"searchKey": value
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				
			});
		
		} */
	
	function searchGoods(e) {
			e.preventDefault();
		let searchWord = document.querySelector("#searchWord").value;
		if (searchWord==null || searchWord=='' || searchWord.length == 0){
			alert("검색어를 입력하세요");
	   		return;
	    }

		fetch("${contextPath}/goods/searchGoods.do", {
			//option
			method: 'POST',
			headers: {
				'Content-Type': 'application/json;charset=utf-8'
			},
			body: JSON.stringify({
				"searchWord" : searchWord
			})
		})
			.then(response => response.json())
			.then(jsonResult => {
				location.href = "/goods/searchGoodsForm.do";
			});
	}

</script>




<body>
	<!-- Topbar -->
	<nav
		class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
		<!-- Sidebar Toggler (Sidebar) -->
		<div class="text-center d-none d-md-inline">
			<button class="rounded-circle border-0" id="sidebarToggle"
				style="background-color: white;">
				<i class="fas fa-bars" style="color: #4e73df;"></i>
			</button>
		</div>

		<div>
			<a href="/"> BOOKDUKE</a>
		</div>

		<!-- Sidebar Toggle (Topbar) -->
		<button id="sidebarToggleTop"
			class="btn btn-link d-md-none rounded-circle mr-3">
			<i class="fa fa-bars"></i>
		</button>

		<!-- Topbar Search -->
		<form name="frmSearch" action="${contextPath}/goods/searchGoods.do"
			class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search"
			style="width: 50rem; padding-left: 23rem;" onsubmit="return false;">
			<input type="hidden" name="xxxx" id="xxxx" value="xxxx" />

			<div class="input-group">

				<span style="padding: 6 12; color: #4e73df; font-weight: 700" onclick="location.href='/'">부크듀크 </span> 
				<input type="text" class="form-control bg-light border-0 small" name="searchWord" 
					id="searchWord" onKeyUp="keywordSearch()" 
					placeholder="찾으시는 도서를 검색하세요!"> 
				<div class="input-group-append">
					<button class="btn btn-primary" type="button" id="searchbtn" onclick="searchGoods(event)">
						<i class="fas fa-search fa-sm"></i>
					</button>
				</div>
			</div>

		</form>
		<div id="suggest">
        <div id="suggestList"></div>
   </div>

		<!-- Topbar Navbar -->
		<ul class="navbar-nav ml-auto">

			<!-- Nav Item - Search Dropdown (Visible Only XS) -->
			<li class="nav-item dropdown no-arrow d-sm-none"><a
				class="nav-link dropdown-toggle" href="#" id="searchDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
			</a> <!-- Dropdown - Messages -->
				<div
					class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
					aria-labelledby="searchDropdown">
					<form class="form-inline mr-auto w-100 navbar-search">
						<div class="input-group">
							<input type="text" class="form-control bg-light border-0 small"
								placeholder="Search for..." aria-label="Search"
								aria-describedby="basic-addon2">
							<div class="input-group-append">
								<button class="btn btn-primary" type="button">
									<i class="fas fa-search fa-sm"></i>
								</button>
							</div>
						</div>
					</form>
				</div></li>



			<!-- Nav Item - User Information -->
			<li class="nav-item dropdown no-arrow">
			<c:choose>
					<c:when test="${not empty memberInfo}">
						<a class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
							class="mr-2 d-none d-lg-inline text-gray-600 small">${memberInfo.member_name } 님</span>

							<img class="img-profile rounded-circle"
							src="<c:url value='/resources/img/person.svg'/>">


						</a>
					</c:when>
					<c:otherwise>
						<a href="/member/loginForm.do"
							style="font-weight: 600; margin-right: 0.7rem;">로그인</a>
						<a href="/member/memberForm.do"
							style="font-weight: 600; margin-right: 0.7rem;">회원가입</a>
					</c:otherwise>
				</c:choose> 
				<div
					class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
					aria-labelledby="userDropdown">

					<c:choose>
						<c:when test="${not empty memberInfo}">
							<a class="dropdown-item" href="<c:url value='/mypage/myDetailInfo.do'/>">  <i class="bi bi-emoji-smile"></i> 마이페이지
							</a>
							<a class="dropdown-item" href="<c:url value='/mypage/myPageMain.do'/>"> <i class="bi bi-bag-heart"></i> 주문 조회
							</a>
							<div class="dropdown-divider"></div>
							<a class="dropdown-item"
								href="#" onclick='location.href = "<c:url value='/member/logout.do'/>"' data-toggle="modal"> <i class="bi bi-box-arrow-right"></i>
								로그아웃
							</a>
						</c:when>

						<c:otherwise>
							<a class="dropdown-item" href="#"> <i class="bi bi-person"></i>
							<!-- <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i> -->
								로그인
							</a>
							<a class="dropdown-item" href="#"> <i class="bi bi-door-open"></i>
							<!-- <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i> -->
								회원가입
							</a>

						</c:otherwise>
					</c:choose>
				</div></li>

		</ul>

	</nav>
	<!-- End of Topbar -->
</body>
</html>