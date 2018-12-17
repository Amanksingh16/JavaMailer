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

public class register extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = request.getServletContext();
        PrintWriter out = response.getWriter();
        Connection con;
        
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("mail");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String dob = request.getParameter("dob");
        String pass = request.getParameter("pass");
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
            int count = 0;
            PreparedStatement check=con.prepareStatement("select * from mailer");
            ResultSet rs = check.executeQuery();
            while(rs.next())
            {
                if(email.equalsIgnoreCase(rs.getString(3)))
                {
                    count++;
                }
            }
            if(count == 0)
            {
            PreparedStatement prep=con.prepareStatement("insert into mailer values(?,?,?,?,?,?,?,?)");
           prep.setString(1,fname);
           prep.setString(2,lname);
           prep.setString(3,email);
           prep.setString(4,phone);
           prep.setString(5,gender);
           prep.setString(6,dob);
           prep.setString(7,pass);
           prep.setString(8,filename);
           prep.execute();
           
           RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.include(request, response);
            out.println("<script type='text/javascript' src='http://code.jquery.com/jquery-latest.js'></script>");
    out.println("<script type='text/javascript'>"); 
    out.println("var text = 'Registered Succesfully';");                        
                        out.println("document.getElementById('msg').innerHTML = text;");
                        out.println("$(document).ready( function() {");
        out.println("$('#msg').delay(3000).fadeOut();");
      out.println("});");
                        out.println("</script>");
            }
            else
            {
                
RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
                        rd.include(request, response);
            out.println("<script type='text/javascript' src='http://code.jquery.com/jquery-latest.js'></script>");
    out.println("<script type='text/javascript'>"); 
    out.println("var text = 'User Already Exist';");                        
                        out.println("document.getElementById('msg').innerHTML = text;");
                        out.println("$(document).ready( function() {");
        out.println("$('#msg').delay(3000).fadeOut();");
      out.println("});");
                        out.println("</script>");
                        }
        }
        catch(IOException | ClassNotFoundException | SQLException | ServletException e)
        {
            out.println(e);
        }
    }
}
