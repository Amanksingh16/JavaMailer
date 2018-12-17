<%@ page autoFlush="true" %>
<html>
    <head>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
        <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
   <style>
            .container-fluid{
                margin-top: 12%;
                left:28%;
                padding: 28px;
                height: 200px;
                width: 500px;
                border-radius: 5px;
                border: 1px slateblue;
                background-color: mediumpurple;
            }
            
                        body{
                background-color: antiquewhite;
            }
        </style>
    </head>
    <body>
          <%
session.invalidate();
%>
<div class="container-fluid text-center">
            <h4 class="display-5">Logged Out Successfully</h4>
            <br>
            <i style="font-size: 25px; margin: 0 auto;" class="fa fa-home"></i>
            <h4 class="display-5">Redirecting...</h4>
        </div>

<script type="text/javascript">
  setTimeout(function() {
      document.location = "http://localhost:8080/JavaMailer";
  }, 2000);
        </script>
    </body>
</html>