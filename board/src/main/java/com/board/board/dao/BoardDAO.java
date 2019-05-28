package com.board.board.dao;

import java.util.List;

import com.board.board.BoardV0;

public interface BoardDAO {
	public void create(BoardV0 boardV0) throws Exception;
	BoardV0 read(Integer number) throws Exception;
	public void update(BoardV0 boardV0) throws Exception;
	public void delete(Integer number) throws Exception;
	public List<BoardV0> listAll() throws Exception;
}
