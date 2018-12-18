/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mail;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

public class update extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = request.getServletContext();
        PrintWriter out = response.getWriter();
        Connection con;
        if(request.getParameter("dltac")!=null)
        {
            try{
            Class.forName(context.getInitParameter("con"));
            con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
            
            PreparedStatement prep=con.prepareStatement("Delete from mailer where email='"+request.getSession().getAttribute("user").toString()+"'");
           prep.execute();
           request.getSession().invalidate();
           response.sendRedirect("http://localhost:8080/JavaMailer");
            }
        catch(IOException | ClassNotFoundException | SQLException e)
        {
            out.println(e);
        }    
        }
        else
        {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        Part part = request.getPart("profile");
        String content = part.getHeader("content-disposition");
            String[] items = content.split(";");
            String filename = items[2].substring(items[2].indexOf("=")+2, items[2].length()-1);
String savepath = "/C:/Users/Aman Singh/Documents/NetBeansProjects/JavaMailer/web/resources";
            String path = savepath+File.separator+filename;
            File file = new File(savepath);
            if(!file.exists())
            {
                file.mkdirs();
            }
            part.write(path);            
        
            try{
            Class.forName(context.getInitParameter("con"));
            con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
            
            PreparedStatement prep=con.prepareStatement("Update mailer set fname=? , lname=? , phone=? , gender=? , dob=? , path=? where email='"+request.getSession().getAttribute("user").toString()+"'");
           prep.setString(1,fname);
           prep.setString(2,lname);
           prep.setString(3,phone);
           prep.setString(4,gender);
           prep.setString(5,dob);
           prep.setString(6,filename);
           prep.executeUpdate();
           
           response.sendRedirect("http://localhost:8080/JavaMailer/main.jsp");
            }
        catch(IOException | ClassNotFoundException | SQLException e)
        {
            out.println(e);
        }
        }
    }
}
