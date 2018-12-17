<%@ page import="java.sql.*"%>  
  
<%  
    ServletContext context = request.getServletContext();
String s=request.getParameter("val");   
try{  
Class.forName(context.getInitParameter("con"));
Connection con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
PreparedStatement ps=con.prepareStatement("select * from mailer where email LIKE '"+s+"%'");  
ResultSet rs=ps.executeQuery();
out.println("<table class='table table-hover text-center' width='90%' style='margin:0 auto;'>");
out.println("<tdark><tr>");
out.println("<th>Names</th>");
out.println("<th>Emails</th></tr></tdark>");
out.println("<tbody>");
while(rs.next()){  
out.print("<tr class='table-success'>"+"<td>"+rs.getString(1)+" "+rs.getString(2)+"</td><td>"+rs.getString(3)+"</td></tr>");  
}
out.println("</tbody></table>");
con.close();  
}catch(Exception e){out.println(e);}    
%>  

