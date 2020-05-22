package com.korea.movie;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.MovieListDAO;

@Controller
public class MovieListController {
	
	MovieListDAO movieListDAO;
	
	public void setMovieListDAO(MovieListDAO movieListDAO) {
		this.movieListDAO = movieListDAO;
	}
	
	@RequestMapping( value= {"/", "/movieList.do"} )
	public String insert_form() {
		return Common.Movie.VIEW_PATH + "movie_list.jsp"; 
	}
	
}
