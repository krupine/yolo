<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
              <h1 class="h2">${roomModel.room_name}</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">${roomModel.room_name}</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div id="content">
        <div class="container">
          <section>
            <div class="project owl-carousel">
              <c:forEach var="fileList" items="${fileList}" varStatus="stat">
              	<div class="item"><img src="/yolo/resources/upload/${fileList.file_sav_imgname}-${i}" alt="" class="img-fluid"></div>
              </c:forEach>
            </div>
          </section>
          <section class="bar">
            <div class="row portfolio-project">
              <div class="col-md-8">
                <div class="heading">
                  <h3>객실 예약 시 제공되는 서비스</h3>
                </div>
                <p>도착 한 시간 전 연락 시 픽업 서비스 제공</p>
                <p>무료 조식 제공</p>
                <p>바비큐 장비 렌탈 예약 시 열탄/숯 무료 제공</p>
              </div>
              <div class="col-md-4 project-more">
                <div class="heading">
                  <h3>"${roomModel.room_name}" 객실 정보</h3>
                </div>
                <h4>예약 금액</h4>
                <p>일반가: <fmt:formatNumber value="${roomModel.room_price}" type="number" pattern="#,###"/>&nbsp;원</p>
                <p>성수기(6~8월): <fmt:formatNumber value="${roomModel.room_price * 1.1}" type="number" pattern="#,###"/>&nbsp;원</p>
                <p>비수기(12~2월): <fmt:formatNumber value="${roomModel.room_price * 0.9}" type="number" pattern="#,###"/>&nbsp;원</p>
                <h4>수용 인원</h4>
                <p>적정 인원: ${roomModel.room_people}&nbsp;명</p>
                <p>최대 인원: ${roomModel.room_max_people}&nbsp;명</p>
              </div>
            </div>
          </section>
        </div>
      </div>

</body>
</html>