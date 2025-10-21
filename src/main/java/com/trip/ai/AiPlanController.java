package com.trip.ai;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.trip.member.model.UserDTO;
import com.trip.member.service.UserService;

@WebServlet("/ai/plan.do")
public class AiPlanController extends HttpServlet {
	
	private final UserService userService = new UserService();
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	
        try {
	       //1. 세션에서 로그인된 사용자 ID 가져오기
	    	HttpSession session = req.getSession();
	    	String userId = (String) session.getAttribute("id");
	    	
	    	//2. 로그인 상태인 경우, DB에서 회원 정보를 조회
	    	if (userId != null) {
	    		UserDTO user = userService.getAttribute("id");
	    		
	    		//3. JSP로 데이터를 전달하기 위해 request 객체에 "userInfo" 라는 이름으로 저장
	    		req.setAttribute("userInfo", user);
	    	}
	    	
	    	//4. jsp로 화면 전환
	        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/ai/plan.jsp");
	        dispatcher.forward(req, resp);
	        
        } catch (Exception e) {
            System.out.println("--- AiPlanController doGet 오류 발생 ---");
			e.printStackTrace();
			            
			// 사용자에게는 간단한 오류 메시지를 보여줄 수도 있습니다.
			resp.setContentType("text/html; charset=UTF-8");
			resp.getWriter().println("<h1>페이지를 로드하는 중 오류가 발생했습니다.</h1>");
			resp.getWriter().println("<p>서버 로그를 확인해주세요.</p>");
		}
    }
}