<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
   //달력 달 변경
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
   //체크 일 변경
   function dateCheck(a){
      var date = a;
      document.cal.date.value = date;
      document.cal.submit();
   }
   //체크박스 체크 확인
   function Check(a,c,d,e){
      var b=document.getElementById(a);
      var f = eval(e);
      if(b.checked){
         //체크했을때
         if(f){
            Check0(a,c,d);
         }else{
            alert('예약 불가');
         };
      }else{
         //체크 해제 했을 때
         CheckX(a);
      }
   }
   
   //체크 했을 때
   function Check0(a,c,d){
      var a=Number(a);
      var b=document.getElementById(a);
      var price_wek;
      var price_wek1=c.replace(/,/g,"");
      var price_wek2=d.replace(/,/g,"");
      
      if('${d}'==1 ||' ${d}'>5){
         charge = price_wek2;
      } else if('${d}'>1 ||' ${d}'<6){
         charge = price_wek1;
      } 
      
      for(var i=0; i<'${listSize}' ; i++){
      if(i!=a){
         document.getElementById(i).disabled=true;
      }
      document.getElementById('day'+a).disabled=false;
      document.getElementById('adult'+a).disabled=false;
      document.getElementById('kid'+a).disabled=false;
      document.getElementById('baby'+a).disabled=false;
      
      }
   }
   //체크 해제
   function CheckX(a){
      for(var i=0; i<'${listSize}' ; i++){
         document.getElementById(i).disabled=false;
      }
      document.getElementById('day'+a).disabled=true;
      document.getElementById('adult'+a).disabled=true;
      document.getElementById('kid'+a).disabled=true;
      document.getElementById('baby'+a).disabled=true;
      
      
   }

   // 인원 선택시
   function Check2(a,b,c,d){
      var money =0;
      var money2 =0;
      var sum;
      var adult = Number(document.getElementById('adult'+b).value);
      var kid = Number(document.getElementById('kid'+b).value);
      var baby = Number(document.getElementById('baby'+b).value);
      var change = document.getElementById(c).value;
      sum = adult + kid + baby;
      
       if(sum > a){
         alert('최대인원을 초과하였습니다.');
         document.getElementById(c).value = 0;
         adult = Number(document.getElementById('adult'+b).value);
         kid = Number(document.getElementById('kid'+b).value);
         baby = Number(document.getElementById('baby'+b).value);
         sum = adult + kid + baby;
         if(sum>d) {
             money = (sum-d)*10000;
             money2 = (sum-d)*10000;
         } else if(sum<=d) {
             money = 0;
             money2 = 0;
         }
         
         var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
         money += '';                          // 숫자를 문자열로 변환
           while (reg.test(money)) {
        	   money = money.replace(reg, '$1' + ',' + '$2');
           }
         
         document.getElementById('sum'+b).innerHTML = money;
         
      } else if(d<sum && sum <= a){
         money = (sum-d)*10000;
         money2 = (sum-d)*10000;
         
         var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
         money += '';                          // 숫자를 문자열로 변환
           while (reg.test(money)) {
        	   money = money.replace(reg, '$1' + ',' + '$2');
           }
         
         document.getElementById('sum'+b).innerHTML = money; 
         
      } else if(d==sum){
         money = 0;
         money2 = 0;
         
         document.getElementById('sum'+b).innerHTML = money;
      }

       document.getElementById('addcharge').value = money2;

      
   }

   //숙박일수 선택시 기본가격
   function Check3(price,days,index){
      var charge1;
      var charge2;
      var charge3 = price;

      charge1 = charge3*days;
      charge2 = charge3*days;
      
      console.log(charge1);
      console.log(charge2);
      console.log(charge3);


      var reg = /(^[+-]?\d+)(\d{3})/;   // 정규식
      charge2 += '';                          // 숫자를 문자열로 변환
        while (reg.test(charge2))
           charge2 = charge2.replace(reg, '$1' + ',' + '$2');
      
      document.getElementById('charge1'+index).innerHTML = charge2;
      
   }
      window.onload = function(){
         for(var i=0; i<'${listSize}' ; i++){
               document.getElementById(i).disabled = false;
               document.getElementById(i).checked = false;
            }

      }

   // 아무것도 선택하지 않고 다음버튼을 눌렀을 경우
   function Check4(){
      var a;
      
      for(var i=0; i<'${listSize}' ; i++){
         if(!document.getElementById(i).checked){
            a = false;
         }else{
            a = true;
         }
         if(a) break;
      
      }
      if(a){
         return true;
      }else{
         alert("예약정보를 선택해주세요");
         return false;
      }
      
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
      <form name="cal" action="resStep1.yolo">
         <input type="hidden" name="year" value="${year}" />
         <input type="hidden" name="month" value="${month}" />
         <input type="hidden" name="date" value="${date }" />
          <input type="hidden" name="days" value="${day}" />


<div class="container">
<div class="row">
<div class="col-md-3">

<div class="table-responsive">
         <div
            style="align: center;">

            <div>
               <table style="margin: auto; font-size: 9pt">
                  <tr>

					<td colspan="7" align="center">
                        <font
                           style="font-size: 20pt; color: #4ab839; font-weight: 900; font-family: 'UnYetgulWeb'">
                           ${month}. ${date}</font>&nbsp; <font
                           style="font-size: 10pt; color: #4ab839; font-weight: 900; font-family: 'UnYetgulWeb'">
                           ${day}</font><br> <br>
                     </td>
                </tr>
                <tr>
                <td align="right">
<input type="button" onclick="change(this.form, this.name)" name="pre" 
style="background: url('/yolo/resources/img/pre.jpg') no-repeat; border: 0; width: 10px; cursor: pointer; padding-bottom:5px;"/>
</td>
<td colspan="5" align="center">
                        <b>${year}년 ${month}월</b>&nbsp;&nbsp;
                        </td>
                        <td align="left">
                        <input type="button"
                           onclick="change(this.form, this.name)" name="next"
                           style="background: url('/yolo/resources/img/next.jpg') no-repeat; border: 0; width: 10px; cursor: pointer;" />
                 </td>
                  </tr>

                  <tr class="cal"
                     style="border-top: 1px solid #e6e6e6; border-bottom: 1px solid #e6e6e6;">
                     <th>일</th>
                     <th>월</th>
                     <th>화</th>
                     <th>수</th>
                     <th>목</th>
                     <th>금</th>
                     <th>토</th>
                  </tr>

                  <tr class="cal">

                     <!-- 이번달 1일 이전 빈 공간 지난 달로 채움 -->
                     <c:forEach var="i" begin="1" end="${startDay-1}">
                        <td class=a1><font color=gray> ${last-startDay+1+i}</font></td>

                     </c:forEach>

                     <c:forEach var="i" begin="1" end="${endDay}" varStatus="stat">
                        <td class=a1><c:if
                              test="${month>month2 or stat.index>=date2}">
                              <a href="javascript:dateCheck(${i})">
                           </c:if> <c:if test="${(stat.count+startDay-1)%7==0 }">
                              <font color=green>
                           </c:if> <c:if test="${(stat.count+startDay-1)%7==1 }">
                              <font color=red>
                           </c:if> <c:if test="${month==month2 and stat.index<date2}">
                              <font color=gray>
                           </c:if> <b>${i}</b></a>&nbsp;</font></td>

                        <c:if test="${(stat.count+startDay-1)%7==0 }">
                  </tr>
                  <tr class="cal">
                     </c:if>
                     </c:forEach>

                     <!-- 이번달 마지막일 이후 빈공간 다음달로 채움 -->
                     <c:forEach var="i" begin="1" end="${line}">
                        <td class=a1><font color=gray> ${i}&nbsp;</font></td>
                     </c:forEach>
                  </tr>

               </table>
            </div>
</div>
         </div>
         </div>
         <div class="col-md-9">
<div class="table-responsive">
         <div
            style="font-size: 9pt;">
            <div></div>
            <div>
               <table id="ss" >
                  <tbody>
                     <tr>
                        <th>&nbsp;이용일자&nbsp;</th>
                        <td>&nbsp;${year}-<c:if test="${month<10}">0</c:if>${month}-${date}&nbsp;(${day})</td>
                     </tr>

                     <tr>
                        <th>&nbsp;성수기 / 비수기&nbsp;</th>
                        <td>&nbsp;<b><font color="#3293b3">6월~8월 / 12월~2월</font></b></td>
                     </tr>


                     <tr>
                        <th>&nbsp;문의전화&nbsp;</th>
                        <td>&nbsp;010-3027-7882</td>
                     </tr>

                     <tr>
                        <th>&nbsp;안내&nbsp;</th>
                        <td>&nbsp;<b><font color="red">보호자 동반없는 미성년자는 예약하실 수
                                 없으며 입실이 거부됩니다.</font></b></td>
                     </tr>

                     <tr>
                     
                        <th>&nbsp;기타안내&nbsp;</th>
                        <td>&nbsp;<br>유아는 만 24개월 미만 입니다.<br>&nbsp;영유아도 추가인원에
                           포함됩니다.</td>
                     </tr>
                  </tbody>
               </table>
            </div>
            <div></div>
         </div>
         
         <div
            style="align: center; float: left; margin: 0 10px; font-size: 9pt">
            *&nbsp;&nbsp;이용할 날짜를 선택후 객실과 숙박일수, 인원을 선택해주세요</div>
</div></div>
         </div>
         </div>
               
      </form>

</div>
<br/>
<hr>
<br/>
<div class="container">
<div class="row">

<div class="col-md-12">
<div class="table-responsive">
      <form id="form2" action="resStep2.yolo" method="post"
         onsubmit="return Check4();">
         <input type="hidden" name="year" value="${year}" />
      <input type="hidden" name="month" value="${month}" />
      <input type="hidden" name="date" value="${date}" />
         <div>
            <table class="table">
               <tbody
                  style="border-bottom: 1px solid #e2e4e0; border-right: 1px solid #e2e4e0; border-left: 1px solid #e2e4e0;">

                  <tr>

                     <th align="center">객실명</th>
                     <th align="center">상태</th>
                     <th align="center">숙박일수</th>
                     <th align="center">기준인원</th>
                     <th align="center">최대인원</th>
                     <th align="center">인원</th>
                     <th align="center">객실요금</th>
                     <th align="center">추가요금</th>
                  </tr>


                  <c:forEach var="roomList" items="${roomList}" varStatus="stat">

                     <c:forEach var="res" items="${res}">
                        <c:set var="j" value="${roomList.room_no}-${date}"/>
                        <c:if test="${res.key eq j}">
                           <c:set var="aa" value="${res.value}" />
                        </c:if>
                     </c:forEach>

                     <c:if test="${stat.index%2==0}">
                        <tr id=aa3 align="center">
                     </c:if>
                      <else>
                  <tr id=aa4 align="center">
               		</else> 
                     <td style="text-align: left"><input type="checkbox"
                        name="room_no" id="${stat.index}" value="${roomList.room_no}"
                        onchange="Check(this.id,'${roomList.room_price}','${roomList.room_price}','${aa}');">
                        ${roomList.room_name}</td>

                     <td align="center"><c:if
                           test="${month>month2 or date>=date2}">
                           <c:forEach var="res" items="${res}">
                              <c:set var="j" value="${roomList.room_no}-${date}" />
                              <c:if test="${res.key==j}">
                                 <c:if test="${res.value eq true}">예약가능</c:if>
                                 <c:if test="${res.value eq false}">
                                    <font color="red">예약불가능</font>
                                 </c:if>
                              </c:if>
                           </c:forEach>
                        </c:if></td>
                     <td>
                     <c:choose>
                     <c:when test="${month eq 6 or month eq 7 or month eq 8}">
                     <select id="day${stat.index}" name="day"
                        onchange="Check3('${roomList.room_price * 1.1}',this.value,${stat.index})"
                        disabled>
                           <c:forEach begin="1" end="6" var="i">
                              <option value="${i}">${i}박</option>
                           </c:forEach>
                     </select>
					</c:when>
					<c:when test="${month eq 1 or month eq 2 or month eq 12}">
                     <select id="day${stat.index}" name="day"
                        onchange="Check3('${roomList.room_price * 0.9}',this.value,${stat.index})"
                        disabled>
                           <c:forEach begin="1" end="6" var="i">
                              <option value="${i}">${i}박</option>
                           </c:forEach>
                     </select>
					</c:when>
					<c:otherwise>
                     <select id="day${stat.index}" name="day"
                        onchange="Check3('${roomList.room_price}',this.value,${stat.index})"
                        disabled>
                           <c:forEach begin="1" end="6" var="i">
                              <option value="${i}">${i}박</option>
                           </c:forEach>
                     </select>
					</c:otherwise>
					</c:choose>
                     </td>

                     <td>${roomList.room_people}</td>
                     <td>${roomList.room_max_people}</td>
                     <td>성인 : <select id="adult${stat.index}" name="adult"
                       onchange="Check2(${roomList.room_max_people},${stat.index},this.id,${roomList.room_people})"
                        disabled>
                           <c:forEach begin="1" end="${roomList.room_max_people}" var="i">
                              <option value="${i}">${i}명</option>
                           </c:forEach>
                     </select> 소아 : <select id="kid${stat.index}" name="kid"
                        onchange="Check2(${roomList.room_max_people},${stat.index},this.id,${roomList.room_people})"
                        disabled>
                           <c:forEach begin="0" end="${roomList.room_max_people}" var="i">
                              <option value="${i}">${i}명</option>
                           </c:forEach>
                     </select> 유아 : <select id="baby${stat.index}" name="baby"
                        onchange="Check2(${roomList.room_max_people},${stat.index},this.id,${roomList.room_people})"
                        disabled>
                           <c:forEach begin="0" end="${roomList.room_max_people}" var="i">
                              <option value="${i}">${i}명</option>
                           </c:forEach>
                     </select>
                     </td>

                     <td><span id="charge1${stat.index}">  
                              <c:choose>
                              	<c:when test="${month eq 6 or month eq 7 or month eq 8 }">
                              		 <fmt:formatNumber value="${roomList.room_price * 1.1}" type="number" pattern="#,###"/> 
                              	</c:when>
                              	<c:when test="${month eq 1 or month eq 2 month eq 12}">
                              		<fmt:formatNumber value="${roomList.room_price * 0.9}" type="number" pattern="#,###"/> 
                              	</c:when>
                              	<c:otherwise>
                              		<fmt:formatNumber value="${roomList.room_price}" type="number" pattern="#,###"/> 
                              	</c:otherwise>
                              </c:choose>
                     </span>원</td>



                     <td><span id="sum${stat.index}">0</span>원</td>
                     <input type="hidden" name="addcharge" id="addcharge"  value="sum${stat.index}"/>
                     </tr>

                  </c:forEach>
               </tbody>
               <tr>
                  <td colspan="8" style="padding-top: 20px; text-align: center">
                  <br>
                     <input type="submit" value="예약하기">
                  </td>
               </tr>
            </table>
         </div>

         
      </form>
               </div>
         </div>
         </div>
         </div>
         </div>
</body>
</html>