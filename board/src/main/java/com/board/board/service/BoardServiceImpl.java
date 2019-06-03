package com.board.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.board.board.BoardV0;
import com.board.board.BoardWrapper;
import com.board.board.Criteria;
import com.board.board.ReplyV0;
import com.board.board.ReplyWrapper;
import com.board.board.dao.BoardDAO;
import com.board.board.dao.ReplyDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	BoardDAO boardDao;
	@Inject
	ReplyDAO replyDao;

	@Override
	public void create(BoardV0 boardV0) throws Exception {
		// TODO Auto-generated method stub
		boardV0.setRegDate(new Date());
		boardDao.create(boardV0);
	}

	@Override
	public BoardV0 read(Integer number) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.read(number);
	}

	@Override
	public int countBoard() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.countBoard();
	}

	@Override
	public List<BoardV0> listCriteria(Criteria criteria) throws Exception {
		// TODO Auto-generated method stub
		return boardDao.listCriteria(criteria);
	}

	@Override
	public void update(BoardV0 boardV0) throws Exception {
		// TODO Auto-generated method stub
		boardV0.setRegDate(new Date());
		boardDao.update(boardV0);
	}

	@Override
	public void delete(Integer number) throws Exception {
		// TODO Auto-generated method stub
		boardDao.delete(number);
	}

	@Override
	public List<BoardV0> listAll() throws Exception {
		// TODO Auto-generated method stub
		return boardDao.listAll();
	}

	@Override
	public List<BoardWrapper> listBoardAndReplys() throws Exception {
		// TODO Auto-generated method stub
		List<BoardV0> boardList = boardDao.listAll(); // 본문리스트
		// for문으로 boards번호에 해당하는 리플 다갖고와서
		// 해당로직으로 걸러서 리스트 만들어서 ㄱ
		List<BoardWrapper> boardWrapperList = new ArrayList<>();
		for (BoardV0 b : boardList) {
			BoardWrapper bw = new BoardWrapper();
			bw.setBoardV0(b); // 게시물은 무조건 있고

			List<ReplyV0> replyList = replyDao.readReplys(b.getNumber()); // 일단 리플 싹다가져옴
			List<ReplyWrapper> replyWrapperList = new ArrayList<>();
			for (ReplyV0 r : replyList) { // 리플 하나하나 따면서
				if (r.getParentNumber() == null) { // depth가 1이면

					ReplyWrapper rw = new ReplyWrapper();
					rw.setReplyV0(r); // 내자신
					// 다시 게시물번호 && parentNum==reply.num인애들로 갖고와서 배정
					List<ReplyV0> subReplyList = replyDao.readSubReplys(b.getNumber(), r.getReplyNumber()); // 서브애들
					rw.setSubReplys(subReplyList);
					replyWrapperList.add(rw);
					// 없으면 null
				}
			}
			bw.setReplys(replyWrapperList);
			boardWrapperList.add(bw);
		}
		return boardWrapperList;
	}
}
