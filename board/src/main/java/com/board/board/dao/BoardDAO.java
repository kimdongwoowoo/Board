package com.board.board.dao;

import java.util.List;

import com.board.board.BoardV0;
import com.board.board.Criteria;

public interface BoardDAO {
	public void create(BoardV0 boardV0) throws Exception;
	public BoardV0 read(Integer number) throws Exception;
	public void update(BoardV0 boardV0) throws Exception;
	public void delete(Integer number) throws Exception;
	public List<BoardV0> listAll() throws Exception;
	public List<BoardV0> listCriteria(Criteria criteria) throws Exception;
	public void updateReplyCnt(Integer number,int amount) throws Exception;
	public int countBoard() throws Exception;
}
