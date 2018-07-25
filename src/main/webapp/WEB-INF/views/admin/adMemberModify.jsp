<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('member_zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('member_addr1').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('member_addr2').focus();
            }
        }).open();
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
          <form name="member" method="post" action="adMemberModify.yolo">
            <div class="container-fluid">
            <div> <p class="text-muted"> * 표시된 항목만 수정 가능합니다. </p></div>
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
                              value="${memberModel.member_phone }"/>
                              <label for="member_phone" class="label-material"><font color="red">* </font> Phone</label>
                            </div>
                           </div>
                           <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_email" type="text" name="member_email" class="input-material"
                              value="${memberModel.member_email }"/>
                              <label for="member_email" class="label-material"><font color="red">* </font> E-Mail      </label>
                            </div>
                            </div>
                          </div>
                           <div class="row">
                          <div class="col-sm-3">
                            <div class="form-group-material">
                              <input id="member_zipcode" type="text" name="member_zipcode" class="input-material"
                              value="${memberModel.member_zipcode }" readonly="readonly"/>
                              <label for="member_zipcode" class="label-material"><font color="red">* </font> Zipcode</label>
                            </div>
                           </div>
                           <div class="col-sm-3">
                            <div class="form-group-material">
                              <button type="button" class="btn btn-default"
												id="findZipcode" onclick="sample6_execDaumPostcode()">
												<font color="white">우편번호찾기 </font></button>
                              <label for="member_zipcode" class="label-material"><font color="white">우편번호찾기 </font></label>
                            </div>
                           </div>
                          </div>
                          <div class="row">
                          <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_addr1" type="text" name="member_addr1" class="input-material"
                              value="${memberModel.member_addr1 }" readonly="readonly"/>
                              <label for="member_addr1" class="label-material"><font color="red">* </font> Base Address</label>
                            </div>
                           </div>
                           <div class="col-sm-6">
                            <div class="form-group-material">
                              <input id="member_addr2" type="text" name="member_addr2" class="input-material"
                              value="${memberModel.member_addr2 }"/>
                              <label for="member_addr2" class="label-material"><font color="red">* </font> Detailed Address      </label>
                            </div>
                            </div>
                          </div>

                        <div align="center">
                            <a href="adMemberList.yolo"><button type="button" class="btn btn-secondary">목록으로</button></a>
							<button type="submit" class="btn btn-primary">수정완료</button>
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