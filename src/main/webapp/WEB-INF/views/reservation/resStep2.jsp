<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script>
function check(a) {
	/* 	if (document.chris.id.value == null) {
			alert('결제방법을 선택해주세요');
			document.loginform.id.focus();
			return false;
		 */
		 for (var i = 0; i < 3; i++) {
			if (i != a)
				document.getElementById(i).checked = false; 
		}
	}

	/* function loginForm() {
		if (document.loginform.id.value == "") {
			alert('아이디를 입력하세요');
			document.loginform.id.focus();
			return false;
		}
	 */
	 function check2() {
		
		  var frm = document.chris;
		 
		 if (frm.id1.value == "") {
			alert('결제방법을 선택해주세요');
			/* document.loginform.id.focus(); */
			return false;
				
				}
		return true;
			}

	 
	 
	
	window.onload = function() {
		document.getElementById('phone1').value = '${member.phone1}';
	}
</script>
<!-- <link
	href='http://api.mobilis.co.kr/webfonts/css/?fontface=NanumGothicBoldWeb'
	rel='stylesheet' type='text/css' /> -->
</head>
<body>
<div id="all">
<div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">실시간 예약</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">실시간 예약</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
      <div align="left">
      </div>
      <br/><br/>
      
<div id="content">
	<form name="chris" action="resStep3.yolo" method="post"  onsubmit="return check2()">

	 	 <input type="hidden" name="member_id" value="${memberModel.member_id}"> 
	 	 <input type="hidden" name="room_no" value="${roomModel.room_no}">
	 	  <input type="hidden" name="people" value="${people}">
	 	  <input type="hidden" name="price" value="${price}">
	 	  <input type="hidden" name="pay_ck" value="Y">
          <input type="hidden" name="day" value="${day}"> 
          <input type="hidden" name="adult" value="${adult}">
          <input type="hidden" name="kid" value="${kid}">
          <input type="hidden" name="baby" value="${baby}">
           <input type="hidden" name="year" value="${year}">
            <input type="hidden" name="month" value="${month}">
             <input type="hidden" name="date" value="${date}">
             
          
			
        <center>
		
		<table id="view3"
			style="margin-bottom: 50px; border: 1px solid #e2e4e0; font-size: 10pt;"
			class="res">

			<tr>
				<th>객실명</th>
				<th>인원</th>
				<th>이용일</th>
				<th>기간</th>
				<th>기본요금</th>
				<th>추가요금</th>
			</tr>

			<tbody align="center">
				<tr style="font-size: 10pt; border-bottom: 1px solid #e2e4e0">
					<td>${roomModel.room_name}</td>
					<td>${people}명(성인${adult}명/소아${kid}명/유아${baby}명)</td>
					<td>${year}-${month}-${date} &nbsp;${days }</td>
					<td>${day}박</td>
					<td>${charge}</td>
					<td>${addcharge}원</td>
				</tr>

				<tr>
					<td align="right" colspan="6" style="height: 35px">객실이용 총금액 <b>${price}</b>원&nbsp;&nbsp;
					</td>
				</tr>

			</tbody>
		</table>
		<ul
			style="margin: 0 auto 10px; padding-left: 20px; font-size: 13pt;">
			<li style="color: blue"><font color="black">예약자 정보</font></li>
		</ul>
		<table
			style="margin-bottom: 50px; border: 1px solid #e2e4e0; font-size: 10pt;"
			class="res">

			<tr style="border-top: 2px solid #9ddf4a" class="ss">
				<th><font color="red">*</font>이름</th>
				<td><input type="text" name="member_name" theme="simple"
						value="${memberModel.member_name}" cssClass="off" onfocus="on(this)"
						onblur="off(this)" readonly="readonly"/></td>
			</tr>

			<tr>
				<th><font color="red">*</font>휴대폰</th>
				<td><input type="text" name="member_phone" value="${memberModel.member_phone}"
						theme="simple" readonly="readonly"/></td>
			</tr>


			<tr>
				<th>남기실말</th>
				<td><textarea name="reserv_memo" cols="40" rows="3"
						theme="simple" cssClass="off" onfocus="on(this)"
						onblur="off(this)" ></textarea></td>
			</tr>

		</table>
		<ul
			style="margin: 0 auto 10px; padding-left: 20px; width: 780px; font-family: UnYetgulWeb; font-size: 13pt;">
			<li style="color: blue"><font color="black">결제방법</font></li>
		</ul>
		<table
			style="margin-bottom: 50px; border: 1px solid #e2e4e0; font-size: 10pt; height: 100px; width: 600px"
			class="res">

			<tr style="border-top: 2px solid #9ddf4a" class="ss">
				<th>결제금액</th>
				<td><b>${price}</b>원</td>
			</tr>

			<tr style="border-bottom: 1px solid #e2e4e0;">
				<th>결제방법</th>
				<td><input name="id1" type="radio" id="0" onclick="check(this.id)" checked>카드결제
					<input name="id1" type="radio" id="1" onclick="check(this.id)">계좌이체
					<input name="id1" type="radio" id="2" onclick="check(this.id)">무통장입금</td>
			</tr>
			<tr>
				<td colspan="2" style="text-align: center;">
				<input type="submit" value="예약하기">
				</td>
			</tr>

		</table>
		</center>
	</form>
	</div>
	</div>
</body>
</html>