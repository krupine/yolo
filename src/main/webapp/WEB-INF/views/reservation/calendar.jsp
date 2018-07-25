<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function change(a, b) {
    var month = Number(a.month.value);
    var year = Number(a.year.value);
    
    if (b == 'pre') {
       month = month - 1;
       if (month == 0) {
          year = year - 1;
          month = 12;
       }
       a.month.value = month;
       a.year.value = year;
    }

    if (b == 'next') {
       month = month + 1;
       if (month == 13) {
          year = year + 1;
          month = 1;
       }
       a.month.value = month;
       a.year.value = year;
    }

    a.submit();

 }

</script>
</head>
<body>

<div id="all">

	<div id="heading-breadcrumbs">
        <div class="container">
          <div class="row d-flex align-items-center flex-wrap">
            <div class="col-md-7">
              <h1 class="h2">예약 현황</h1>
            </div>
            <div class="col-md-5">
              <ul class="breadcrumb d-flex justify-content-end">
                <li class="breadcrumb-item"><a href="/yolo/main.yolo">Home</a></li>
                <li class="breadcrumb-item active">예약 현황</li>
              </ul>
            </div>
          </div>
        </div>
      </div>
<br/>
<br/>
<div id="content">
<div class="container">
<div class="col-md-12" align="right">
	<span style="background-color:red;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 예약불가능
	<span style="background-color:black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span> 예약가능	

</div>
<div class="col-md-12">
<div class="table-responsive">

<form name="cal" action="cal.yolo" method="post">
<input type="hidden" name="year" value="${year}"/>
<input type="hidden" name="month" value="${month}"/>
<input type="hidden" name="rno" value="${rno}"/>
<input type="hidden" name="date" value="${date }" />


<table class="table">
		<tr>

			<td colspan=3 align="right">
			
<input type="image"  src="/yolo/resources/img/leftpt.jpg" onclick="change(this.form, this.name)"  name="pre"  />

             </td>              
                    

			<td align="center"><b> ${year}년 ${month}월</b></td>
			<td colspan=3 align="left"><input type="image" src="/yolo/resources/img/rightpt.jpg" onclick="change(this.form, this.name)" name="next"/>
			</td>
			</tr>

		<tr align="center" class="e">
			<th class="d">일</th>
			<th class="d">월</th>
			<th class="d">화</th>
			<th class="d">수</th>
			<th class="d">목</th>
			<th class="d">금</th>
			<th class="d">토</th>
		</tr>

		<tr valign="top" class="a"> 

			<!-- 이번달 1일 이전 빈 공간 지난 달로 채움 (시작)-->
			  <c:forEach var="i" begin="1" end="${startDay-1}">
				<td class="a">
					<font color=gray>			
					${last-startDay+1+i}&nbsp;</font></td>
			
			</c:forEach> 
			<!-- 이번달 1일 이전 빈 공간 지난 달로 채움 (끝)-->
			
			<!-- 이번달 (시작)-->
			<c:forEach var="i" begin="1" end="${endDay}" varStatus="stat">
				<td class="a">
					<c:if test="${(stat.count+startDay-1)%7==0 }">	<font color=blue>	</c:if>
					<c:if test="${(stat.count+startDay-1)%7==1 }">	<font color=red>	</c:if>
					
					<b>${i}</b>&nbsp;</font>
					
					<!-- 예약 불가능 날짜는 붉은색 (시작)-->
					<div style="font-size:10pt;margin-bottom:10px;width:100px"align="center">
					<c:if test="${month>month2 or stat.index>=date2}">
					<c:forEach var="roomList" items="${roomList}">
						<br/>
						<c:forEach var="res" items="${res}">
							
							<c:set var="j" value="${roomList.room_no}-${i}"/>
							<c:if test="${res.key eq j}">
								<c:if test="${res.value eq 'true'}"><a href="resStep1.yolo"><b>${roomList.room_name}</b>&nbsp;</a></c:if>
								<c:if test="${res.value eq 'false'}"><font color=red><b>${roomList.room_name}</b>&nbsp;</font></c:if>
							</c:if>
							
						</c:forEach>
					</c:forEach>
					</c:if>
					</div>
					<!-- 예약 불가능 날짜는 붉은색 (끝)-->
					</td>

			<c:if test="${(stat.count+startDay-1)%7==0 }">
				<tr valign="top" class="a"></tr></c:if>
			</c:forEach>
			<!-- 이번달 (끝)-->
			
			<!-- 이번달 마지막일 이후 빈공간 다음달로 채움 (시작)-->
			<c:forEach var="i" begin="1" end="${line}">
				<td class="a">
					<font color=gray>
					${i}&nbsp;</font></td>
			</c:forEach>
			<!-- 이번달 마지막일 이후 빈공간 다음달로 채움 (끝)-->
		</tr>
</table>
</form>
</div>
</div>
</div>
</div>
</div>
</body>
</html>