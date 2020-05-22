package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.BoardVO;

public class BoardDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//전체 게시글 조회
	public List<BoardVO> selectList(){
		
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list");
		return list;	
	}
	
	//게시글 추가
	public int insert( BoardVO vo ) {
		
		int res = sqlSession.insert("b.board_insert", vo);
		return res;
		
	}
	
	//idx에 해당하는 게시글 한 건 얻어오기
	public BoardVO selectOne( int idx ) {
		BoardVO vo = null;
		vo = sqlSession.selectOne("b.board_one", idx);
		return vo;
	}
	
	//조회수 증가
	public int update_readhit(int idx) {
		
		int res = sqlSession.update("b.board_update_readhit", idx);
		return res;
		
	}
	
	//기준글의 step보다 큰 값 +1처리
	public int update_step( BoardVO baseVo ) {
		int res = sqlSession.update("b.board_update_step", baseVo);
		return res;
	}
	
	//댓글달기
	public int reply( BoardVO vo ) {
		int res = sqlSession.insert("b.board_reply", vo);
		return res;
	}
	
	//삭제를 위한 게시글의 정보 가져오기
	public BoardVO selectOne(int idx, String pwd) {
		BoardVO vo = null;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("idx", idx);
		map.put("pwd", pwd);
		
		vo = sqlSession.selectOne("b.board_idx_pwd", map);
		
		return vo;
	}
	
	//게시글 삭제(된 것 처럼) 업데이트
	public int del_update( BoardVO vo ) {
		
		int res = sqlSession.update("b.board_del_update", vo);
		return res;
		
	}
	
	//페이징을 포함한 검색
	public List<BoardVO> selectList(Map<String, Integer> map){
		
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list_condition", map);
		return list;
		
	}

	//게시판의 전체 게시물 수
	public int getRowTotal() {
		
		int count = sqlSession.selectOne("b.board_count");
		return count;
		
	}
	
}



















