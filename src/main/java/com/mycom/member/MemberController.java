package com.mycom.member;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.cancle.CancleModel;
import com.mycom.reservation.ReservModel;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Resource(name="memberService")
	private MemberService memberService;
	
	ModelAndView mav = new ModelAndView();
	
	private Logger logger = Logger.getLogger(getClass());
	
	//회원가입 폼
	@RequestMapping(value="/memberJoin.yolo", method=RequestMethod.GET)
	public ModelAndView joinForm() {
		
		mav.setViewName("joinForm");
		return mav;
	}
	
	//회원가입처리
	@RequestMapping(value="/memberJoin.yolo", method=RequestMethod.POST)
	public ModelAndView memberJoin(@ModelAttribute("memberModel") MemberModel memberModel) {
		
		memberService.insertMember(memberModel);
		
		mav.setViewName("redirect:/main.yolo");
		
		return mav;
	}
	
	//id 중복 확인
	@RequestMapping(value="idCheck.yolo")
	public ModelAndView idCheck(HttpServletRequest request) {
		
		String id = request.getParameter("member_id");
		String check_id = memberService.idCheck(id);
		
		if(id.equals(check_id)) {
			mav.addObject("checkNum", 1);
		} else {
			mav.addObject("checkNum", 0);
		}
		
		mav.addObject("member_id", id);
		mav.setViewName("member/idCheck");
		
		return mav;
	}
	
	
	//로그인처리
	@RequestMapping(value="/login.yolo")
	public ModelAndView memberLogin(@ModelAttribute("memberModel") MemberModel memberModel, HttpServletRequest request) {
		
		MemberModel user = memberService.login(memberModel);
		
		//회원 정보가 존재하면
		if(user != null) {
			
			//세션에 정보 세팅
			HttpSession session = request.getSession();
			
			session.setAttribute("user", user);
			session.setAttribute("id", user.getMember_id());
			session.setAttribute("name", user.getMember_name());
			session.setAttribute("rate", user.getMember_rate());
			
			mav.setViewName("redirect:/main.yolo");
			
			return mav;
			
		}
		
		//회원정보가 존재하지 않으면
		mav.setViewName("loginError");
		
		return mav;
	}
	
	//로그아웃
	@RequestMapping(value="/logout.yolo")
	public ModelAndView memberLogout(HttpServletRequest request, HttpSession session) {
		
		//세션이 있는 경우 새로 생성하지 않음
		session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		
		mav.setViewName("member/logoutCheck");
		
		return mav;
	}
	
	
	//ID찾기
	@RequestMapping(value="/findIdForm.yolo", method=RequestMethod.GET)
	public ModelAndView findIdForm() {
		mav.setViewName("findIdForm");
		return mav;
	}
	
	@RequestMapping(value="/findId.yolo", method=RequestMethod.POST)
	public ModelAndView findId(@ModelAttribute("memberModel") MemberModel memberModel) {
		
		String member_id = memberService.findId(memberModel);
		int checkNum;
		
		if(member_id != null) {
			checkNum = 1;
		} else {
			checkNum = 0;
		}
		
		mav.addObject("checkNum", checkNum);
		mav.addObject("member_id", member_id);
		
		mav.setViewName("member/findIdCheck");
		
		return mav;
	}
	
	//비밀번호 찾기
	@RequestMapping(value="/findPwForm.yolo", method=RequestMethod.GET)
	public ModelAndView findPwForm() {
		mav.setViewName("findPwForm");
		return mav;
	}
	
	@RequestMapping(value="/findPw.yolo", method=RequestMethod.POST)
	public ModelAndView findPw(@ModelAttribute("memberModel") MemberModel memberModel) {
		
		
		String member_pw = memberService.findId(memberModel);
		int checkNum;
		
		if(member_pw != null) {
			checkNum = 1;
		} else {
			checkNum = 0;
		}
		
		mav.addObject("checkNum", checkNum);
		mav.addObject("member_pw", member_pw);
		
		mav.setViewName("member/findPwCheck");
		
		return mav;
	}
	
	//마이페이지-최신 예약내역을 보여줌
	@RequestMapping("myPage.yolo")
	public ModelAndView myPage(HttpSession session) {
		
		String member_id = (String) session.getAttribute("id");
		
		MemberModel memberModel = memberService.memberInfo(member_id);
		List<ReservModel> reservList = memberService.selectRecentReserv(member_id);
		
		mav.addObject("memberModel", memberModel);
		mav.addObject("reservList", reservList);
		
		mav.setViewName("myPage");
		
		return mav;
	}
	
	//내 예약 목록
	@RequestMapping("myReservList.yolo")
	public ModelAndView myReservList(HttpSession session) {
		
		String member_id = (String) session.getAttribute("id");
		
		List<ReservModel> reservList = memberService.reservList(member_id);
		
		mav.addObject("reservList", reservList);
		mav.setViewName("myReservList");
		
		return mav;
	}
	
	//예약내역 상세보기
	@RequestMapping("myReservView.yolo")
	public ModelAndView myReservView(HttpServletRequest request) {
		
		ReservModel reservModel = new ReservModel();
		
		int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
		
		reservModel = memberService.reservView(reserv_no);
		
		mav.addObject("reservModel", reservModel);
		mav.setViewName("myReservView");
		
		return mav;
	}
	
	//예약 취소하기 폼
	@RequestMapping(value="reservCancle.yolo", method=RequestMethod.GET)
	public ModelAndView reservCancleForm(HttpServletRequest request) {
		
		ReservModel reservModel = new ReservModel();
		
		int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
		
		reservModel = memberService.reservView(reserv_no);
		
		mav.addObject("reservModel", reservModel);
		
		mav.setViewName("reservCancle");
		
		return mav;
	}
	
	//예약 취소
	@RequestMapping(value="reservCancle.yolo", method=RequestMethod.POST)
	public ModelAndView reservCancle(HttpServletRequest request, HttpSession session, @ModelAttribute("cancleModel") CancleModel cancleModel) {
		
		String member_id = (String) session.getAttribute("id");
		String cancle_reason = cancleModel.getCancle_reason().replaceAll("\r\n", "<br />");
		
		cancleModel.setMember_id(member_id);
		cancleModel.setCancle_reason(cancle_reason);
		
		mav.setViewName("member/cancleEnd");
		
		return mav;
		
	}
	
	//개인정보 확인 및 수정 폼
	@RequestMapping(value="/infoModify.yolo", method=RequestMethod.GET)
	public ModelAndView infoModifyForm(@ModelAttribute("memberModel") MemberModel memberModel, HttpSession session) {
		
		String member_id = (String) session.getAttribute("id");

		if (member_id != null) {
			memberModel = memberService.memberInfo(member_id);

			mav.addObject("memberModel", memberModel);
			mav.setViewName("infoModify");
			
			return mav;
		} else {
			mav.setViewName("login");
			return mav;
		}
	}
	
	//개인정보 수정
	@RequestMapping(value="/infoModify.yolo", method=RequestMethod.POST)
	public ModelAndView infoModify(@ModelAttribute("memberModel") MemberModel memberModel, HttpSession session) {
		
		String member_id = (String) session.getAttribute("id");
		
		memberModel.setMember_id(member_id);
		memberService.memberModify(memberModel);
		
		mav.setViewName("member/infoModifyEnd");
		
		return mav;
	}
	
	//비밀번호 수정
	@RequestMapping(value="/pwModify.yolo")
	public ModelAndView pwModify(HttpSession session, HttpServletRequest request) {
		
		MemberModel memberModel = new MemberModel();
		MemberModel memberModel2 = new MemberModel();
		
		String password_old = request.getParameter("password_old");
		String member_id = (String) session.getAttribute("id");
		
		memberModel2 = memberService.memberInfo(member_id);
		
		String member_pw = memberModel2.getMember_pw();
		String password_1 = request.getParameter("password_1");
		
		logger.info("기존 비밀번호 : " + member_pw);
		logger.info("비밀번호 확인 : " + password_old);
		logger.info("바꾸려는 비밀번호 : " + password_1);
		
		if(password_old.equals(member_pw)) {
			
			if(member_pw.equals(password_1)) {
				
				int status = 1;
				
				mav.addObject("status", status);
				mav.setViewName("member/modifyCheck");
				
			} else if(member_pw != password_1) {
				
				memberModel.setMember_id(member_id);
				memberModel.setMember_pw(request.getParameter("password_1"));
				memberService.pwModify(memberModel);
				
				mav.setViewName("member/infoModifyEnd");
				
			}
		
		} else if(password_old != member_pw) {
			
			int status = 0;
			
			mav.addObject("status", status);
			mav.setViewName("member/modifyCheck");
			
		} 

		return mav;
		
	}
	
	//회원탈퇴 폼
	@RequestMapping(value="signOut.yolo", method=RequestMethod.GET)
	public ModelAndView signOutForm() {
		
		mav.setViewName("signOutForm");
		return mav;
	}
	
	//회원탈퇴처리
	@RequestMapping(value="signOut.yolo", method=RequestMethod.POST)
	public ModelAndView signOut(@ModelAttribute("memberModel") MemberModel memberModel, HttpSession session, HttpServletRequest request) {
		
		String member_id = session.getAttribute("id").toString();
		String member_pw = request.getParameter("member_pw");
		
		int deleteCheck;
		
		memberModel = (MemberModel) memberService.memberInfo(member_id);
		
		if(memberModel.getMember_pw().equals(member_pw)) {
			//비밀번호가 맞다면 1 반환
			deleteCheck = 1;
			//회원 탈퇴처리
			memberService.deleteMember(member_id);
		} else {
			deleteCheck = -1;
		}
		
		mav.addObject("deleteCheck", deleteCheck);
		mav.setViewName("member/signOutResult");
		
		return mav;
		
	}

}
