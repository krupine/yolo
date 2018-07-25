<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
 <div class="content-inner">
          <!-- Page Header-->
          <header class="page-header">
            <div class="container-fluid">
              <h2 class="no-margin-bottom">객실관리</h2>
            </div>
          </header>
          <!-- Breadcrumb-->
          <div class="breadcrumb-holder container-fluid">
            <ul class="breadcrumb">
              <li class="breadcrumb-item"><a href="main.yolo">Home</a></li>
              <li class="breadcrumb-item active">객실목록            </li>
            </ul>
          </div>
          <section class="tables">   
            <div class="container-fluid">
              <div class="row">
                <div class="col-lg-12">
                  <div class="card">
                    <div class="card-body">
                      <div class="table-responsive">
                        <table class="table">
                          <thead>
                            <tr>
                              <th>객실명</th>
                              <th>금액</th>
                              <th>수용인원</th>
                              <th>최대수용인원</th>
                            </tr>
                          </thead>
                          <tbody>
                          <c:forEach var="roomList" items="${roomList}" varStatus="stat">
                          	<tr>
                          		<td>
                          			<a href="adRoomView.yolo?room_no=${roomList.room_no}">
									${roomList.room_name}
									</a>
								</td>
								<td> <fmt:formatNumber value="${roomList.room_price}" type="number" pattern="#,###"/>&nbsp;원 </td>
								<td> ${roomList.room_people}&nbsp;명 </td>
								<td> ${roomList.room_max_people}&nbsp;명 </td>
                          	</tr>
                          </c:forEach>
                          </tbody>
                        </table>
                        <div align="center">
                        	${pagingHtml }
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
</body>
</html>