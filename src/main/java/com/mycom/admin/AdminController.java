package com.mycom.admin;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FilenameUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.cancle.CancleModel;
import com.mycom.member.MemberModel;
import com.mycom.reservation.ReservModel;
import com.mycom.room.RoomModel;
import com.mycom.util.Paging;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	ModelAndView mav = new ModelAndView();
	
	private Logger logger = Logger.getLogger(getClass());
	
	//페이징을 위한 변수 설정
	private int searchNum;
	private String keyword;

	private int currentPage = 1;
	private int totalCount;
	private int blockCount = 10;
	private int blockPage = 5;
	private String pagingHtml;
	private Paging page;
	
	@RequestMapping(value="/main.yolo")
	public ModelAndView adMain() {
		
		mav.setViewName("admin");
		
		return mav;
	}
	
	
	/****************************회원 관리****************************/
	
	//회원 리스트
	@RequestMapping(value="/adMemberList.yolo")
	public ModelAndView memberList(HttpServletRequest request) throws UnsupportedEncodingException {
		
		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		List<MemberModel> memberList = new ArrayList<MemberModel>();
		
		keyword = request.getParameter("keyword");
		if (keyword != null)
			keyword = new String(keyword.getBytes("8859_1"), "UTF-8");

		if (keyword != null) {
			searchNum = Integer.parseInt(request.getParameter("searchNum"));

			if (searchNum == 0) {
				memberList = adminService.searchMemberN(keyword);
			} else if (searchNum == 1) {
				memberList = adminService.searchMemberI(keyword);
			} else if (searchNum == 2) {
				memberList = adminService.searchMemberP(keyword);
			} else if (searchNum == 3) {
				memberList = adminService.searchMemberE(keyword);
			}
			totalCount = memberList.size();
			page = new Paging(currentPage, totalCount, blockCount, blockPage, searchNum, keyword, "memberList");
			pagingHtml = page.getPagingHtml().toString();

			int lastCount = totalCount;

			if (page.getEndCount() < totalCount)
				lastCount = page.getEndCount() + 1;

			memberList = memberList.subList(page.getStartCount(), lastCount);

			mav.addObject("keyword", keyword);
			mav.addObject("searchNum", searchNum);
			mav.addObject("totalCount", totalCount);
			mav.addObject("pagingHtml", pagingHtml);
			mav.addObject("currentPage", currentPage);
			mav.addObject("memberList", memberList);
			mav.setViewName("adMemberList");
			
			return mav;
		
		} 
		
		memberList = adminService.memberlist();
		
		totalCount = memberList.size();

		page = new Paging(currentPage, totalCount, blockCount, blockPage, searchNum, "", "memberList");
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		memberList = memberList.subList(page.getStartCount(), lastCount);

		mav.addObject("totalCount", totalCount);
		mav.addObject("pagingHtml", pagingHtml);
		mav.addObject("currentPage", currentPage);
		mav.addObject("memberList", memberList);
		mav.setViewName("adMemberList");
		
		return mav;
	}
	
	//회원 정보 상세보기
	@RequestMapping(value="/adMemberView.yolo")
	public ModelAndView selectMember(HttpServletRequest request) {
		
		String member_id = request.getParameter("member_id");
		MemberModel memberModel = new MemberModel();
		
		memberModel = adminService.memberInfo(member_id);
		
		mav.addObject("memberModel", memberModel);
		mav.setViewName("adMemberView");
		
		return mav;
	}
	
	//회원 정보 수정 뷰
	@RequestMapping(value="/adMemberModify.yolo", method=RequestMethod.GET)
	public ModelAndView memberModifyForm(HttpServletRequest request) {
		
		String member_id = request.getParameter("member_id");
		MemberModel memberModel = new MemberModel();
		
		memberModel = adminService.memberInfo(member_id);
		
		mav.addObject("memberModel", memberModel);
		mav.setViewName("adMemberModify");
		
		return mav;
	}
	
	//회원 정보 수정
	@RequestMapping(value="/adMemberModify.yolo", method=RequestMethod.POST)
	public ModelAndView memberModify(@ModelAttribute("memberModel") MemberModel memberModel, HttpServletRequest request) {
		
		String member_id = request.getParameter("member_id");
		
		memberModel.setMember_id(member_id);
		adminService.memberModify(memberModel);
		
		mav.setViewName("redirect:memberList.yolo");
		
		return mav;
	}
	
	//회원 정보 삭제
	@RequestMapping(value="/adMemberDelete.yolo")
	public ModelAndView deleteMember(MemberModel memberModel, HttpServletRequest request) {
		
		String member_id = request.getParameter("member_id");
		
		memberModel.setMember_id(member_id);
		adminService.deleteMember(memberModel);
		
		mav.setViewName("redirect:memberList.yolo");
		
		return mav;
		
	}
	
	
	/****************************객실 관리****************************/
	
	//객실등록 폼
	@RequestMapping(value="/adInsertRoom.yolo", method=RequestMethod.GET)
	public ModelAndView insertRoomForm(){
		
		mav.setViewName("insertRoom");
		return mav;
	}
	
	//객실 등록
	@RequestMapping(value="/adInsertRoom.yolo", method=RequestMethod.POST)
	public ModelAndView insertRoom(@ModelAttribute("roomModel") RoomModel roomModel, HttpServletRequest request, MultipartHttpServletRequest mhsq) throws IllegalStateException, IOException {
		
		adminService.insertRoom(roomModel);
		
		List<RoomModel> roomList = new ArrayList<RoomModel>();
		
		roomList = adminService.selectRecentRoom();
		
		String room_no = Integer.toString(roomList.get(0).getRoom_no());
		
		String realFolder = "C:\\Users\\krupi\\App\\yolo\\src\\main\\webapp\\resources\\upload\\";
		File dir = new File(realFolder);
		
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		//넘어온 파일을 리스트로 저장
		List<MultipartFile> fileList = mhsq.getFiles("uploadFile");
		if(fileList.size() == 1 && fileList.get(0).getOriginalFilename().equals("")) {
			
		} else {
			for(int i = 0; i < fileList.size(); i++) {
				
				//파일 중복명 처리
				String genId = Integer.toString(i);
				//본래 파일 명
				String file_org_imgname = fileList.get(i).getOriginalFilename();
				//저장되는 파일 명
				String file_sav_imgname = room_no + "-" + genId + "." + FilenameUtils.getExtension(file_org_imgname);
				
				//저장될 파일 경로
				String savePath = realFolder + file_sav_imgname;
				
				long file_size = fileList.get(i).getSize(); //파일 사이즈
				
				fileList.get(i).transferTo(new File(savePath)); //파일 저장
				
				fileUpload(file_org_imgname, file_sav_imgname, file_size);
				
			}
		}
		
		mav.setViewName("redirect:adRoomList.yolo");
		
		return mav;
	}
	
	//객실 리스트
	@RequestMapping(value="adRoomList.yolo")
	public ModelAndView adRoomList(HttpServletRequest request) {
		
		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		List<RoomModel> roomList = new ArrayList<RoomModel>();
		
		roomList = adminService.adRoomList();
		
		totalCount = roomList.size();

		page = new Paging(currentPage, totalCount, blockCount, blockPage, searchNum, "", "roomList");
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		roomList = roomList.subList(page.getStartCount(), lastCount);

		mav.addObject("totalCount", totalCount);
		mav.addObject("pagingHtml", pagingHtml);
		mav.addObject("currentPage", currentPage);
		mav.addObject("roomList", roomList);
		mav.setViewName("adRoomList");
		
		return mav;
		
	}
	
	//객실 상세보기
	@RequestMapping(value="/adRoomView.yolo")
	public ModelAndView selectRoom(HttpServletRequest request) {
		
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		
		RoomModel roomModel = new RoomModel();
		List<RoomFileModel> fileList = new ArrayList<RoomFileModel>();
		
		roomModel = adminService.selectRoom(room_no);
		fileList = adminService.fileSelect(room_no);
		
		mav.addObject("roomModel", roomModel);
		mav.addObject("fileList", fileList);
		mav.setViewName("adRoomView");
		
		return mav;
	}
	
	//객실 정보 수정하기 폼
	@RequestMapping(value="/adRoomModify.yolo", method=RequestMethod.GET)
	public ModelAndView roomModifyForm(HttpServletRequest request) {
		
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		
		RoomModel roomModel = new RoomModel();
		List<RoomFileModel> fileList = new ArrayList<RoomFileModel>();
		
		roomModel = adminService.selectRoom(room_no);
		fileList = adminService.fileSelect(room_no);
		
		mav.addObject("roomModel", roomModel);
		mav.addObject("fileList", fileList);
		mav.setViewName("adRoomModify");
		
		return mav;
		
	}
	
	//객실 정보 수정하기
	@RequestMapping(value="/adRoomModify.yolo", method=RequestMethod.POST)
	public ModelAndView roomModify (@ModelAttribute("roomModel") RoomModel roomModel, HttpServletRequest request, MultipartHttpServletRequest mhsq) throws IllegalStateException, IOException {
		
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		List<RoomFileModel> oldFileList = new ArrayList<RoomFileModel>();
		
		oldFileList = adminService.fileSelect(room_no);
		
		roomModel.setRoom_no(room_no);
		adminService.roomModify(roomModel);
		
		String realFolder = "C:\\Users\\krupi\\App\\yolo\\src\\main\\webapp\\resources\\upload\\";
		File dir = new File(realFolder);
		
		if(!dir.isDirectory()) {
			dir.mkdirs();
		}
		
		//넘어온 파일을 리스트로 저장
		List<MultipartFile> fileList = mhsq.getFiles("uploadFile");
		
		//넘어온 파일 리스트가 있다면
		if(fileList.size() > 0) {
			
			if(fileList.size() == 1 && fileList.get(0).getOriginalFilename().equals("")) {
				
			} else {
				
				//실제 파일 삭제
				for(int j = 0; j < oldFileList.size(); j++) {
					
					RoomFileModel files = new RoomFileModel();
					files = adminService.files(oldFileList.get(j).getFile_no());
					
					File file = new File(realFolder + files.getFile_sav_imgname());
					
					if(file.exists()) {
						file.delete();
					}
				}
				
				for(int i = 0; i < fileList.size(); i++) {
					
					adminService.fileDelete(room_no); //기존 파일 DB 삭제
					
					//파일 중복명 처리
					String genId = Integer.toString(i);
					//본래 파일 명
					String file_org_imgname = fileList.get(i).getOriginalFilename();
					//저장되는 파일 명
					String file_sav_imgname = room_no + "-" + genId + "." + FilenameUtils.getExtension(file_org_imgname);
					
					//저장될 파일 경로
					String savePath = realFolder + file_sav_imgname;
					
					long file_size = fileList.get(i).getSize(); //파일 사이즈
					
					fileList.get(i).transferTo(new File(savePath)); //파일 저장
					
					fileUpload(file_org_imgname, file_sav_imgname, file_size);
					
				}
			}
		}
		
		mav.setViewName("redirect:adRoomList.yolo");
		
		return mav;
	}
	
	//객실 삭제하기
	@RequestMapping(value="adDeleteRoom.yolo")
	public ModelAndView deleteRoom(HttpServletRequest request) {
		
		String realFolder = "C:\\Users\\krupi\\App\\yolo\\src\\main\\webapp\\resources\\upload\\";
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		List<RoomFileModel> fileList = new ArrayList<>();
		
		fileList = adminService.fileSelect(room_no);
		
		//실제 파일 삭제
		for(int i = 0; i < fileList.size(); i++) {
			
			RoomFileModel files = new RoomFileModel();
			files = adminService.files(fileList.get(i).getFile_no());
			
			File file = new File(realFolder + files.getFile_sav_imgname());
			
			if(file.exists()) {
				file.delete();
			}
		}
		
		adminService.deleteRoom(room_no);
		//파일 DB 삭제
		adminService.fileDelete(room_no);
		
		mav.setViewName("redirect:adRoomList.yolo");
		
		return mav;
		
	}
	
	//파일 업로드용 메서드
	public void fileUpload(String file_org_imgname, String file_sav_imgname, long file_size) {
		
		List<RoomModel> roomList = new ArrayList<RoomModel>();
		
		roomList = adminService.selectRecentRoom();
		int room_no = roomList.get(0).getRoom_no();
		
		RoomFileModel roomFileModel = new RoomFileModel();
		
		roomFileModel.setFile_org_imgname(file_org_imgname);
		roomFileModel.setFile_sav_imgname(file_sav_imgname);
		roomFileModel.setFile_size(file_size);
		roomFileModel.setRoom_no(room_no);
		
		adminService.uploadFile(roomFileModel);
		
	}
	
	/****************************예약 관리****************************/
	
	//예약 리스트
	@RequestMapping(value="adReservList.yolo")
	public ModelAndView adReservList(HttpServletRequest request) {
		
		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		List<ReservModel> reservList = new ArrayList<ReservModel>();
		
		reservList = adminService.adReservList();
		
		totalCount = reservList.size();

		page = new Paging(currentPage, totalCount, blockCount, blockPage, searchNum, "", "reservList");
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		reservList = reservList.subList(page.getStartCount(), lastCount);

		mav.addObject("totalCount", totalCount);
		mav.addObject("pagingHtml", pagingHtml);
		mav.addObject("currentPage", currentPage);
		mav.addObject("reservList", reservList);
		mav.setViewName("adReservList");
		
		return mav;
		
	}
	
	//예약 내역 상세보기
	@RequestMapping(value="adReservView.yolo")
	public ModelAndView adReservView(HttpServletRequest request) {
		
		int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
		
		ReservModel reservModel = new ReservModel();
		
		reservModel = adminService.reservView(reserv_no);
		
		mav.addObject("reservModel", reservModel);
		mav.setViewName("adReservView");
		
		return mav;
	}
	
	//입금 확인
	@RequestMapping(value="adReservPayChk.yolo")
	public ModelAndView reservPayChk(HttpServletRequest request) {
		
		int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
		
		//입금 확인
		adminService.reservPayCheck(reserv_no);
		
		//입금확인 시 예약완료로 상태 변경
		ReservModel reservModel = new ReservModel();
		reservModel.setReserv_no(reserv_no);
		reservModel.setReserv_status(1);
		
		adminService.reservStatusModify(reservModel);
		
		mav.setViewName("redirect:adReservList.yolo");
		
		return mav;
	}
	
	//예약 거부
	@RequestMapping(value="adReservRefuse.yolo")
	public ModelAndView reservRefuse(HttpServletRequest request) {
		
		int reserv_no = Integer.parseInt(request.getParameter("reserv_no"));
		
		//예약 거부
		ReservModel reservModel = new ReservModel();
		reservModel.setReserv_no(reserv_no);
		reservModel.setReserv_status(2);
		
		adminService.reservStatusModify(reservModel);
		
		mav.setViewName("redirect:adReservList.yolo");
		
		return mav;
	}
	
	/****************************예약취소 관리****************************/
	
	//예약취소 리스트
	@RequestMapping(value="adCancleList.yolo")
	public ModelAndView adCancleList(HttpServletRequest request) {
		
		if (request.getParameter("currentPage") == null || request.getParameter("currentPage").trim().isEmpty()
				|| request.getParameter("currentPage").equals("0")) {
			currentPage = 1;
		} else {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		List<CancleModel> cancleList = new ArrayList<CancleModel>();
		
		cancleList = adminService.adCancleList();
		
		totalCount = cancleList.size();

		page = new Paging(currentPage, totalCount, blockCount, blockPage, searchNum, "", "cancleList");
		pagingHtml = page.getPagingHtml().toString();

		int lastCount = totalCount;

		if (page.getEndCount() < totalCount)
			lastCount = page.getEndCount() + 1;

		cancleList = cancleList.subList(page.getStartCount(), lastCount);

		mav.addObject("totalCount", totalCount);
		mav.addObject("pagingHtml", pagingHtml);
		mav.addObject("currentPage", currentPage);
		mav.addObject("cancleList", cancleList);
		mav.setViewName("adCancleList");
		
		return mav;
	}
	
	//예약취소 상세보기
	@RequestMapping(value="adSelectCancle.yolo")
	public ModelAndView selectCancle(HttpServletRequest request) {
		
		int cancle_no = Integer.parseInt(request.getParameter("cancle_no"));
		
		CancleModel cancleModel = new CancleModel();
		
		cancleModel = adminService.selectCancle(cancle_no);
		
		mav.addObject("cancleModel", cancleModel);
		mav.setViewName("adCancleView");
		
		return mav;
	}
	
	//예약 취소 승인
	@RequestMapping(value="adCancleApproval.yolo")
	public ModelAndView cancleApproval(HttpServletRequest request) {
		
		int cancle_no = Integer.parseInt(request.getParameter("cancle_no"));
		
		CancleModel cancleModel = new CancleModel();
		CancleModel cancleModel1 = new CancleModel();
		ReservModel reservModel = new ReservModel();
		
		cancleModel1 = adminService.selectCancle(cancle_no);
		
		//취소 상태 변경
		cancleModel.setCancle_no(cancle_no);
		cancleModel.setCancle_status(1);
		
		adminService.cancleStatusModify(cancleModel);
		
		//예약 테이블 상태 변경
		reservModel.setReserv_no(cancleModel1.getReserv_no());
		reservModel.setReserv_status(4);
		
		adminService.reservStatusModify(reservModel);

		mav.setViewName("redirect:adCancleList.yolo");
		
		return mav;
	}
	
	//예약 취소 거절
	@RequestMapping(value="adCancleRefuse.yolo")
	public ModelAndView cancleRefuse(HttpServletRequest request) {
		
		int cancle_no = Integer.parseInt(request.getParameter("cancle_no"));
		
		CancleModel cancleModel = new CancleModel();
		CancleModel cancleModel1 = new CancleModel();
		ReservModel reservModel = new ReservModel();
		ReservModel reservModel1 = new ReservModel();
		
		cancleModel1 = adminService.selectCancle(cancle_no);
		reservModel1 = adminService.reservView(cancleModel1.getReserv_no());
		
		//취소 상태 변경
		cancleModel.setCancle_no(cancle_no);
		cancleModel.setCancle_status(2);
		
		adminService.cancleStatusModify(cancleModel);
		
		//예약 테이블 상태 변경
		if(reservModel1.getReserv_paychk() == 0) {
			reservModel.setReserv_no(cancleModel1.getReserv_no());
			reservModel.setReserv_status(5);
			
		} else if(reservModel1.getReserv_paychk() == 1) {
			reservModel.setReserv_no(cancleModel1.getReserv_no());
			reservModel.setReserv_status(6);
		}

		adminService.reservStatusModify(reservModel);

		mav.setViewName("redirect:adCancleList.yolo");
		
		return mav;
	}
	

}
