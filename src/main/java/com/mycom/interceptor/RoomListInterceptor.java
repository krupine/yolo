package com.mycom.interceptor;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;  
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.mycom.room.RoomModel;
import com.mycom.room.RoomService;

public class RoomListInterceptor implements HandlerInterceptor {

	@Resource
	private RoomService roomService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		return true;
		
	}
		
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler, ModelAndView view)
			throws Exception {
 
		List<RoomModel> roomList = new ArrayList<RoomModel>();
		roomList = roomService.roomList();
		
		view.addObject("roomList99", roomList);
 
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

		if (ex != null) {
			System.out.println("작업에 익셉션이 발생하였습니다.");
		}

	  }
	
}
