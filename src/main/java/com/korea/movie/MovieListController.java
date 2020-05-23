package com.korea.movie;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.MovieListDAO;

@Controller
public class MovieListController {
	
	MovieListDAO movieListDAO;
	
	public void setMovieListDAO(MovieListDAO movieListDAO) {
		this.movieListDAO = movieListDAO;
	}
	
	@RequestMapping( value= {"/", "/movieReleaseList.do"} )
	public String movieReleaseList() {
		return Common.Movie.VIEW_PATH + "movie_list_release.jsp"; 
	}
	
	@RequestMapping("/movieRankList.do")
	public String movieRankList() {
		return Common.Movie.VIEW_PATH + "movie_list_rank.jsp"; 
	}
	
	@RequestMapping("/movieQuery.do")
	public String movieQuery() {
		return Common.Movie.VIEW_PATH + "movie_query.jsp"; 
	}
	
	@RequestMapping("/movieInfoDetail.do")
	public String goMovieInfoDetail( Model model, String movieId, String movieSeq ) {
		
		model.addAttribute("movieId", movieId);
		model.addAttribute("movieSeq", movieSeq);
		return Common.Movie.VIEW_PATH + "movie_detail.jsp";
	}
}
