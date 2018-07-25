package com.mycom.yolo;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	
	ModelAndView mav = new ModelAndView();
	
	
	//메인화면
	@RequestMapping(value="main.yolo")
	public ModelAndView main(HttpServletRequest request) {
		
		mav.setViewName("main");
		
		return mav;
	}

}
