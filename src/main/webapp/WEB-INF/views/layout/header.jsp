<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>YOLO</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="all,follow">
    <!-- Bootstrap CSS-->
    <link rel="stylesheet" href="/yolo/resources/vendor/bootstrap/css/bootstrap.min.css">
    <!-- Font Awesome CSS-->
    <link rel="stylesheet" href="/yolo/resources/vendor/font-awesome/css/font-awesome.min.css">
    <!-- Google fonts - Roboto-->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,700">
    <!-- Bootstrap Select-->
    <link rel="stylesheet" href="/yolo/resources/vendor/bootstrap-select/css/bootstrap-select.min.css">
    <!-- owl carousel-->
    <link rel="stylesheet" href="/yolo/resources/vendor/owl.carousel/assets/owl.carousel.css">
    <link rel="stylesheet" href="/yolo/resources/vendor/owl.carousel/assets/owl.theme.default.css">
    <!-- theme stylesheet-->
    <link rel="stylesheet" href="/yolo/resources/css/style.default.css" id="theme-stylesheet">
    <!-- Custom stylesheet - for your changes-->
    <link rel="stylesheet" href="/yolo/resources/css/custom.css">
    <!-- Favicon and apple touch icons-->
    <link rel="shortcut icon" href="/yolo/resources/img/favicon.ico" type="image/x-icon">
    <!-- Tweaks for older IEs--><!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->

 <!-- Javascript files-->
    <script src="/yolo/resources/vendor/jquery/jquery.min.js"></script>
    <script src="/yolo/resources/vendor/popper.js/umd/popper.min.js"> </script>
    <script src="/yolo/resources/vendor/bootstrap/js/bootstrap.min.js"></script>
    <script src="/yolo/resources/vendor/jquery.cookie/jquery.cookie.js"> </script>
    <script src="/yolo/resources/vendor/waypoints/lib/jquery.waypoints.min.js"> </script>
    <script src="/yolo/resources/vendor/jquery.counterup/jquery.counterup.min.js"> </script>
    <script src="/yolo/resources/vendor/owl.carousel/owl.carousel.min.js"></script>
    <script src="/yolo/resources/vendor/owl.carousel2.thumbs/owl.carousel2.thumbs.min.js"></script>
    <script src="/yolo/resources/js/jquery.parallax-1.1.3.js"></script>
    <script src="/yolo/resources/vendor/bootstrap-select/js/bootstrap-select.min.js"></script>
    <script src="/yolo/resources/vendor/jquery.scrollto/jquery.scrollTo.min.js"></script>
    <script src="/yolo/resources/js/front.js"></script>
