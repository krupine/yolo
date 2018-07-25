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
              <li class="breadcrumb-item active">객실목록            </li>
            </ul>
          </div>
          <!-- Forms Section-->
          <section class="forms"> 
          <form name="room" method="post" onsubmit="return isDelete(room)">
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
                              value="${roomModel.room_name }" readonly="readonly"/>
                              <label for="member_name" class="label-material">객실명</label>
                            </div>
                           </div>
                           <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_people" type="text" name="room_people" class="input-material"
                              value="${roomModel.room_people }" readonly="readonly">
                              <label for="room_people" class="label-material">수용인원(명)      </label>
                            </div>
                            </div>
                            <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_max_people" type="text" name="room_max_people" class="input-material"
                              value="${roomModel.room_max_people}">
                              <label for="room_max_people" class="label-material">최대수용인원(명)     </label>
                            </div>
                            </div>
                            <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="room_price" type="text" name="room_price" class="input-material"
                              value="<fmt:formatNumber value='${roomModel.room_price}' type='number' pattern='#,###'/>"/>
                              <label for="room_price" class="label-material">가격(원)     </label>
                            </div>
                            </div>
                          </div>
                          <div class="row">
                          <div class="col-sm-12">
                            <div class="form-group-material">
                               <table class="table">
                          <thead>
                            <tr>
                              <th>파일 원본명</th>
                              <th>파일 저장명</th>
                              <th>사이즈</th>
                            </tr>
                          </thead>
                          <tbody>
                          <c:forEach var="fileList" items="${fileList}" varStatus="stat">
                          	<tr>
								<td> ${fileList.file_org_imgname} </td>
								<td> ${fileList.file_sav_imgname} </td>
								<td> ${fileList.file_size} </td>
                          	</tr>
                          </c:forEach>
                          </tbody>
                        </table>
                            </div>
                           </div>
                          </div>
                          
                        <div align="center">

                            <a href="adRoomList.yolo"><button type="button" class="btn btn-secondary">목록으로</button></a>
                            <a href="adRoomModify.yolo?room_no=${roomModel.room_no }"><button type="button" class="btn btn-primary">수정하기</button></a>
							<button type="submit" class="btn btn-danger">삭제하기</button>
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