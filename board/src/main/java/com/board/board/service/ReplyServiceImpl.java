package com.board.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;
import com.board.board.dao.BoardDAO;
import com.board.board.dao.ReplyDAO;

@Service
public class ReplyServiceImpl implements ReplyService {

	@Inject
	private ReplyDAO replyDAO;
	
	@Inject
	private BoardDAO boardDAO;
	
	@Transactional //댓글이 삭제, 추가가 동시에 이뤄질수있기 때문에 두 작업을 트랜잭션 처리, 동기화
	@Override
	public void createReply(ReplyV0 replyV0) throws Exception {
		replyV0.setRegDate(new Date());
		replyDAO.createReply(replyV0);
		boardDAO.updateReplyCnt(replyV0.getBoardNumber(), 1);
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

	}

	@Override
	public void updateReply(ReplyV0 replyV0) throws Exception {
		replyDAO.updateReply(replyV0);

	}

	@Override
	public ReplyV0 readReply(Integer number) throws Exception {
		return replyDAO.readReply(number);
	}

	@Transactional
	@Override
	public void deleteReply(Integer number) throws Exception {
		int boardNumber=replyDAO.getBoardNumber(number);//해당 게시판의 번호를 미리 받아놓음
		replyDAO.deleteReply(number);
		boardDAO.updateReplyCnt(boardNumber, -1);
		

	}

}
