package com.board.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;
import com.board.board.dao.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;

	@Override
	public void createReply(ReplyV0 replyV0) throws Exception {
		replyV0.setRegDate(new Date());
		replyDAO.createReply(replyV0);
		// TODO Auto-generated method stub

	}

	@Override
	public ReplyV0 lastReply() throws Exception {
		// TODO Auto-generated method stub
		return replyDAO.lastReply();
	}

	@Override
	public List<ReplyWrapper> readReplys(Integer number) throws Exception {

		List<ReplyV0> replys = replyDAO.readReplys(number);
		List<ReplyWrapper> rs = new ArrayList<ReplyWrapper>();

		for (ReplyV0 r : replys) {
			ReplyWrapper rw = new ReplyWrapper();
			if (r.getParentNumber() != null) // 서브인애들은 패스
				continue;
			rw.setReplyV0(r);// 본댓글 세팅해주고
			List<ReplyV0> subReplys = replyDAO.readSubReplys(number, r.getReplyNumber());// 서브댓글 불러오기
			rw.setSubReplys(subReplys);// 서브댓글 세팅해줌

			rs.add(rw);// 리스트에 추가
		}
		return rs;
		// TODO Auto-generated method stub

	}

	@Override
	public ReplyV0 readReply(Integer number) throws Exception {
		// TODO Auto-generated method stub
		return replyDAO.readReply(number);
	}

	@Override
	public void deleteReply(Integer number) throws Exception {
		replyDAO.deleteReply(number);
		// TODO Auto-generated method stub

	}

}
