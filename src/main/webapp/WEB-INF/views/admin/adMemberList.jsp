<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
              <h2 class="no-margin-bottom">회원관리</h2>
            </div>
          </header>
          <!-- Breadcrumb-->
          <div class="breadcrumb-holder container-fluid">
            <ul class="breadcrumb">
              <li class="breadcrumb-item"><a href="main.yolo">Home</a></li>
              <li class="breadcrumb-item active">회원관리            </li>
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
                              <th>아이디</th>
                              <th>이름</th>
                              <th>생년월일</th>
                              <th>이메일</th>
                              <th>전화번호</th>
                            </tr>
                          </thead>
                          <tbody>
                          <c:forEach var="memberList" items="${memberList}" varStatus="stat">
                          	<tr>
                          		<td>
                          			<a href="adMemberView.yolo?member_id=${memberList.member_id}">
									${memberList.member_id}
									</a>
								</td>
								<td> ${memberList.member_name} </td>
								<td> ${memberList.member_jumin1} </td>
								<td> ${memberList.member_email} </td>
								<td> ${memberList.member_phone} </td>
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