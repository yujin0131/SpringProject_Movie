package com.korea.movie;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.MovieListDAO;
import vo.MovieRankPosterVO;

@Controller
public class MovieListController {
	
	MovieListDAO movieListDAO;
	
	public void setMovieListDAO(MovieListDAO movieListDAO) {
		this.movieListDAO = movieListDAO;
	} 
	
	@RequestMapping( value= {"/", "/movieReleaseList.do"} )
	public String movieReleaseList() {
		return Common.Movie.VIEW_PATH + "movie_list.jsp"; 
	}
	
	@RequestMapping("/movieInfoDetail.do")
	public String goMovieInfoDetail( Model model, String movieId, String movieSeq ) {
		int type = 1;
		model.addAttribute("type", type);
		model.addAttribute("movieId", movieId);
		model.addAttribute("movieSeq", movieSeq);
		return Common.Movie.VIEW_PATH + "movie_detail.jsp";
	}
	
	@RequestMapping("/movieInfoDetailRank.do")
	public String goMovieInfoDetail2( Model model, String releaseDts, String title ) {
		int type = 2;
		model.addAttribute("type", type);
		model.addAttribute("releaseDts", releaseDts);
		model.addAttribute("title", title);
		return Common.Movie.VIEW_PATH + "movie_detail.jsp";
	}
	
	@RequestMapping("/moviePosterLoad.do")
	@ResponseBody
	public List<MovieRankPosterVO> loadRankPoster() {
		List<MovieRankPosterVO> list = null;
		list = movieListDAO.selectList();
		return list;
	}
	
	@RequestMapping("/movieTrailerLoad.do")
	@ResponseBody
	public MovieRankPosterVO loadTrailer(String movieNm) {
		System.out.println(movieNm);
		MovieRankPosterVO vo = null;
		vo = movieListDAO.selectOne(movieNm);
		return vo;
	}
	
}
