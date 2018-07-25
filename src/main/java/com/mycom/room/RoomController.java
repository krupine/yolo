package com.mycom.room;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.admin.RoomFileModel;

@Controller
@RequestMapping("/room")
public class RoomController {
	
	@Resource
	private RoomService roomService;
	
	ModelAndView mav=new ModelAndView();
	
	@RequestMapping("roomView.yolo")
	public ModelAndView roomView(HttpServletRequest request) {
		
		RoomModel roomModel = new RoomModel();
		List<RoomFileModel> fileList = new ArrayList<RoomFileModel>();
		
		int room_no = Integer.parseInt(request.getParameter("room_no"));
		
		roomModel = roomService.selectRoom(room_no);
		fileList = roomService.fileSelect(room_no);
		
		mav.addObject("roomModel", roomModel);
		mav.addObject("fileList", fileList);
		mav.setViewName("roomView");
		
		return mav;
	}

}
