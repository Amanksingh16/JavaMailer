<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.mail.Multipart"%>
<%@page import="javax.mail.Flags"%>
<%@page import="javax.mail.AuthenticationFailedException"%>
<%@page import="javax.mail.MessagingException"%>
<%@page import="javax.mail.NoSuchProviderException"%>
<%@page import="javax.mail.Message.RecipientType"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.Folder"%>
<%@page import="javax.mail.Store"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Message[] messages = null;
    String msgfrom="",content="",date="",subject="";
    Multipart part = null;
    int mail=0;
    String user="",path="";
    ServletContext context = request.getServletContext();
             Connection con;
     if(request.getParameter("mail")==null)
     {
         response.sendRedirect("http://localhost:8080/JavaMailer/main.jsp");
     }        
     else
     {
         mail = Integer.parseInt(request.getParameter("mail"));
     }
     if(session.getAttribute("user")==null)
     {
         response.sendRedirect("http://localhost:8080/JavaMailer");
     }
     else
     {
                  String protocol = "imap";
        String host = "imap.gmail.com";
        String port = "993";
         try{
             
            Class.forName(context.getInitParameter("con"));
            con = DriverManager.getConnection(context.getInitParameter("con1"),"system","system");
            PreparedStatement ps = con.prepareStatement("select * from mailer where email='"+session.getAttribute("user")+"'");
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
                user = rs.getString(1)+" "+rs.getString(2);
                path = rs.getString(8);
            }
         }
         catch(ClassNotFoundException e)
         {
             out.println(e);
         }
     
     Properties properties = getServerProperties(protocol,host,port);
        Session ses = Session.getDefaultInstance(properties);
                
        try {
            // connects to the message store
            Store store = ses.getStore(protocol);
            store.connect(host,session.getAttribute("user").toString(),session.getAttribute("gpass").toString());
            // opens the inbox folder
            Folder folderInbox = store.getFolder("INBOX");
            folderInbox.open(Folder.READ_WRITE);
            
            messages = folderInbox.getMessages();
            
                Message msg = messages[mail];
                Address[] fromAddress = msg.getFrom();
                msgfrom = fromAddress[0].toString();
                content = msg.getContent().toString();                    
                subject = msg.getSubject();
                date = msg.getSentDate().toString();
                
                
    if (msg.isMimeType("text/plain")) {
        content = msg.getContent().toString();
    } else if (msg.isMimeType("multipart/*")) {
        part = (MimeMultipart) msg.getContent();
        content = getTextFromMimeMultipart(part);
    }
    
    if(request.getParameter("delete")!=null)
          {
     int s = Integer.parseInt(request.getParameter("delete"));
     messages[messages.length-s].setFlag(Flags.Flag.DELETED, true);
%><script>
    alert("Your Mail is Deleted");
</script>
<%
    response.sendRedirect("http://localhost:8080/JavaMailer/main.jsp");
          }   
            folderInbox.close(false);
            store.close();
        }
        catch(Exception e)
        {
                       session.invalidate();
                       response.sendRedirect("http://localhost:8080/JavaMailer/");
        }
}
%>
<%!
    
    private String getTextFromMimeMultipart(
        Multipart mimeMultipart)  throws MessagingException, IOException{
    String result = "";
    int count = mimeMultipart.getCount();
    for (int i = 0; i < count; i++) {
        BodyPart bodyPart = mimeMultipart.getBodyPart(i);
        if (bodyPart.isMimeType("text/plain")) {
            result = result + "\n" + bodyPart.getContent();
            break;
        } else if (bodyPart.isMimeType("text/html")) {
            String html = (String) bodyPart.getContent();
            result = result + "\n" + org.jsoup.Jsoup.parse(html).text();
        } else if (bodyPart.getContent() instanceof MimeMultipart){
            result = result + getTextFromMimeMultipart((MimeMultipart)bodyPart.getContent());
        }
    }
    return result;
}

