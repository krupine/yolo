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
<script type="text/javascript">
	function memberDeleteChk(){
		if(document.memberDeleteform.passwd.value == ""){
			alert("비밀번호를 입력하세요.");
			document.memberDeleteform.passwd.focus();
			return false;
		}
		return true;;
	}
</script>
</head>
<body>
      <div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">회원탈퇴</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">회원탈퇴</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div id="content">
        <div class="container">
          <div class="row bar mb-0">
            <div id="customer-orders" class="col-md-9">
              <p class="text-muted lead">
              	회원탈퇴 시 개인정보가 모두 삭제됩니다.</p>
              <div class="box mt-0 mb-lg-0">
                <div class="table-responsive">
				<center>
						<div class="row">
							<form name="memberDeleteform" method="post" action="signOut.yolo" onSubmit="return checkIt()">
								<label>비밀번호</label>
								<input type="password" name="member_pw" size="15">
								&nbsp; <br /> <br />
								<button type="submit" class="btn btn-primary">회원탈퇴</button>
								&nbsp;&nbsp;&nbsp;
								<button type="button" class="btn btn-primary"
									onclick="javascript:location.href='myPage.yolo'">돌아가기</button>
								<br />
							</form>
						</div>
				</center>
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
                    <li class="nav-item"><a href="myReservList.yolo" class="nav-link"><i class="fa fa-heart"></i> 내 예약목록</a></li>
                    <li class="nav-item"><a href="infoModify.yolo" class="nav-link"><i class="fa fa-user"></i> 개인정보확인</a></li>
                    <li class="nav-item"><a href="signOut.yolo" class="nav-link active"><i class="fa fa-sign-out"></i> 회원탈퇴</a></li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
</body>
</html>