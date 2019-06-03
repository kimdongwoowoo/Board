package com.board.board.service;

import java.util.List;

import com.board.board.BoardV0;
import com.board.board.BoardWrapper;
import com.board.board.Criteria;

public interface BoardService {
	public void create(BoardV0 boradV0) throws Exception;
	BoardV0 read(Integer number) throws Exception;
	public void update(BoardV0 boradV0) throws Exception;
	public void delete(Integer number) throws Exception;
	public List<BoardV0> listAll() throws Exception;
	public List<BoardV0> listCriteria(Criteria criteria) throws Exception;
	public List<BoardWrapper> listBoardAndReplys() throws Exception;
	public int countBoard() throws Exception;
}
 