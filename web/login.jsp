<%@page import="java.sql.SQLException"%>
<%@page import="java.lang.ClassNotFoundException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<html>
    <head>
        <title>Mailer</title>
        <style>
            body{
                background: url("resources/39.jpg");
                width:100%;
        height:100%;
        background-position: center;
    background-repeat: no-repeat;
    margin: 0;
            }
            .container-fluid{
                margin-top: 15%;
                margin-left:28%;
                padding: 40px;
                height: 130px;
                width: 500px;
                border-radius: 5px;
                align-items: center;
                border: 1px slateblue;
                background-color: mediumpurple;
            }
            #myProgress {
                margin: 0 auto;
                border: 2px solid black;
  width: 100%;
  background-color: #ddd;
}

#myBar {
  width: 1%;
  height: 30px;
  background-color: springgreen;
}
        </style>
    </head>
    <body>
        <%
        ServletContext context = request.getServletContext();
        Connection con;
        PreparedStatement ps = null;
        ResultSet rs = null;
        int count = 0;
        String user = request.getParameter("user");
        String pass = request.getParameter("pwd");
        
        try{
            Class.forName(context.getInitParameter("con"));
            con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
            ps=con.prepareStatement("select pass from mailer where email='"+user+"'");
            rs = ps.executeQuery();
        }
        catch(Exception e)
        { 
          out.println(e);
        }
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
                        %>
                        <div class="container-fluid text-center">
            <h1 class="display-5" style="margin: 0 auto;">Loading <b style="color: maroon; font-family: cursive;">M</b>ailer</h1>
                <br>
            <i style="font-size: 25px; margin: 0 auto;" class="fa fa-home"></i>
            <div id="myProgress">
  <div id="myBar"></div>
</div>
        </div>

<script type="text/javascript">
    setTimeout(function() {
      document.location = "http://localhost:8080/JavaMailer/main.jsp";
  }, 1000);
        function codeAddress() {
            var elem = document.getElementById("myBar");   
  var width = 1;
  var id = setInterval(frame, 250);
  function frame() {
    if (width >= 98) {
      clearInterval(id);
    } else {
      width++; 
      elem.style.width = width + '%'; 
    }
  }
  }
        window.onload = codeAddress;
        </script>

                        <%
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

        %>
    </body>
</html>
