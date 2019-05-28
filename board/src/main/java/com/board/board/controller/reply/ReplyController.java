package com.board.board.controller.reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;
import com.board.board.controller.board.BoardController;
import com.board.board.service.BoardService;
import com.board.board.service.ReplyService;
@Controller
public class ReplyController {
	
	private static final Logger logger=LoggerFactory.getLogger(ReplyController.class);
	@Inject
	private ReplyService replyService;
	
	
	@RequestMapping(value="add_reply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> addReply(ReplyV0 replyV0) throws Exception{
		logger.info("add reply...");
		replyService.createReply(replyV0);
		ReplyV0 lastReply=replyService.lastReply();
		HashMap<String, Object> map=new HashMap<String, Object>();
		map.put("lastReply",lastReply);
		return map;
	}
	
	@RequestMapping(value="readReplys", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> readReplys(@RequestParam("number") int number) throws Exception {
		logger.info("readReplys...");
		List<ReplyWrapper> replys=replyService.readReplys(number);
		Map<String,Object> map=new HashMap<>();
		map.put("replys", replys);
		return map;
	}
	
	@RequestMapping(value="password_check_reply", method=RequestMethod.POST)
	@ResponseBody
	public int passwordCheckReply(HttpServletRequest request) throws Exception {
		logger.info("password check Reply...");
		Integer num=Integer.parseInt(request.getParameter("number"));
		String password=request.getParameter("password");
		ReplyV0 replyV0=replyService.readReply(num); //한개불러오기
		if(replyV0.getPassword().equals(password))
			return 1;
		else
			return 0;
	}
	
	
	
}
