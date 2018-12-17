package mail;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class previous extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String next = request.getParameter("page");
        if(next.equals("previous"))
        {
        request.getSession().setAttribute("from",Integer.parseInt(request.getSession().getAttribute("from").toString())-15);
        request.getSession().setAttribute("to",Integer.parseInt(request.getSession().getAttribute("to").toString())-15);
        response.sendRedirect("main.jsp");
        }
        else
        {
            request.getSession().setAttribute("from1",Integer.parseInt(request.getSession().getAttribute("from1").toString())-15);
        request.getSession().setAttribute("to1",Integer.parseInt(request.getSession().getAttribute("to1").toString())-15);    
        response.sendRedirect("main.jsp");
        };
    }
}
