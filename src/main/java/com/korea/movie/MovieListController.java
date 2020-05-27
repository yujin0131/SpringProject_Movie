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
		
		model.addAttribute("movieId", movieId);
		model.addAttribute("movieSeq", movieSeq);
		return Common.Movie.VIEW_PATH + "movie_detail.jsp";
	}
	
	@RequestMapping("/moviePosterLoad.do")
	@ResponseBody
	public List<MovieRankPosterVO> loadRankPoster() {
		System.out.println("여기");

		List<MovieRankPosterVO> list = null;
		list = movieListDAO.selectList();
		/* String result = String.format("[{'list':%s}]",list); */
		return list;
		
	}
	
}
