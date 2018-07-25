<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">내 예약목록</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">내 예약목록</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div id="content">
        <div class="container">
          <div class="row bar mb-0">
            <div id="customer-orders" class="col-md-9">
              <div class="box mt-0 mb-lg-0">
                <div class="table-responsive">
                  <table class="table table-hover">
                    <thead>
                      <tr>
                        <th>예약일</th>
                        <th>예약 객실</th>
                        <th>예약 인원</th>
                        <th>체크인</th>
                        <th>체크아웃</th>
                        <th>예약 금액</th>
                        <th>예약 상태</th>
                        <th>입금 확인</th>
                      </tr>
                    </thead>
                    <tbody>
                    	<c:choose>
                    		<c:when test="${fn:length(reservList) <= 0}">
                    			<tr>
                    				<td colspan="8">예약 내역이 없습니다.</td>
                    		</c:when>
                    		<c:otherwise>
		                    	<c:forEach var="reservList" items="${reservList}" varStatus="status">
		                    		<tr>
		                    			<td><fmt:formatDate value="${reservList.reserv_date}" pattern="yyyy/MM/dd"/></td>
		                    			<td>${reservList.room_name}</td>
		                    			<td>${reservList.reserv_people}</td>
		                    			<td><fmt:formatDate value="${reservList.reserv_checkin}" pattern="yyyy/MM/dd"/></td>
		                    			<td><fmt:formatDate value="${reservList.reserv_checkout}" pattern="yyyy/MM/dd"/></td>
		                    			<td><fmt:formatNumber value="${reservList.reserv_price}" type="number" pattern="#,###"/>&nbsp;원</td>
		                    			<td>${reservList.reserv_status}</td>
		                    			<td>${reservList.reserv_paychk}</td>
		                    		</tr>
		                    	</c:forEach>
                    		</c:otherwise>
                    	</c:choose>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <div class="col-md-3 mt-4 mt-md-0">
              <!-- CUSTOMER MENU -->
              <div class="panel panel-default sidebar-menu">
                <div class="panel-heading">
                  <h3 class="h4 panel-title">Customer section</h3>
                </div>
                <div class="panel-body">
                  <ul class="nav nav-pills flex-column text-sm">
                    <li class="nav-item"><a href="myPage.yolo" class="nav-link"><i class="fa fa-list"></i> 마이페이지</a></li>
                    <li class="nav-item"><a href="myReservList.yolo" class="nav-link active"><i class="fa fa-heart"></i> 내 예약목록</a></li>
                    <li class="nav-item"><a href="infoModify.yolo" class="nav-link"><i class="fa fa-user"></i> 개인정보확인</a></li>
                    <li class="nav-item"><a href="signOut.yolo" class="nav-link"><i class="fa fa-sign-out"></i> 회원탈퇴</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
</body>
</html>