<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"
    isELIgnored="false"
    %>
<%-- <%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>  --%> 
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
 <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar" style="position: fixed;">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="/">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                
                <div class="sidebar-brand-text mx-3">BOOKDUKE</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
				<div style="text-align: center; color:white;">부크듀크</div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                BOOK
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="bi bi-book"></i>
                    <span>도서 목록</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">도서 목록:</h6>
                        <a class="collapse-item" href="buttons.html">베스트셀러</a>
                        <a class="collapse-item" href="buttons.html">스테디셀러</a>
                        <a class="collapse-item" href="buttons.html">새로나온책</a>
                        <a class="collapse-item" href="cards.html">IT/인터넷</a>
                    </div>
                </div>
            </li>


            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                BOARD
            </div>
            
            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.html">
                    <i class="bi bi-check2-square"></i>
                    <span>공지사항</span></a>
            </li>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="bi bi-clipboard-check"></i>
                    <span>게시판</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">게시판:</h6>
                        <a class="collapse-item" href="register.html">자유게시판</a>
                        <a class="collapse-item" href="register.html">Q&A</a>
                        <!-- <div class="collapse-divider"></div> -->
                    </div>
                </div>
            </li>
            
             <c:if test="${not empty memberInfo}">
            <!-- Divider -->
            <hr class="sidebar-divider">


            <!-- Heading -->
            <div class="sidebar-heading">
               MYPAGE
            </div>
            
            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="<c:url value='/mypage/myPageMain.do'/>">
                    <i class="bi bi-bag-heart"></i>
                    <span>주문 조회</span></a>
            </li>

            <!-- Nav Item - Pages Collapse Menu -->
           
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2"
                    aria-expanded="true" aria-controls="collapsePages">
                   <i class="bi bi-emoji-smile"></i>
                    <span>마이페이지</span>
                </a>
                <div id="collapsePages2" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">마이페이지:</h6>
                        <a class="collapse-item" href="<c:url value='/mypage/myDetailInfo.do'/>">회원정보 보기</a>
                        <a class="collapse-item" href="<c:url value='/mypage/beforeUpdate.do'/>">회원정보 수정</a>
                        <a class="collapse-item" href="<c:url value='/mypage/beforeDelete.do'/>">회원 탈퇴</a>
                    </div>
                </div>
            </li>
            </c:if>
            

            


            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">
				<div class="text-center d-none d-md-inline">
               		 <button class="rounded-circle border-0" id="sidebarToggle" style="margin: 30px;position: absolute;
    bottom: 0;"></button>
           		 </div>
           
        </ul>
        <!-- End of Sidebar -->
</html>