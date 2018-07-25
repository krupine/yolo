<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body> 
      <div class="page-content d-flex align-items-stretch"> 
        <!-- Side Navbar -->
        <nav class="side-navbar">
          <!-- Sidebar Header-->
          <div class="sidebar-header d-flex align-items-center">
            <div class="avatar"><img src="img/avatar-1.jpg" alt="..." class="img-fluid rounded-circle"></div>
            <div class="title">
              <h1 class="h4">Mark Stephen</h1>
              <p>Web Designer</p>
            </div>
          </div>
          <!-- Sidebar Navidation Menus--><span class="heading">Main</span>
          <ul class="list-unstyled">
                    <li class="active"><a href="index.html"> <i class="icon-home"></i>Home </a></li>
                    <li><a href="adMemberList.yolo"> <i class="icon-user"></i>회원관리 </a></li>
                    <li><a href="#exampledropdownDropdown" aria-expanded="false" data-toggle="collapse"> <i class="icon-interface-windows"></i>객실관리 </a>
                      <ul id="exampledropdownDropdown" class="collapse list-unstyled ">
                        <li><a href="adRoomList.yolo">객실목록</a></li>
                        <li><a href="adInsertRoom.yolo">객실등록</a></li>
                      </ul>
                    </li>
                    <li><a href="charts.html"> <i class="fa fa-bar-chart"></i>예약관리 </a></li>
                    <li><a href="forms.html"> <i class="icon-padnote"></i>예약취소관리 </a></li>
                    <li><a href="login.html"> <i class="icon-interface-windows"></i>Login page </a></li>
          </ul>
        </nav>
</body>
</html>