</head>
<body>
    <div>
      <!-- Top bar-->
      <div class="top-bar top-bar-light">
        <div class="container">
          <div class="row d-flex align-items-center">
            <div class="col-md-6 d-md-block d-none">
              <p>Contact us on 010-3027-7882 or hello@universal.com.</p>
            </div>
            <div class="col-md-6">
              <div class="d-flex justify-content-md-end justify-content-between">
                <ul class="list-inline contact-info d-block d-md-none">
                  <li class="list-inline-item"><a href="#"><i class="fa fa-phone"></i></a></li>
                  <li class="list-inline-item"><a href="#"><i class="fa fa-envelope"></i></a></li>
                </ul>
                <c:if test="${sessionScope.id eq null}">
                <div class="login"><a href="#" data-toggle="modal" data-target="#login-modal" class="login-btn"><i class="fa fa-sign-in"></i><span class="d-none d-md-inline-block">Sign In</span></a><a href="/yolo/member/memberJoin.yolo" class="signup-btn"><i class="fa fa-user"></i><span class="d-none d-md-inline-block">Sign Up</span></a></div>
              	</c:if>
              	<c:if test="${sessionScope.id ne null && sessionScope.rate eq 1}">
              	<div class="myPage">${sessionScope.name} 님 환영합니다. <a href="/yolo/member/myPage.yolo" class="myPage-btn"><i class="fa fa-info-circle"></i><span class="d-none d-md-inline-block">&nbsp;My Page</span></a>
              	&nbsp;&nbsp;&nbsp;<a href="/yolo/member/logout.yolo" class="logout-btn"><i class="fa fa-power-off"></i><span class="d-none d-md-inline-block">&nbsp;Logout</span></a></div>
              	</c:if>
              	<c:if test="${sessionScope.id ne null && sessionScope.rate eq 10}">
              	<div class="myPage">${sessionScope.name} 관리자 님 환영합니다. <a href="/yolo/admin/adminMain.yolo" class="myPage-btn"><i class="fa fa-magic"></i><span class="d-none d-md-inline-block">&nbsp;Admin Page</span></a>
              	<a href="/yolo/member/logout.yolo" class="logout-btn"><i class="fa fa-power-off"></i><span class="d-none d-md-inline-block">&nbsp;Logout</span></a></div>
              	</c:if>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- Top bar End-->
      <!-- Login Modal -->
      <div id="login-modal" tabindex="-1" role="dialog" aria-labelledby="login-modalLabel" aria-hidden="true" class="modal fade">
        <div role="document" class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h4 id="login-modalLabel" class="modal-title">Login</h4>
              <button type="button" data-dismiss="modal" aria-label="Close" class="close"><span aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
              <form action="/yolo/member/login.yolo" method="post">
                <div class="form-group">
                  <input name="member_id" type="text" placeholder="ID" class="form-control">
                </div>
                <div class="form-group">
                  <input name="member_pw" type="password" placeholder="password" class="form-control">
                </div>
                <p class="text-center">
                  <button class="btn btn-template-outlined"><i class="fa fa-sign-in"></i> Log in</button>
                </p>
              </form>
              <p class="text-center text-muted">회원이 아니신가요?</p>
              <p class="text-center text-muted"><a href="/yolo/member/memberJoin.yolo"><strong>회원가입</strong></a>하세요! 가입 후 첫 예약 시 특별한 혜택을 제공해드립니다.</p>
            </div>
          </div>
        </div>
      </div>
      <!-- Login Modal End -->
      <!-- Navbar Start-->
      <header class="nav-holder">
        <div id="navbar" role="navigation" class="navbar navbar-expand-lg nav-light">
          <div class="container"><a href="/yolo/main.yolo" class="navbar-brand home"><img src="/yolo/resources/img/yolo-logo.png" alt="yolo yolo-logo" class="d-none d-md-inline-block"><img src="/yolo/resources/img/yolo-logo-small.png" alt="yolo yolo-logo" class="d-inline-block d-md-none"><span class="sr-only">Universal - go to homepage</span></a>
            <button type="button" data-toggle="collapse" data-target="#navigation" class="navbar-toggler btn-template-outlined"><span class="sr-only">Toggle navigation</span><i class="fa fa-align-justify"></i></button>
            <div id="navigation" class="navbar-collapse collapse">
              <ul class="nav navbar-nav ml-auto">
                <li class="nav-item dropdown active"><a href="/yolo/main.yolo">Home <b class="caret"></b></a>
                </li>
                <!-- ========== Contact dropdown ==================-->
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">About <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">펜션 소개</a></li>
                    <li class="dropdown-item"><a href="contact2.html" class="nav-link">주변 경관</a></li>
                    <li class="dropdown-item"><a href="contact3.html" class="nav-link">오시는 길</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">Rooms <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                  	<c:forEach var="roomList99" items="${roomList99}" varStatus="stat">
                   		<c:url var="viewURL" value="/room/roomView.yolo">
							<c:param name="room_no">${roomList99.room_no}</c:param>
						</c:url>
						<li class="dropdown-item"><a href="${viewURL}" class="nav-link">${roomList99.room_name}</a></li>
					</c:forEach>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">Service <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">서비스</a></li>
                    <li class="dropdown-item"><a href="contact2.html" class="nav-link">부대시설</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">Reservation <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">종합예약안내</a></li>
                    <li class="dropdown-item"><a href="/yolo/reserv/cal.yolo" class="nav-link">예약 현황</a></li>
                    <li class="dropdown-item"><a href="/yolo/reserv/resStep1.yolo" class="nav-link">실시간 예약</a></li>
                  </ul>
                </li>
                <li class="nav-item dropdown"><a href="javascript: void(0)" data-toggle="dropdown" class="dropdown-toggle">Community <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li class="dropdown-item"><a href="contact.html" class="nav-link">공지사항</a></li>
                    <li class="dropdown-item"><a href="contact2.html" class="nav-link">Q&A</a></li>
                    <li class="dropdown-item"><a href="contact3.html" class="nav-link">후기</a></li>
                  </ul>
                </li>
                <!-- ========== Contact dropdown end ==================-->
              </ul>
            </div>
          </div>
        </div>
      </header>
      <!-- Navbar End-->
   </div>
</body>
</html>