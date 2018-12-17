<%@page import="javax.mail.MessagingException"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.activation.DataSource"%>
<%@page import="javax.activation.DataHandler"%>
<%@page import="javax.activation.FileDataSource"%>
<%@page import="javax.mail.internet.MimeBodyPart"%>
<%@page import="javax.mail.internet.MimeMultipart"%>
<%@page import="javax.mail.BodyPart"%>
<%@page import="javax.mail.Multipart"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="java.io.File"%>
<%@page import="javax.mail.PasswordAuthentication"%>
<%@page import="javax.mail.Session"%>
<%@page import="java.util.Properties"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <style>
            .container-fluid
            {
                margin-top:12%;
                padding:28px;
                height: 200px;
                width: 500px;
                border-radius: 5px;
                border: 1px slateblue;
                background-color: darkcyan;
            }
        </style>
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    </head>
    <body>
        <%
        String savepath = "/C:/Users/Aman Singh/Documents/NetBeansProjects/JavaMailer/web/resources";
        String cc="",bcc="",filename="",path="";
        Part part = null;
        final String from = request.getSession().getAttribute("user").toString();
        String mailto = request.getParameter("emailto");
        String subject = request.getParameter("subject");
        String messages = request.getParameter("content");
        
        Properties props = System.getProperties();
props.put("mail.smtp.host", "smtp.gmail.com"); 
props.put("mail.smtp.port", "465"); 
props.put("mail.debug", "true"); 
props.put("mail.smtp.auth", "true"); 
props.put("mail.smtp.starttls.enable","true"); 
props.put("mail.smtp.EnableSSL.enable","true");

props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 

            Session ses = Session.getInstance(props,
          new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication()
            {
                return new PasswordAuthentication(from,request.getSession().getAttribute("gpass").toString());
            }
          });
        
        if(request.getParameter("emailcc")!=null)
        {
            cc = request.getParameter("emailcc");
        }
        if(request.getParameter("emailbcc")!=null)
        {
            bcc = request.getParameter("emailbcc");
        }
        if(request.getPart("attach").getSize()!=0)
        {
            part = request.getPart("attach");
            String content = part.getHeader("content-disposition");
            String[] items = content.split(";");
            filename = items[2].substring(items[2].indexOf("=")+2, items[2].length()-1);
            path = savepath+File.separator+filename;
            File file = new File(savepath);
            if(!file.exists())
            {
                file.mkdirs();
            }
            part.write(path);
        }
               try{
 
           MimeMessage message = new MimeMessage(ses);
           
            message.setSubject(subject);
           message.setFrom(new InternetAddress(from));
           message.setRecipient(Message.RecipientType.TO,new InternetAddress(mailto));
           if(request.getParameter("emailbcc")!=null&&(!request.getParameter("emailbcc").equals("")))
           {
           message.addRecipient(Message.RecipientType.BCC,new InternetAddress(bcc));
           }
           if(request.getParameter("emailcc")!=null&&(!request.getParameter("emailcc").equals("")))
           {
           message.addRecipient(Message.RecipientType.CC,new InternetAddress(cc));
           }
           if(request.getPart("attach").getSize()==0)
           {
           message.setText(messages);
           }
           else
           {
               Multipart multipart = new MimeMultipart();
           BodyPart part1 = new MimeBodyPart();
           BodyPart part2 = new MimeBodyPart();
           part1.setText(messages);
          
           DataSource source = new FileDataSource(path);
           part2.setDataHandler(new DataHandler(source));
           part2.setFileName(filename);
           multipart.addBodyPart(part1);
           multipart.addBodyPart(part2);
           message.setContent(multipart);
           
           }
           Transport.send(message);
        }
        catch(IOException | MessagingException | ServletException e)
        {
            out.println(e);
        }
        %>
        <div class="container-fluid text-center">
            <h4 style="color: green;" class="display-5">Your Mail is Sent</h4>
            <br>
            <i style="margin: 0 auto;" class="fa fa-home"></i>
            <h4 class="display-5">Redirecting to DashBoard...</h4>
        </div>
        <script>
  setTimeout(function() {
      document.location = "http://localhost:8080/JavaMailer/main.jsp";
  }, 1000); // <-- this is the delay in milliseconds
</script>
    </body>
</html>
