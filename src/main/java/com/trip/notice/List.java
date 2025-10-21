package com.trip.notice;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.trip.notice.model.NoticeDAO;
import com.trip.notice.model.NoticeDTO;

@WebServlet(value = "/list.do")
public class List extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//List.java
		String column = req.getParameter("column"); 
		String word = req.getParameter("word");
		String search = "n"; //목록보기(n), 검색하기(y)
		
		if (column != null && word != null && !word.trim().equals("")) {
			search = "y";
		}
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("column", column);
		map.put("word", word);
		map.put("search", search);
		
		//페이징 처리
		String page = req.getParameter("page");
		int nowPage = (page == null || page.equals("")) ? 1 : Integer.parseInt(page);
		int pageSize = 10;
		int begin = ((nowPage - 1) * pageSize) + 1;
		int end = begin + pageSize - 1;
		
		map.put("begin", String.valueOf(begin));
		map.put("end", String.valueOf(end));
		
		//DAO 연출
		NoticeDAO dao = new NoticeDAO();
		ArrayList<NoticeDTO> list = dao.getList(map);
		
		//총 게시물 수 및 총 페이지 수 계산
		int totalCount = dao.getTotalCount(map);
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		
		//데이터 가공(날짜 형식 변경, 제목자르기 등)
		Calendar now = Calendar.getInstance();
		String nowDate = String.format("%tF", now);
		
		for (NoticeDTO dto : list) {
			//오늘 쓴 글 new 아이콘 표시
			if (dto.getNotice_regdate().startsWith(nowDate)) {
				dto.setIsnew("y");
			}
			
			//날짜 형식 변경 (YYYY-MM-DD)
			dto.setNotice_regdate(dto.getNotice_regdate().substring(0, 10));
			
			//제목 자르기(예시)
			if (dto.getNotice_header().length() > 30) {
				dto.setNotice_header(dto.getNotice_header().substring(0, 30) + "...");
			}
		}
		
		//페이지바 생성
		StringBuilder pagebar = new StringBuilder();
		int blockSize = 10;
		int n = ((nowPage - 1 ) / blockSize) * blockSize + 1;
		
		//이전 페이지
		if (n==1) {
			pagebar.append("<a href='#1'>[이전]</a>");
		} else {
			pagebar.append(String.format("<a href='/trip/notice/list.do?page=%d'>[이전]></a>", n - 1));
		}
		
		//페이지 번호
		for (int i = 0; i < blockSize && n <= totalPage; i++) {
			if (n == nowPage) {
				pagebar.append(String.format("<a href='#!' class='active'>%d</a>",n));
			} else {
				pagebar.append(String.format("<a href='/trip/notice/list.do?page=%d'>%d</a>", n, n));
			}
			n++;
		}
		
		//다음 페이지
		if (n > totalPage) {
			pagebar.append("<a href='#!'>[다음]</a>");
		} else {
			pagebar.append(String.format("<a href='/trip/notice/list.do?page=%d'>[다음]</a>", n));
		}
		
		//2. JSP에게 데이터 전달하기
		req.setAttribute("list", list);
		req.setAttribute("map", map);
		req.setAttribute("totalCount", totalCount);
		req.setAttribute("totalPage", totalPage);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("pagebar", pagebar.toString());
		

		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/notice/list.jsp");
		dispatcher.forward(req, resp);
	}

}