private Properties getServerProperties(String protocol, String host,
            String port) {
        Properties properties = new Properties();
 
        // server setting
        properties.put(String.format("mail.%s.host", protocol), host);
        properties.put(String.format("mail.%s.port", protocol), port);
 
        // SSL setting
        properties.setProperty(
                String.format("mail.%s.socketFactory.class", protocol),
                "javax.net.ssl.SSLSocketFactory");
        properties.setProperty(
                String.format("mail.%s.socketFactory.fallback", protocol),
                "false");
        properties.setProperty(
                String.format("mail.%s.socketFactory.port", protocol),
                String.valueOf(port));
 
        return properties;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mailer</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<style>
    ul li a:hover
    {
            color: brown;
    }
    .right
    {
        margin-right:auto;
        float: right;
        width: 200px;
        height: 60px;
    }
    
    .list-group-item{
        background-color: cadetblue;
    }
    
    .list-group a{
        font-family: cursive;
        color: black;
        font-weight: bold;
    }
    
    body{
        background-color: beige;
    }
    
    .table-borderless tbody tr th
    {
        color: darkblue;
      
    }
        .table-borderless tbody tr td
    {
        font-weight: bold;
        
    }
    .container-fluid{
        padding:50px;
    }
</style>
    </head>
    <body>
        <nav class="navbar navbar-fixed-top navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="#"><b style="color: red; font-family: cursive;">M</b>ailer</a>
  
 <ul class="navbar-nav">
    <li class="nav-item">
      <a style="color: tomato; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link" href="#">Home</a>
    </li>
    <li class="nav-item">
      <a style="color:white; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link" href="#">About</a>
    </li>
    <li class="nav-item">
      <a style="color:white; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link" href="#">Contact</a>
    </li>
  </ul>

  
 <ul class="navbar-nav ml-auto">
     <a href="#" onclick="window.location.reload();" style="margin-right: 2px; border-radius:40%; padding:10px; font-family: cursive; font-weight: bold;" class="btn btn-secondary"><i class="fa fa-repeat"></i></a>
    <li class="nav-item dropdown">
        <a style="color: tomato; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=user%></a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="logout.jsp">Logout <i class="fa fa-share-square-o"></i></a>
        </div>
      </li>
      <li class="nav-item">
          <img src="resources/<%=path%>" alt="mailer profile" style="margin:0 auto;" height="38px" width="38px" class="img-responsive"> 
        
      </li>
  </ul>
</nav>
          <div class="container-fluid">
              <div class="row">
                  <div class="col-md-7">
              <h3 class="display-5"><%=subject%></h3>
                  </div>
                  <div class="col-md-1"></div>
                  <div class="col-md-4"><h5 class="display-5">Date : <%=date%></h5></div>
              </div>
              <br>
              <div class="row">
                  <div class="col-md-6"><h5 class="display-5" style="color: darkslateblue;">From : <%=msgfrom%></h5>
              </div>
                  <div class="col-md-3"></div>
                  <div class="col-md-3"><a href="inbox.jsp?mail=<%=mail%>" class="btn btn-danger" style="padding:10px;">Delete This Mail</a></div>
              </div>
              <br>
              <h6 class="display-5"><%=content%></h6>
          </div>
      
      
      <div class="modal video-modal fade" id="modal2">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Delete Mail</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: activeborder; padding: 10px;">
          <b style="color: darkred; margin: 15px;">The Selected Mail shall be permanently deleted from your Gmail Account</b>
          <br>
          <form method="get"> 
          <input type="number" style="margin: 0 auto; border:1px solid black; border-radius: 15px; padding: 20px; width: 350px;" class="form-control" placeholder="Serial ID of Mail" name="deletemail" required>
              <input type="submit" value="Delete this Mail" style="margin:10px; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" class="btn btn-success">
          </form>
      </div>

    </div>
  </div>
</div>
           <script>
                function deleted()
            {
                      <%
                          request.setAttribute("delete",mail);
                      %>
                              window.location.reload();
            }
        
        </script>
    </body>
</html>