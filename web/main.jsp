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
    int i = 0,j=0,k=0,from=0,to=0,from1=0,to1=0,from2=0,to2=0;
    Message[] messages = null;
    Message[] messages1 = null;
    Message[] messages2 = null;
    String[] msgfrom = new String[25000];
    String[] subject = new String[25000];
    String[] date = new String[25000];
    String[] msgto = new String[500];
    String[] subject1 = new String[500];
    String[] date1 = new String[500];    
    String[] msgfrom2 = new String[100];
    String[] subject2 = new String[100];
    String[] date2 = new String[100];
    String user="",last="",path="",gender="",email="",phone="",dob="";
    ServletContext context = request.getServletContext();
             Connection con;
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
                user = rs.getString(1);
                last = rs.getString(2);
                path = rs.getString(8);
                gender = rs.getString(5);
                phone = rs.getString(4);
                email = rs.getString(3);
                dob = rs.getString(6);
                
            }
         }
         catch(ClassNotFoundException e)
         {
             out.println(e);
         }
         
            
         Properties properties = getServerProperties(protocol,host,port);
        Session ses = Session.getDefaultInstance(properties);
            
        from = Integer.parseInt(session.getAttribute("from").toString());
            to = Integer.parseInt(session.getAttribute("to").toString());
            from1 = Integer.parseInt(session.getAttribute("from1").toString());
            to1 = Integer.parseInt(session.getAttribute("to1").toString());
                        from2 = Integer.parseInt(session.getAttribute("from2").toString());
            to2 = Integer.parseInt(session.getAttribute("to2").toString());
            
        try {
            // connects to the message store
            Store store = ses.getStore(protocol);
            store.connect(host,session.getAttribute("user").toString(),session.getAttribute("gpass").toString());
            // opens the inbox folder
            Folder folderInbox = store.getFolder("INBOX");
            Folder foldersent = store.getFolder("[Gmail]/Sent Mail");
            Folder foldertrash = store.getFolder("[Gmail]/Trash");
            folderInbox.open(Folder.READ_WRITE);
            foldersent.open(Folder.READ_ONLY);
            foldertrash.open(Folder.READ_ONLY);
            
            messages = folderInbox.getMessages();
            messages1 = foldersent.getMessages();
            messages2 = foldertrash.getMessages();
            
             for (i = messages.length-from; i >= messages.length-to; i--) 
             {   
                Message msg = messages[i];
                Address[] fromAddress = msg.getFrom();
                msgfrom[i] = fromAddress[0].toString();
                subject[i] = msg.getSubject();
                date[i] = msg.getSentDate().toString();
             }
             
             for (j = messages1.length-from1; j >= messages1.length-to1; j--) 
             {   
                if(j<0)
                {
                    break;
                }
                 Message msg = messages1[j];
                Address[] fromAddress = msg.getAllRecipients();
                msgto[j] = fromAddress[0].toString();
                subject1[j] = msg.getSubject();
                date1[j] = msg.getSentDate().toString();
                
             }
             if(messages2.length!=0)
             {
                              for (k = messages2.length-from2; k >= messages2.length-to2; k--) 
             {   
                Message msg = messages2[k];
                Address[] fromAddress = msg.getAllRecipients();
                msgto[k] = fromAddress[0].toString();
                subject1[k] = msg.getSubject();
                date1[k] = msg.getSentDate().toString();
             }   
             }
             
            folderInbox.close(false);
            foldersent.close(false);
            foldertrash.close(false);
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
        <link rel="icon" type="image/ico" href="resources/mail.png" />
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
</style>
    </head>
    <body>
        <nav class="navbar navbar-fixed-top navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="#"><b style="color: red; font-family: cursive;">M</b>ailer</a>
  
 <ul class="navbar-nav">
    <li class="nav-item">
      <a style="color: tomato; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link" href="main.jsp">Home</a>
    </li>
    <li class="nav-item">
      <a style="color:white; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link" href="#">About</a>
    </li>
  </ul>

  
 <ul class="navbar-nav ml-auto">
     <a href="#" onclick="window.location.reload();" style="margin-right: 2px; border-radius:40%; padding:10px; font-family: cursive; font-weight: bold;" class="btn btn-secondary"><i class="fa fa-repeat"></i></a>
    <li class="nav-item dropdown">
        <a style="color: tomato; margin-left: 20px; font-weight: bold; font-family: cursive;" class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><%=user+" "+last%></a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
          <a class="dropdown-item" href="logout.jsp">Logout <i class="fa fa-share-square-o"></i></a>
        </div>
      </li>
      <li class="nav-item">
          <img src="resources/<%=path%>" alt="mailer profile" style="margin:0 auto;" height="38px" width="38px" class="img-responsive"> 
        
      </li>
  </ul>
  
 
</nav>
        
            <div class="row">
                <div class="col-md-3 text-center">
      <ul class="list-group">
          <a href="#" style="text-decoration: none;" data-target="#email" data-toggle="modal"><li class="list-group-item" style="margin-left: 12px; margin-top: 10px; background-color: darkred; color: gold; font-family: cursive; font-weight: bold; border:0;">Compose a new mail <i style="margin:5px;" class="fa fa-check-square-o"></i></li></a>
</ul>
                    <form name="vinform" style="margin: 0 auto;">
     <input type="text" name="t1" class="form-control" style="border: 5px solid palevioletred; margin-left: 12px; margin-top: 10px; margin-bottom: 5px; padding: 25px; width:305px;" onkeyup="sendInfo()" placeholder="Search Users">
  </form>
                    <div class="list-group" id="list-tab" role="tablist" style="margin-left: 12px; border: 5px solid darkslateblue; border-radius: 7px;">
       <a style="color: springgreen; border-bottom: 5px solid darkslateblue; font-size: 17px; font-family: cursive; padding: 15px;" class="list-group-item list-group-item-action" id="list-search-list" data-toggle="list" href="#list-search" role="tab"><i style="margin:5px;" class="fa fa-search"></i>  Search</a>
       <a style="padding: 17px; border-bottom: 5px solid darkslateblue;" class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home"><i style="margin:5px;" class="fa fa-inbox"></i>  Inbox</a>
      <a style="padding: 17px; border-bottom: 5px solid darkslateblue;" class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile"><i style="margin:5px;" class="fa fa-user"></i>  Profile</a>
      <a style="padding: 17px; border-bottom: 5px solid darkslateblue;" class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages"><i style="margin:5px;" class="fa fa-share-square-o"></i>  Sent Mails</a>
      <a style="padding: 17px;" class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings"><i style="margin:5px;" class="fa fa-trash"></i>  Trash</a>
    </div>      
  </div>
                
                <div class="col-md-9" style="background-color: beige; border-left: 3px solid darkgray; ">
      <p id="msg1" class="display-5" style="color: darkblue; font-size: 18px; font-weight: bold;"></p>
      <p id="send" class="display-5" style="margin:10px; color: darkblue; font-size: 18px; font-weight: bold;"></p>
    <div class="tab-content" id="nav-tabContent">
        <div class="tab-pane fade" id="list-search" role="tabpanel" aria-labelledby="list-search-list">
            <div class="container-fluid">
              <h3 class="display-4 text-center" style="margin: 15px;">Search Results</h3>
              <table class="table table-hover" style="margin: 0 auto;">
                  <tbody>
                      <tr>
                  <td id="results"></td>
                      </tr>
                  </tbody>
              </table>
            </div>
        </div>
      <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
          <table class="table table-hover" style="width:95%; margin:0 auto;">
              <thead class="thead-dark" id="msgs">
      <tr>
          <th style="width:60px;">Serial</th>
          <th>From</th>
          <th>Subject</th>
        <th style="width:200px;">Date</th>
      </tr>
    </thead>
    <tbody>
              <%
                  try{
                  int a = messages.length-from;
      while(a>i)
      {%>
                  <tr>
                      <td style="font-weight: bold;"><%=from%></td>
            <td style="font-weight: bold;"><%=msgfrom[a]%></td>
            <td style="font-weight: bold;"><a style="text-decoration: none;" href="inbox.jsp?mail=<%=a%>"><%=subject[a]%></a></td>
            <td style="font-weight: bold;"><%=date[a].substring(0,10)+" "+date[a].substring(23,28)%></td>
        </tr><%  
            from++;
           a--;     
           }
}
catch(Exception e)
{
out.println(e+"hello");}
      %>
             
    </tbody>
          </table>
      <br>
      <div class="row" style="margin: 10px;">
          <div class="col-md-4"></div>
          <div class="col-md-3">
              <a href="previous?page=previous" name="previous" value="previous" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;"><i style="margin:5px;" class="fa fa-chevron-left"></i>Previous</a>
          </div>
          <div class="col-md-3">
              <a href="next?page=next" name="next" value="next" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;">Next<i style="margin:5px;" class="fa fa-chevron-right"></i></a>
          </div>
      </div>
      </div>
      <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
          <div class="container-fluid">
              <h3 class="display-4 text-center" style="margin: 15px;">User Profile</h3>
              <div class="row">
                  <div class="col-md-3" style="padding: 25px;">
                      <img src="resources/<%=path%>" width="250px" height="360px" style="border-radius:10px; margin:10px;">
                  </div>
                  <div class="col-md-1"></div>
                  <div class="col-md-8" style="padding: 25px;">
                      <table class="table table-borderless" style="margin: 10px;">
                          <tbody>
                              <%try{%>
                              <tr>
                                  <th>Name</th>
                                  <td><%=user%></td>
                              </tr>
                              <tr>
                                  <th>Email ID</th>
                                  <td><%=email%></td>
                              </tr>
                              <tr>
                                  <th>Phone</th>
                                  <td><%=phone%></td>
                              </tr>
                               <tr>
                                  <th>Date of Birth</th>
                                  <td><%=dob%></td>
                              </tr>
                              <tr>
                                  <th>Gender</th>
                                  <td><%=gender%></td>
                              </tr>
                              <tr>
                                  <th>Inbox Mails</th>
                                  <td><%=messages.length%></td>
                              </tr>
                                                            <tr>
                                  <th>Sent Mails</th>
                                  <td><%=messages1.length%></td>
                              </tr>
                              <%}catch(Exception e)
{
      out.println(e);
}%>
                          </tbody>
                      </table>
                              <br><br>
                              <div class="row">
                                  <div class="col-md-6">
                              <a href="#" data-toggle="modal" data-target="#edit" class="btn btn-success" style="margin: 0 auto; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="smbt">Edit Profile</a>
                                  </div>
                              <div class="col-md-6">
                              <a href="#" data-toggle="modal" data-target="#dlt" class="btn btn-danger" style="margin: 0 auto; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="smbt">Delete Account</a>
                              </div>
                              </div>
                  </div>
              </div>
          </div>
      </div>
      <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
            <table class="table table-bordered" style="width:95%; margin:0 auto;">
              <thead class="thead-dark" id="msgs">
      <tr>
          <th style="width:60px;">Serial</th>
          <th>To</th>
          <th>Subject</th>
        <th style="width:200px;">Date</th>
      </tr>
    </thead>
    <tbody>
              <%
                  try{
                  int b = messages1.length-from1;
                  
      while(b>j)
      {%>
                  <tr>
            <td style="font-weight: bold;"><%=from1%></td>          
            <td style="font-weight: bold;"><%=msgto[b]%></td>
            <td style="font-weight: bold;"><%=subject1[b]%></td>
            <td style="font-weight: bold;"><%=date1[b].substring(0,10)+" "+date1[b].substring(23,28)%></td>
        </tr><%   
            from1++;
           b--;     
           }
}
catch(Exception e)
{
out.println(e+"hello");}
      %>
             
    </tbody>
          </table>
<div class="row" style="margin: 10px;">
    <div class="col-md-4"></div>
          <div class="col-md-3">
              <a href="previous?page=previous1" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;"><i style="margin:5px;" class="fa fa-chevron-left"></i>Previous</a>
          </div>
          <div class="col-md-3">
              <a href="next?page=next1" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;">Next<i style="margin:5px;" class="fa fa-chevron-right"></i></a>
          </div>
      </div>
      
      </div>
      <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">
          <%
              try{
          if(messages2.length!=0)
          {
          %>
          <table class="table table-bordered" style="width:95%; margin:0 auto;">
              <thead class="thead-dark" id="msgs">
      <tr>
          <th style="width:60px;">Serial</th>
          <th>From/to</th>
          <th>Subject</th>
        <th style="width:200px;">Date</th>
      </tr>
    </thead>
    <tbody>
              <%
                  int c = messages2.length-from2;
                  
      while(c>k)
      {%>
                  <tr>
            <td style="font-weight: bold;"><%=from2%></td>          
            <td style="font-weight: bold;"><%=msgfrom2[c]%></td>
            <td style="font-weight: bold;"><%=subject2[c]%></td>
            <td style="font-weight: bold;"><%=date2[c].substring(0,10)+" "+date2[c].substring(23,28)%></td>
        </tr><%   
            from2++;
           c--;     
           }
      %>
             
    </tbody>
          </table>
<div class="row" style="margin: 10px;">
    <div class="col-md-4"></div>
          <div class="col-md-3">
              <a href="previous?page=previous2" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;"><i style="margin:5px;" class="fa fa-chevron-left"></i>Previous</a>
          </div>
          <div class="col-md-3">
              <a href="next?page=next2" class="btn btn-success" style="font-weight: bold; padding:15px; margin: 0 auto; width:180px;">Next<i style="margin:5px;" class="fa fa-chevron-right"></i></a>
          </div>
      </div>
          <%
              }
          else
{
    out.println("<p class='text-center'>There are no mails in the trash</p>");
}
}
catch(NullPointerException e)
{
       out.println(e);
}
          %>
      </div>
      
    </div>
  </div>
</div>

                                <div class="modal video-modal fade" id="edit">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Mailer Login</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: activeborder;">
          <form class="form" action="update" method="post" enctype="multipart/form-data">
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Name 
                  </div>
                  <div class="col-md-4">
                      <input type="text" placeholder="Enter First Name" name="fname" class="form-control" id="fname" value="<%=user%>" required></div>                                   
                      <div class="col-md-5">
                      <input type="text" placeholder="Enter Last Name" name="lname" class="form-control" value="<%=last%>" id="lname" required>
                  </div>
                  <div class="col-md-1">
                      </div>
              </div>
              
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Phone
                  </div>
                  <div class="col-md-10">
                      <input type="number" value="<%=phone%>" placeholder="Enter Phone Number" name="phone" style="width: 250px;" class="form-control" id="phone" required></div>                                   
              </div>
              
              
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Gender 
                  </div>
                  <div class="col-md-3">
                  <select name="gender" value="<%=gender%>" style="width:150px; padding:0;" class="form-control">
       <option> ---Select---</option>
   <option  value="Male">Male </option>
   <option  value="Female">Female </option>
   </select>
                  </div>
                  <div class="col-md-3" style="font-family: cursive; font-size: 20px;">
                      Date of Birth
                  </div>
                   <div class="col-md-4">
                  <input type="date" name="dob" value="<%=dob%>" class="form-control" id="dob" required>
              </div>            
              </div>
              
                            <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Profile 
                  </div>
                  <div class="col-md-10">
                      <input type="file" name="profile" value="<%=path%>" class="form-control" style="padding:3px;" id="profile" required>
                      </div>
              </div>
                      <div class="row" style="margin-top: 30px;">
                  <div class="col-md-2"> 
                  </div>                          
                  <div class="col-md-4">
                      <input type="submit" class="btn btn-success" style="border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="smbt" value="Update">
                      </div>                          
                  <div class="col-md-4">
                      <input type="reset" class="btn btn-danger" style="border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="rst" value="Reset">
                      </div>
                                         <div class="col-md-2"> 
                  </div>    
              </div>
          </form>
          
      </div>
    </div>
  </div>
</div>
                      <div class="modal video-modal fade" id="dlt">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Mailer Login</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: activeborder;">
          <form class="form text-center" action="update" method="post">
                   Are You Sure You want to Permanently Delete this Account?
                   <br>
                   <input type="hidden" value="dltacc" name="dltac">
                   <input type="submit" class="btn btn-danger" value="Yes, Delete">
          </form>
      </div>
    </div>
  </div>
</div>
      
                          <div class="modal video-modal fade" id="email">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Mailer Login</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: activeborder;">
          <form class="form text-center" action="send.jsp" method="post" enctype="multipart/form-data">
              <br>
              <div class="row">
                  <div class="col-md-2" style="margin-top:15px;">
                <b style="font-size: 15px; font-family: cursive;">Email To</b>
                  </div>
                  <div class="col-md-7">    
              <input type="text" style="margin:10px; border:1px solid black; border-radius: 15px; padding: 20px; width: 400px;" class="form-control" placeholder="Enter Reciever's Email" name="emailto" id="emailto" required>
                            <div id="demo" class="collapse">
              <input type="text" style="margin:10px; border:1px solid black; border-radius: 15px; padding: 20px; width: 400px;" class="form-control" placeholder="Enter CC" name="emailcc" id="emailcc">
              </div>
              <div id="demo1" class="collapse">
              <input type="text" style="margin:10px; border:1px solid black; border-radius: 15px; padding: 20px; width: 400px;" class="form-control" placeholder="Enter BCC" name="emailbcc" id="emailbcc">
              </div>
                  </div>
                  <div class="col-md-1">
              <a href="#" data-toggle="collapse" data-target="#demo" style="margin:10px; border-radius:10px; padding:10px;" class="btn btn-info">CC</a>
                  </div>
                  <div class="col-md-1">
              <a href="#" data-toggle="collapse" data-target="#demo1" style="margin:10px; border-radius:10px; padding:10px;" class="btn btn-info">BCC</a>
                  </div>
                  <div class="col-md-1"></div>
              </div>
              <div class="row">
                <div class="col-md-2" style="margin-top:15px;">
                <b style="font-family: cursive; font-size: 15px;">Subject</b> 
                </div>
                  <div class="col-md-7">    
              <input type="text" style="margin:10px; border:1px solid black; border-radius: 15px; padding: 20px; width: 400px;" class="form-control" placeholder="Enter Subject" name="subject" id="subject" required>
              </div>
                  <div class="col-md-3"></div>
              </div>
                            <div class="row">
                <div class="col-md-2" style="margin-top:15px;">
                    <b style="font-size: 15px; font-family: cursive;">Message</b>
                  </div>
                  <div class="col-md-7">    
                      <textarea class="form-control" rows="5" style="margin:10px; border:1px solid black; border-radius: 15px; width: 400px;" name="content" required></textarea></div>
                  <div class="col-md-3"></div>
              </div>
                            <div class="row">
                <div class="col-md-2" style="margin-top:15px;">
                    <b style="font-size: 15px; font-family: cursive;">Attachment</b>
                  </div>
                  <div class="col-md-7">    
                      <input type="file" class="form-control" name="attach" style="margin:10px; padding:3px;">
                  </div>
                      <div class="col-md-3"></div>
              </div>
                            <div class="row">
                <div class="col-md-2">                    
                  </div>
                  <div class="col-md-4">    
                      <input type="submit" style="margin:10px; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" class="btn btn-success" value="Send Mail">
                  </div>
                      <div class="col-md-4">
                          <input type="reset" class="btn btn-danger" style="margin:10px; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 40px; padding-right: 40px;" id="rst" value="Reset">
                      </div>
                              <div class="col-md-2"></div>
                            </div>
                            </form>
      </div>
    </div>
  </div>
</div>
      
<script>  
var request;  
function sendInfo()  
{  
var v=document.vinform.t1.value;  
var url="search.jsp?val="+v;  
  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function getInfo(){  
if(request.readyState==4){  
var val=request.responseText;  
document.getElementById('results').innerHTML=val;  
}  
}  

function activaTab(tab){
  $('.nav-tabs a[href="#' + tab + '"]').tab('show');
};
</script> 
    </body>
</html>