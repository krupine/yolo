<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
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
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

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
			
        <center>
		
		<table id="view3"
			style="margin-bottom: 50px; border: 1px solid #e2e4e0; font-size: 10pt; height: 200px; width: 600px"
			class="res">

			<tr>
				<th>객실명</th>
				<th>인원</th>
				<th>이용일</th>
				<th>기간</th>
			</tr>

			<tbody align="center">
				<tr style="font-size: 10pt; border-bottom: 1px solid #e2e4e0">
					<td style="height: 25px">${rname}</td>
					<td>${people}명(성인${adult}명/소아${kid}명/유아${baby}명)</td>
					<td>${year}-${month}-${date}</td>
					<td>${day}박</td>
				</tr>

				<tr>
					<td align="right" colspan="6" style="height: 35px">객실이용 총금액 <b>${price}</b>원&nbsp;&nbsp;
					</td>
				</tr>

			</tbody>
		</table>
		<ul
			style="margin: 0 auto 10px; padding-left: 20px; width: 780px; font-family: UnYetgulWeb; font-size: 13pt;">
			<li style="color: blue"><font color="black">예약자 정보</font></li>
		</ul>
		<table
			style="margin-bottom: 50px; border: 1px solid #e2e4e0; font-size: 10pt; height: 200px; width: 600px"
			class="res">

			<tr style="border-top: 2px solid #9ddf4a" class="ss">
				<th>이름</th>
				<td>${memberModel.member_name}</td>
			</tr>

			<tr>
				<th>휴대폰</th>
				<td>${memberModel.member_phone}</td>
			</tr>


			<tr>
				<th>남기실말</th>
				<td>${content }</td>
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

		</table>
		</center>
	</form>
</body>
</html>