package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import vo.MovieRankPosterVO;

public class MovieListDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<MovieRankPosterVO> selectList(){ 
		
		List<MovieRankPosterVO> list = null;
		list = sqlSession.selectList("m.movie_poster_list");
		return list;
		
	}
	
	
}
