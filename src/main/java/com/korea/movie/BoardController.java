package com.korea.movie;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import common.Paging;
import dao.BoardDAO;
import vo.BoardVO;

@Controller
public class BoardController {

	BoardDAO board_dao;
	public void setBoard_dao(BoardDAO board_dao) {
		this.board_dao = board_dao;
	}

	@Autowired
	HttpServletRequest request;

	@RequestMapping( value= {"/", "/list.do"} )
	public String list(Model model, Integer page) {

		int nowPage = 1;

		if(page != null) {
			nowPage = page;
		}

		//한 페이지에 표시되는 게시물의 시작과 끝번호를 계산
		int start = ( nowPage - 1 ) * Common.Board.BLOCKLIST + 1;
		int end = start + Common.Board.BLOCKLIST - 1;

		//start와 end를 맵에 저장
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);

		//게시글 전체목록 가져오기
		List<BoardVO> list = null;
		list = board_dao.selectList(map);

		//전체 게시물 수 구하기
		int row_total = board_dao.getRowTotal();

		//Paging클래스를 사용하여 페이지 메뉴 생성하기
		String pageMenu = Paging.getPaging(
				"list.do", nowPage, row_total, 
				Common.Board.BLOCKLIST, 
				Common.Board.BLOCKPAGE );

		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);

		//세션에 기록되어 있던 show정보를 삭제
		request.getSession().removeAttribute("show");

		return Common.VIEW_PATH + "board_list.jsp";

	}

	// 게시글 보기
	@RequestMapping("/view.do")
	public String view(Model model, int idx, int page) {

		//view.do?idx=25
		//idx에 해당하는 게시글 한 건 얻어오기
		BoardVO vo = board_dao.selectOne(idx);

		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		if( show == null ) {
			board_dao.update_readhit(idx);
			session.setAttribute("show", "");
		}

		model.addAttribute("vo", vo); // 바인딩/포워딩

		return Common.VIEW_PATH + "board_view.jsp"; // 바인딩/포워딩이 필요할 때는 VIEW_PATH 사용

	}

	// 게시글 작성 화면 이동
	@RequestMapping("/insert_form.do")
	public String insert_form() {
		return Common.VIEW_PATH + "board_write.jsp"; 
	}

	// 게시글 등록
	@RequestMapping("/insert.do")
	public String insert(BoardVO vo) {
		//접속자의 ip구하기
		String ip = request.getRemoteAddr();
		vo.setIp(ip);

		//DB에 insert
		board_dao.insert(vo);

		return "redirect:list.do"; // 바인딩/포워딩 없이 페이지 전환만 할때  

	}

	// 게시글 삭제
	@RequestMapping("/del.do")
	@ResponseBody // Ajax에는 @ResponseBody가 반드시 필요!
	public String delete(int idx, String pwd) {

		BoardVO baseVO = board_dao.selectOne(idx, pwd);

		String result = "no";

		if( baseVO == null ) {
			return result;
		}

		//찾아온 게시글의 정보를 수정
		baseVO.setSubject("삭제된 게시글 입니다.");
		baseVO.setName("known");

		int res = board_dao.del_update(baseVO); 
		if(res == 1) {
			result = "yes";
		}
		return result; // result라는 페이지로 가는게 아니고 문자열로 인식해서 보내줄 때는 @ResponseBody가 필요함! 없을 경우에는 페이지(.jsp)로 인식함.
	}

	// 댓글 달기 위한 페이지 이동
	@RequestMapping("/reply_form.do")
	public String reply_form() {
		return Common.VIEW_PATH + "board_reply.jsp";
	}

	// 댓글 등록
	@RequestMapping("/reply.do")
	public String reply(BoardVO vo, String page) {

		//idx사용하여 게시물 정보 얻기
		BoardVO baseVo = board_dao.selectOne(vo.getIdx());

		//기준글의 step보다 큰 값은 모두 step = step+1처리
		board_dao.update_step(baseVo);

		//달고자 하는 댓글을 vo에 포장
		String ip = request.getRemoteAddr();
		vo.setIp(ip);

		vo.setRef(baseVo.getRef());
		vo.setStep(baseVo.getStep() + 1);
		vo.setDepth(baseVo.getDepth() + 1);

		//댓글 등록!
		board_dao.reply(vo);

		return "redirect:list.do?page=" + page;
	}


}
