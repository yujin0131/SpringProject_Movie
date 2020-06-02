package dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import vo.UserVO;

@Repository("user_dao")
public class UserDAO {

	@Autowired
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public UserDAO() {
		// TODO Auto-generated constructor stub
	}

	public int register(UserVO vo) {

		int res = sqlSession.insert("u.register_member", vo);
		return res;

	}
	
	// 로그인 시도할 id 조회
	public UserVO selectOne(String id) {
		UserVO vo = null;
		vo = sqlSession.selectOne("u.user_one", id);
		return vo;
	}



}
