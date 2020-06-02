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
	public List<BoardVO> selectList(String m_name){
		
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list", m_name);
		return list;	
	}
	
	//평점 조회
	public int selectSum( String m_name ) {
	
		int sum = sqlSession.selectOne("b.sum", m_name);
		return sum;
	}
	
	public int selectNum() {
		
		int num = sqlSession.selectOne("b.num");
		return num;
	}
	

	
	//영화 조회
	public String selectM( String m_name ) {
				
		String user_m_name = sqlSession.selectOne("b.user_m_name", m_name);
		return user_m_name;
	}
	
	
	//리뷰썼는지 확인
	public String selectReview(String id) {//String id
		/*
		 * BoardVO vo = sqlSession.selectOne("b.user_content", id);
		 * return vo;
		 */
		String content = sqlSession.selectOne("b.user_contnet", id);
		return content;
	}
	
	
	
	//게시글 추가
	public int insert( BoardVO vo) {
		
	//HashMap<Object, Object> map = new HashMap<Object, Object>();
	//map.put("vo", vo);
	//map.put("scope", scope);
	
		
	int res = sqlSession.insert("b.board_insert", vo);
	
	return res;
			
	}
	
	//게시글 수정하기 위해 정보 하나 얻어오기
	public BoardVO selectModify(String id) {
		BoardVO res = sqlSession.selectOne("b.board_modify", id);
		return res;
	}
	
	public int update(BoardVO vo) {
		int res = sqlSession.update("b.board_update", vo);
		return res;
	}
	
	//삭제
	public int delete(String id) {
		int res = sqlSession.delete("b.board_delete", id);
		return res;
	}
	
	//페이징을 포함한 검색
	public List<BoardVO> selectList(Map<String, Object> map){	
		List<BoardVO> list = null;
		list = sqlSession.selectList("b.board_list_condition", map);
		return list;
	}
		
	//게시판의 전체 게시물 수
	public int getRowTotal() {
		int count = sqlSession.selectOne("board_count"); 
		return count;
	}
	
}
















