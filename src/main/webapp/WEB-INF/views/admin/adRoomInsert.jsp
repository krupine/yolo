<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function isDelete(room) {
		var isDelete = confirm("정말 삭제하시겠습니까?");

		if (isDelete == true) {
			member.action = "adDeleteRoom.yolo?room_no=${roomModel.room_no}";
			member.submit();
		} else {
			return false;
		}

	}
</script>
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
              <li class="breadcrumb-item active">객실등록            </li>
            </ul>
          </div>
          <!-- Forms Section-->
          <section class="forms"> 
          <form name="room" method="post" action="adInsertRoom.yolo" enctype="multipart/form-data">
            <div class="container-fluid">
              <div class="row">
                <!-- Form Elements -->
                <div class="col-lg-12">
                   <div class="card">
                     <div class="card-body">
                        <div class="row">
                          <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_name" type="text" name="room_name" class="input-material"
                              value="" />
                              <label for="member_name" class="label-material">객실명</label>
                            </div>
                           </div>
                           <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_people" type="text" name="room_people" class="input-material"
                              value="">
                              <label for="room_people" class="label-material">수용인원(명)      </label>
                            </div>
                            </div>
                            <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_max_people" type="text" name="room_max_people" class="input-material"
                              value="">
                              <label for="room_max_people" class="label-material">최대수용인원(명)     </label>
                            </div>
                            </div>
                            <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_price" type="text" name="room_price" class="input-material"
                              value="">
                              <label for="room_price" class="label-material">금액(원)     </label>
                            </div>
                            </div>
                            </div>
                          <div class="row">
                          <div class="col-sm-12">
                            <div class="form-group-material">
                               <label for="uploadFile" class="col-sm-3 form-control-label">객실사진     </label>
                               <input id="uploadFile" type="file" class="form-control-file" name="uploadFile" multiple="multiple">
                              
                            </div>
                           </div>
                          </div>
                          
                        <div align="center">

                            <a href="adRoomList.yolo"><button type="button" class="btn btn-secondary">목록으로</button></a>
							<button type="submit" class="btn btn-primary">등록하기</button>
                        </div>
                       </div>
                    </div>
                  </div>
                </div>
               </div>
            </form>
          </section>
</body>
</html>