package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;

public class MovieListDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@RequestMapping(value={"/", "/movieList.do"} )
	public String list() {
		return Common.VIEW_PATH + "movie_list.jsp";
	}
}
