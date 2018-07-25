package com.mycom.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.member.MemberModel;
import com.mycom.member.MemberService;
import com.mycom.room.RoomModel;
import com.mycom.room.RoomService;

@Controller
@RequestMapping("/reserv")
public class ReservController {
	
	@Resource
	private ReservService reservService;
	@Resource
	private RoomService roomService;
	@Resource
	private MemberService memberService;

	// 달력
	private Calendar dayy = Calendar.getInstance(); // 시스템의 날짜와 시간 표현
	private Calendar cal = new GregorianCalendar(); // 양력달력 객체 생성
	private int year = cal.get(Calendar.YEAR); // 년
	private int month;
	private int month2 = cal.get(Calendar.MONTH) + 1; // 월
	private int date = cal.get(Calendar.DATE); // 일
	private int date2 = cal.get(Calendar.DATE);
	private String day;
	private int d;
	private int startDay;
	private int endDay;
	private int line = 0;
	private int last;

	// resStep2 변수
	private int price;
	private int people;
	private int adult;
	private int kid;
	private int baby;
	private int sum;
	private int charge;
	private String addcharge;

	Calendar start = Calendar.getInstance();
	Calendar end = Calendar.getInstance();

	private Map<String, String> res = new HashMap<String, String>();
	private List<RoomModel> roomList = new ArrayList<RoomModel>();
	private List<ReservModel> reservList = new ArrayList<ReservModel>();
	private int listSize;

	ModelAndView mav = new ModelAndView();
	
	// 예약1
	@RequestMapping("/resStep1.yolo")
	public ModelAndView resStep1(HttpSession session, HttpServletRequest request) throws Exception {
		if (request.getSession().getAttribute("id") == null) {
			
			mav.setViewName("member/userCheck");
			
		} else {
			if (request.getParameter("year") == null && request.getParameter("month") == null
					&& request.getParameter("date") == null) {
				calendar();
				d = cal.get(Calendar.DAY_OF_WEEK);
				
				roomList = roomService.roomList();
				listSize = roomList.size();

				ResCheck();
				} else {
				year = Integer.parseInt(request.getParameter("year"));
				month = Integer.parseInt(request.getParameter("month"));
				date = Integer.parseInt(request.getParameter("date"));
				
				calendar();
				
				cal.set(year,month-1,date);
				
				//한글로 요일 설정
				d = cal.get(Calendar.DAY_OF_WEEK);
				
				roomList = roomService.roomList();
				listSize = roomList.size();
				
				ResCheck();
			}
			String[] d2 = { "", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" };
			for (int i = 1; i < 8; i++) {
				if (d == i) {
					day = d2[i];
				}
			}
				
			mav.addObject("year", year);
			mav.addObject("month", month);
			mav.addObject("month2", month2);
			mav.addObject("date", date);
			mav.addObject("date2", date2);
			mav.addObject("day", day);
			mav.addObject("d", d);
			mav.addObject("startDay", startDay);
			mav.addObject("endDay", endDay);
			mav.addObject("last", last);
			mav.addObject("line", line);
			mav.addObject("roomList", roomList);
			mav.addObject("listSize", listSize);
			mav.addObject("res", res);

			mav.setViewName("resStep1");
		}
		return mav;
	}

	// 예약2
	@RequestMapping("/resStep2.yolo")
	public ModelAndView resStep2(@ModelAttribute("memberModel") MemberModel memberModel, HttpSession session,
			HttpServletRequest request) throws Exception {
		
		String member_id = session.getAttribute("id").toString();
		memberModel = (MemberModel) memberService.memberInfo(member_id);
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		
		RoomModel roomModel = new RoomModel();
		roomModel = reservService.selectRoom(room_no);
		
		roomList = roomService.roomList();
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		day = request.getParameter("day");
		adult = Integer.parseInt(request.getParameter("adult"));
		kid = Integer.parseInt(request.getParameter("kid"));
		baby = Integer.parseInt(request.getParameter("baby"));
		charge = roomModel.getRoom_price() * Integer.parseInt(day);
		addcharge = request.getParameter("addcharge");
			
		sum=adult+kid+baby;

		people = sum;

		if(month == 6 || month == 7 || month == 8) {
			charge = (int) (charge * 1.1);
		} else if(month == 1 || month == 2 || month == 12) {
			charge = (int) (charge * 0.9);
		}
		
		int m = charge;
		int s = 0;
		
		if(addcharge.equals("sum0")){
			addcharge="";
		}
		
		if (addcharge != "") {
			s = Integer.parseInt(addcharge);
		}
		
		m += s;
		
		price = m;
		
		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("date", date);
		mav.addObject("memberModel", memberModel);
		mav.addObject("roomModel", roomModel);
		mav.addObject("people", people);
		mav.addObject("adult", adult);
		mav.addObject("kid", kid);
		mav.addObject("baby", baby);
		mav.addObject("day", day);
		mav.addObject("charge", charge);
		mav.addObject("addcharge", addcharge);
		mav.addObject("price", price);

		mav.setViewName("resStep2");
		return mav;
	}

	// 예약3
	@RequestMapping("/resStep3.yolo")
	public ModelAndView resStep3(HttpServletRequest request) throws Exception {
		
		ReservModel reservModel = new ReservModel();
		MemberModel memberModel = new MemberModel();
		
		String member_id = request.getParameter("member_id");
		memberModel = (MemberModel) memberService.memberInfo(member_id);
		
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		String adult = request.getParameter("adult");
		String kid = request.getParameter("kid");
		String baby = request.getParameter("baby");
		String people = request.getParameter("people");
		String day = request.getParameter("day");
		String price = request.getParameter("price");
		String reserv_memo = request.getParameter("reserv_memo");
		
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		date = Integer.parseInt(request.getParameter("date"));
		
		RoomModel roomModel = new RoomModel();
		roomModel = reservService.selectRoom(room_no);
		
		int day2 = Integer.parseInt(day);

		cal.set(year, month - 1, date);

		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");

		String checkin = sdf1.format(cal.getTime());
		reservModel.setReserv_checkin(sdf1.parse(checkin));

		cal.add(Calendar.DATE, day2);
		
		String checkout = sdf1.format(cal.getTime());
		reservModel.setReserv_checkout(sdf1.parse(checkout));
		
		reservModel.setReserv_memo(reserv_memo);
		reservModel.setReserv_people(Integer.parseInt(people));
		reservModel.setReserv_price(Integer.parseInt(price));
		reservModel.setRoom_no(room_no);
		reservModel.setMember_id(member_id);

		reservService.insertReserv(reservModel);

		mav.addObject("memberModel", memberModel);
		mav.addObject("roomModel", roomModel);
		mav.addObject("adult", adult);
		mav.addObject("kid", kid);
		mav.addObject("baby", baby);
		mav.addObject("people", people);
		mav.addObject("day", day);
		mav.addObject("price", price);
		mav.addObject("reserv_memo", reserv_memo);

		mav.setViewName("resStep3");
		return mav;
	}
	
	@RequestMapping("/cal.yolo")
	public ModelAndView cal(HttpSession session, HttpServletRequest request) throws Exception {
		
		DateModel dateModel = new DateModel();
		
		if (request.getParameter("year") == null && request.getParameter("month") == null
				&& request.getParameter("date") == null) {
			calendar();

		} else {
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			date = Integer.parseInt(request.getParameter("date"));

			calendar();

			cal.set(dateModel.getYear(), dateModel.getMonth() - 1, dateModel.getDate());
		}

		/* calendar(); */

		// 객실

		roomList = roomService.roomList();
		listSize = roomList.size();

		// 해당 방 예약자 정보

		reservList = reservService.adReservList();
		ResCheck();

		// 한글로 요일 설정
		d = cal.get(Calendar.DAY_OF_WEEK);
		String[] d2 = { "", "일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일" };
		for (int i = 1; i < 8; i++) {
			if (d == i) {
				day = d2[i];
			}
		}
		

		mav.addObject("year", year);
		mav.addObject("month", month);
		mav.addObject("month2", month2);
		mav.addObject("date", date);
		mav.addObject("date2", date2);
		mav.addObject("day", day);
		mav.addObject("d", d);
		mav.addObject("startDay", startDay);
		mav.addObject("endDay", endDay);
		mav.addObject("last", last);
		mav.addObject("line", line);

		mav.addObject("roomList", roomList);
		mav.addObject("listSize", listSize);

		mav.addObject("res", res);

		mav.setViewName("calendar");

		return mav;
	}
	
	public void calendar() throws Exception {
		cal.set(Calendar.YEAR, year); 
		if (month != 0) {
			cal.set(Calendar.MONTH, month - 1);

		} else {
			month = cal.get(Calendar.MONTH) + 1;
			cal.set(Calendar.MONTH, month - 1);
		}
		cal.set(Calendar.DATE, 1); 
		startDay = cal.get(Calendar.DAY_OF_WEEK); 
		endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH); 
			
		cal.set(Calendar.DATE, endDay); 
		line = cal.get(Calendar.WEEK_OF_MONTH) * 7 - endDay - startDay + 1;
			
		cal.set(Calendar.MONTH, month - 2);
		last = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
			cal.setTime(Calendar.getInstance().getTime()); // �ð� ����
	}
		
