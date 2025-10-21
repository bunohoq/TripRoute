package com.trip.route;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/route/userRouteView.do")
public class UserRouteViewPage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        String userRouteId = req.getParameter("id");
        
        req.setAttribute("userRouteId", userRouteId);

        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/route/userRouteView.jsp");
        dispatcher.forward(req, resp);
    }
}
