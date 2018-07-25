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
<script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script language="javascript">
function sample4_execDaumPostcode() {
	new daum.Postcode(
			{
				oncomplete : function(data) {
					// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

					// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
					var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
					var extraRoadAddr = ''; // 도로명 조합형 주소 변수

					// 법정동명이 있을 경우 추가한다. (법정리는 제외)
					// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
					if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
						extraRoadAddr += data.bname;
					}
					// 건물명이 있고, 공동주택일 경우 추가한다.
					if (data.buildingName !== '' && data.apartment === 'Y') {
						extraRoadAddr += (extraRoadAddr !== '' ? ', '
								+ data.buildingName : data.buildingName);
					}
					// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
					if (extraRoadAddr !== '') {
						extraRoadAddr = ' (' + extraRoadAddr + ')';
					}
					// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
					if (fullRoadAddr !== '') {
						fullRoadAddr += extraRoadAddr;
					}

					// 우편번호와 주소 정보를 해당 필드에 넣는다.
					document.getElementById('member_zipcode').value = data.zonecode; //5자리 새우편번호 사용
					document.getElementById('member_addr1').value = fullRoadAddr;
					document.getElementById('member_addr2').focus();
				}
			}).open();
	}

	function check()
	{
		
		if(!document.modify.password_old.value)
		{
			alert("현재 사용중인 비밀번호를 입력하세요.");
			document.modify.password_old.focus();
			return false;
		}
		
		
		if(!document.modify.password_1.value)
		{
			alert("비밀번호 확인을 입력하세요.");
			document.join.password_1.focus();
			return false;
		}
		
		if(document.modify.password_1.value != document.modify.password_2.value)
		{
			alert("비밀번호를 다르게 입력했습니다.");
			document.modify.password_2.focus();
			return false;
		}
	}
</script>
</head>
<body>
<div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">개인정보 확인</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">개인정보 확인</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div id="content">
        <div class="container">
          <div class="row bar">
            <div id="customer-account" class="col-lg-9 clearfix">
              <p class="lead">개인정보 확인</p>
              <p class="text-muted">개인정보를 확인하거나 수정하실 수 있습니다.</p>
              <div class="box mt-5">
                <div class="heading">
                  <h3 class="text-uppercase">비밀번호 변경</h3>
                </div>
                <form name="modify" method="post" action="pwModify.yolo" onsubmit="return check()">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_old">비밀번호 확인</label>
                        <input id="password_old" name="password_old" type="password" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_1">새 비밀번호</label>
                        <input id="password_1" name="password_1" type="password" class="form-control">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="password_2">새 비밀번호 확인</label>
                        <input id="password_2" name="password_2" type="password" class="form-control">
                      </div>
                    </div>
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn btn-template-outlined"><i class="fa fa-save"></i> Save new password</button>
                  </div>
                </form>
              </div>
              <div class="bo3">
                <div class="heading">
                  <h3 class="text-uppercase">개인정보 상세</h3>
                </div>
                <form name="infoModify" method="post" action="infoModify.yolo">
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_name">이름</label>
                        <input id="member_name" name="member_name" type="text" class="form-control" value="${memberModel.member_name}">
                        <input type="hidden" name="member_rate" value="${memberModel.member_rate}"/>
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_jumin1">생년월일</label>
                        <input id="member_jumin1" name="member_jumin1" type="date" class="form-control" value="${memberModel.member_jumin1}"/>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_phone">전화번호</label>
                        <input id="member_phone" name="member_phone" type="text" class="form-control" value="${memberModel.member_phone}">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_email">이메일</label>
                        <input id="member_email" name="member_email" type="text" class="form-control" value="${memberModel.member_email}">
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-md-6 col-lg-3">
                      <div class="form-group">
                        <label for="member_zipcode">우편번호</label>
                        <input id="member_zipcode" name="member_zipcode" type="text" class="form-control" value="${memberModel.member_zipcode}"readonly="readonly">
                      </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                      <div class="form-group">
                        <label for="zip"><font color="white">ZIP</font></label><br/>
                        <button type="button" id="findZip" class="btn btn-primary"
						onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
                      </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                    </div>
                    <div class="col-md-6 col-lg-3">
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_addr1">기본주소</label>
                        <input id="member_addr1" name="member_addr1" type="text" class="form-control" value="${memberModel.member_addr1}" readonly="readonly">
                      </div>
                    </div>
                    <div class="col-md-6">
                      <div class="form-group">
                        <label for="member_addr2">상세주소</label>
                        <input id="member_addr2" name="member_addr2" type="text" class="form-control" value="${memberModel.member_addr2 }">
                      </div>
                    </div>
                    <div class="col-md-12 text-center">
                      <button type="submit" class="btn btn-template-outlined"><i class="fa fa-save"></i> Save changes</button>
                    </div>
                  </div>
                </form>
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
                    <li class="nav-item"><a href="infoModify.yolo" class="nav-link active"><i class="fa fa-user"></i> 개인정보확인</a></li>
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