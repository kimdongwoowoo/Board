package com.board.board.controller.board;

import java.time.Month;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.http.converter.json.MappingJacksonHttpMessageConverter;

import com.board.board.BoardV0;
import com.board.board.BoardWrapper;
import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;
import com.board.board.service.BoardService;
import com.board.board.service.ReplyService;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.*;
@Controller
public class BoardController {
	public List<BoardV0> tmpList=new ArrayList<BoardV0>();

	private static final Logger logger=LoggerFactory.getLogger(BoardController.class);
	
	@Inject //BoardServiceImpl �깮�꽦�빐�꽌 �븘�옒 �씤�꽣�럹�씠�뒪�뿉 諛곗젙�빐以�
	private BoardService boardService;
	@Inject
	private ReplyService replyService;
	
	@RequestMapping(value="/")
    public String welcome(){
        return "redirect:list";
    }
	
	
	@RequestMapping(value= "list", method = RequestMethod.GET)
	//@ResponseBody
	public String list(Model model) throws Exception{
		logger.info("list...");
		/*List<BoardWrapper> list=boardService.listBoardAndReplys();		
		Map<String,Object> map=new HashMap<>();
		map.put("list", list);
		model.addAttribute("boards",map);
		*/
		List<BoardV0> list=boardService.listAll();		
		model.addAttribute("boards",list);
		
		return "list";
	}
	
	//�젣紐⑺겢由��떆 踰덊샇瑜� 諛쏆븘�꽌 寃뚯떆湲��젙蹂�+�뙎湲� 由ъ뒪�듃瑜� httpRequest濡� jsp濡� �꽆寃⑥쨲
	@RequestMapping(value="read",method=RequestMethod.GET)
	public String read(@RequestParam("number") int number,Model model) throws Exception {
		logger.info("read...");
		BoardV0 boardV0=boardService.read(number);
		List<ReplyWrapper> replys=replyService.readReplys(number);
		
		model.addAttribute("board",boardV0);
		model.addAttribute("replys",replys);
		return "read";
	}
	
	
	@RequestMapping(value="readBoardAndReplys", method=RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> readBoardsAndReplys() throws Exception {
		logger.info("readBoardsAndReplys...");
		List<BoardWrapper> list=boardService.listBoardAndReplys();		
		Map<String,Object> map=new HashMap<>();
		map.put("list", list);
		return map;
	}
	
	
	
	//get방식으로 게시판 번호 받아서 게시판내용만 파라미터에 실어서 리턴, 댓글은 그 페이지로 가서 ajax로 받는다.
	@RequestMapping(value="read2",method=RequestMethod.GET)
	public String read2(@RequestParam("number") int number,Model model) throws Exception {
		logger.info("read2...");
		BoardV0 boardV0=boardService.read(number);
		model.addAttribute("board",boardV0); 
		return "read2";
	}
	
	@RequestMapping(value="listTest", method=RequestMethod.GET)
	public String listTest() throws Exception {
		logger.info("listTest...");
		return "listTest";
	}
	
	@RequestMapping(value="write", method=RequestMethod.GET)
	public String writeGET() {
		logger.info("write GET...");
		return "write2"; //write.jsp
	}
	
	
	@RequestMapping(value="write", method=RequestMethod.POST)
	@ResponseBody
	public int writePOST(BoardV0 boardV0) throws Exception{
		logger.info("write POST...");
		boardService.create(boardV0); //DB�뿉 ���옣�븯怨�
		return 0; //�벑濡앹셿猷�
	}
	
	//寃뚯떆臾쇰쾲�샇, 鍮꾨쾲�쓣 �꽆寃⑤컺�븘�꽌  踰덊샇濡� �뼸�뼱�삩 鍮꾨쾲�씠�옉 媛숈쑝硫� return 1 �떎瑜대㈃ return 0
	
	@RequestMapping(value="password_check",method=RequestMethod.POST)
	@ResponseBody
	public int passwordCheck(HttpServletRequest request) throws Exception{
		logger.info("password check...");
		Integer num=Integer.parseInt(request.getParameter("number"));
		String password=request.getParameter("password");
		BoardV0 boardV0=boardService.read(num);
		if(boardV0.getPassword().equals(password))
			return 1;
		else
			return 0;
	}
	
	
	//read�뿉�꽌 �꽆�뼱�삤�뒗嫄곌린�븣臾몄뿉 number媛� �꽆�뼱�샂, �떎�떆 �씫�뼱�빞�븿
	@RequestMapping(value="modify", method=RequestMethod.GET)
	public String modifyGET(@RequestParam("number") int number,Model model)throws Exception{
		logger.info("modify GET...");
		BoardV0 boardV0=boardService.read(number);
		model.addAttribute("board",boardV0);
		return "modify"; //modify.jsp
	}
	//�닔�젙�맂 �궡�슜�씠 媛앹껜濡� �꽆�뼱�샂 (json->object)
	//json�뿉�꽌 議고쉶�닔�뒗 0�쑝濡� �꽆�뼱�삤湲� �븣臾몄뿉 0�씠吏�留� �뼱李⑦뵾 DAO�뿉�꽌 update�븷�븣 �떎瑜몃�遺꾨쭔 �닔�젙�븯硫� �맂�떎.
	@RequestMapping(value="modify", method=RequestMethod.POST)
	@ResponseBody
	public int modifyPOST(BoardV0 boardV0)throws Exception{
		logger.info("modify POST...");
	
		boardService.update(boardV0);
		return 0;
	}
	
	@RequestMapping(value="delete",method=RequestMethod.GET)
	public String delete(@RequestParam("number") int number) throws Exception{
		logger.info("delete...");
		boardService.delete(number);
		return "redirect:list";
	}
	
	
	
	
	
}
