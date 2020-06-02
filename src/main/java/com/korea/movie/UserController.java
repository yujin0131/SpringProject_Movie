package com.korea.movie;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.UserDAO;
import vo.BoardVO;
import vo.UserVO;



@Controller
public class UserController {

	UserDAO user_dao;	// ==> @Repository에 있는 별칭과 똑같이 만들어줘야 한다.
	public void setUser_dao(UserDAO user_dao) {
		this.user_dao = user_dao;
	}
	
	@Autowired
	HttpServletRequest request;
	HttpServletResponse response;

	public UserController() {

	}
	

	
	
	@RequestMapping("/register.do")
	public String register_member( Model model, UserVO vo) {

		int res = user_dao.register(vo); 
		return Common.User.VIEW_PATH + "register_form.jsp";
	}
	
	@RequestMapping("/login_form.do")
	public String login_form() {
		return Common.User.VIEW_PATH + "login_form.jsp";
	}
	
	@RequestMapping("/login.do")
	@ResponseBody
	public String login(String id, String pwd) {
		
		UserVO user = user_dao.selectOne(id);		
		
		String resultStr = "";
		
		if(user == null) {
			resultStr = "no_id";
			return resultStr;
		}
		
		if(!user.getPwd().equals(pwd)) {
			resultStr = "no_pwd";
			return resultStr;
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		resultStr = "clear";
		return resultStr;
		
	}
	

	
	@RequestMapping("/mypage.do")
	public String myPage(UserVO vo) {
		
		return Common.User.VIEW_PATH + "mypage.jsp";
	}
	
	@RequestMapping("/logout.do")
	public String logout() {
		HttpSession session = request.getSession();
		session.removeAttribute("user");
		
		return "redirect:login_form.do";
		
	}




}