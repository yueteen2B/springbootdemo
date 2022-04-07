package com.ispan.springbootdemo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ispan.springbootdemo.model.WorkMessages;
import com.ispan.springbootdemo.service.WorkMessagesService;

@Controller
public class PageController {

	@Autowired
	private WorkMessagesService messageService;
	//點訊息後會顯示之前留的最新的訊息資訊
	
	@GetMapping("/")
	public String welcomIndex() {
		return "index";
	}
	//點訊息後會顯示之前留的最新的訊息資訊

	@GetMapping("/message/add")
	public ModelAndView addMessagePage(ModelAndView mav) {

		WorkMessages message = new WorkMessages();
		mav.getModel().put("workMessages", message);

		WorkMessages lastMag = messageService.getLastest();
		mav.getModel().put("lastMessage", lastMag);
		//點訊息後會顯示之前留的最新的訊息資訊
		
		mav.setViewName("addMessage");
		return mav;
	}
	
	
	@GetMapping("/message/viewMessages")
	public ModelAndView viewMessages(ModelAndView mav, @RequestParam(name="p", defaultValue = "1") Integer pageNumber) {
		Page<WorkMessages> page = messageService.findByPage(pageNumber);
		
		mav.getModel().put("page", page);
		mav.setViewName("viewMessages");
		
		return mav;
	}

	@GetMapping("/message/ajax")
	public String ajaxPage() {
		return "ajax-messages";
	}
	
}

//  /:表示首頁"myapp" http://localhost:8080/myapp/連到index.jsp
//"addMessage"是從MessageController來的