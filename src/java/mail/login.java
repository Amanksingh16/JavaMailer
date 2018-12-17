/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class login extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = request.getServletContext();
        PrintWriter out = response.getWriter();
        Connection con;
        String user = request.getParameter("user");
        String pass = request.getParameter("pwd");
        
        try{
            Class.forName(context.getInitParameter("con"));
            con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
            int count = 0;
            PreparedStatement check=con.prepareStatement("select pass from mailer where email='"+user+"'");
            ResultSet rs = check.executeQuery();
            while(rs.next())
            {
                count++;
                if(pass.equalsIgnoreCase(rs.getString(1)))
                {
                        request.getSession().setAttribute("user",request.getParameter("user"));
                        request.getSession().setAttribute("gpass",request.getParameter("pass"));
                        request.getSession().setAttribute("from",1);
                        request.getSession().setAttribute("to",15);
                        request.getSession().setAttribute("from1",1);
                        request.getSession().setAttribute("to1",10);
                        
                        response.sendRedirect("http://localhost:8080/JavaMailer/main.jsp");
                }
                else
                {
                               RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.include(request, response);
            out.println("<script type='text/javascript' src='http://code.jquery.com/jquery-latest.js'></script>");
    out.println("<script type='text/javascript'>"); 
    out.println("var text = 'Password is not correct';");                        
                        out.println("document.getElementById('msg').innerHTML = text;");
                        out.println("$(document).ready( function() {");
        out.println("$('#msg').delay(3000).fadeOut();");
      out.println("});");
                        out.println("</script>");
                }
            }
            if(count==0)
            {
                           RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.include(request, response);
            out.println("<script type='text/javascript' src='http://code.jquery.com/jquery-latest.js'></script>");
    out.println("<script type='text/javascript'>"); 
    out.println("var text = 'User Does not Exist';");                        
                        out.println("document.getElementById('msg').innerHTML = text;");
                        out.println("$(document).ready( function() {");
        out.println("$('#msg').delay(3000).fadeOut();");
      out.println("});");
                        out.println("</script>");
            }
        }
        catch(Exception e)
        {
            out.println(e);
        }
    }
}