	public void ResCheck() throws Exception {
		reservList = reservService.adReservList();
		roomList = roomService.roomList();
			
		if (reservList.size() > 0) { 
			
			for (int k = 0; k < roomList.size(); k++) {
				dayy.set(year,month-1,1);
				
				for (int i = 0; i < reservList.size(); i++) {
					
					if (reservList.get(i).getRoom_no() == roomList.get(k).getRoom_no()) { 
						
						for (int j = 1; j <= dayy.getActualMaximum(Calendar.DAY_OF_MONTH); j++) {
							dayy.set(Calendar.DATE, j); 
							if ((dayy.getTime().after(reservList.get(i).getReserv_checkin())
									&& dayy.getTime().before(reservList.get(i).getReserv_checkout()))
									|| dayy.getTime().equals(reservList.get(i).getReserv_checkin())
									|| dayy.getTime().equals(reservList.get(i).getReserv_checkout())) {

								res.put(roomList.get(k).getRoom_no() + "-" + String.valueOf(j), "false");
							} else {
							res.put(roomList.get(k).getRoom_no() + "-" + String.valueOf(j), "true");
							} 
						} 
					} 
					else { 
							
						for (int j = 1; j <= dayy.getActualMaximum(Calendar.DAY_OF_MONTH); j++) {
							dayy.set(Calendar.DATE, j);
							
						if (!res.containsKey(roomList.get(k).getRoom_no() + "-" + String.valueOf(j))) {
							} 
						} 
					} 
				} 
			} 
		} 
			else {
			
			for (int k = 0; k < roomList.size(); k++) {
				
				for (int j = 1; j <= dayy.getActualMaximum(Calendar.DAY_OF_MONTH); j++) {
					dayy.set(Calendar.DATE, j);
					
				if (!res.containsKey(roomList.get(k).getRoom_no() + "-" + String.valueOf(j))) {
						
						res.put(roomList.get(k).getRoom_no() + "-" + String.valueOf(j), "true");
					} 
				} 
			} 
		} 
	}
}
