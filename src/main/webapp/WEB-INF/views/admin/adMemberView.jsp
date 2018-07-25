<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
function isDelete(member) {
		var isDelete = confirm("정말 삭제하시겠습니까?");

		if (isDelete == true) {
			member.action = "adMemberDelete.yolo?member_id=${memberModel.member_id}";
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
          <!-- Forms Section-->
          <section class="forms"> 
          <form name="member" method="post" onsubmit="return isDelete(member)">
            <div class="container-fluid">
              <div class="row">
                <!-- Form Elements -->
                <div class="col-lg-12">
                   <div class="card">
                     <div class="card-body">
                        <div class="row">
                          <div class="col-sm-4">
                            <div class="form-group-material">
                              <input id="member_name" type="text" name="member_name" class="input-material"
                              value="${memberModel.member_name }" readonly="readonly"/>
                              <label for="member_name" class="label-material">Username</label>
                            </div>
                           </div>
                           <div class="col-sm-4">
                            <div class="form-group-material">
                              <input id="member_id" type="text" name="member_id" class="input-material"
                              value="${memberModel.member_id }" readonly="readonly">
                              <label for="member_id" class="label-material">ID      </label>
                            </div>
                            </div>
                            <div class="col-sm-4">
                            <div class="form-group-material">
                              <input id="member_pw" type="text" name="member_pw" class="input-material"
                              value="${memberModel.member_pw }">
                              <label for="member_pw" class="label-material">Password     </label>
                            </div>
                            </div>
                          </div>
                          <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_phone" type="text" name="member_phone" class="input-material"
                              value="${memberModel.member_phone }" readonly="readonly"/>
                              <label for="member_phone" class="label-material">Phone</label>
                            </div>
                           </div>
                           <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_email" type="text" name="member_email" class="input-material"
                              value="${memberModel.member_email }" readonly="readonly">
                              <label for="member_email" class="label-material">E-Mail      </label>
                            </div>
                            </div>
                          </div>
                           <div class="row">
                          <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="member_zipcode" type="text" name="member_zipcode" class="input-material"
                              value="${memberModel.member_zipcode }" readonly="readonly"/>
                              <label for="member_zipcode" class="label-material">Zipcode</label>
                            </div>
                           </div>
                          </div>
                          <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_addr1" type="text" name="member_addr1" class="input-material"
                              value="${memberModel.member_addr1 }" readonly="readonly"/>
                              <label for="member_addr1" class="label-material">Base Address</label>
                            </div>
                           </div>
                           <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_addr2" type="text" name="member_addr2" class="input-material"
                              value="${memberModel.member_addr2 }" readonly="readonly">
                              <label for="member_addr2" class="label-material">Detailed Address      </label>
                            </div>
                            </div>
                          </div>

                        <div align="center">

                            <a href="adMemberList.yolo"><button type="button" class="btn btn-secondary">목록으로</button></a>
                            <a href="adMemberModify.yolo?member_id=${memberModel.member_id }"><button type="button" class="btn btn-primary">수정하기</button></a>
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