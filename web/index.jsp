<%
if(session.getAttribute("user")!=null)
{
    response.sendRedirect("http://localhost:8080/JavaMailer/main.jsp");
}
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mailer</title>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
<style>
    #myCarousel img
    {
        width:100%;
        height:100%;
        background-position: center;
    background-repeat: no-repeat;
    margin: 0;
    }
    .forms
    {
  height: 260px;
  width: 600px;
  background-color: threedlightshadow;
  display: flex;
  border-radius: 15px;
  border: 2px black;
  align-items: center;
  position: absolute;
  top: 30%;
  left: 28%;
    }
    
    .row
    {
     margin:20px;   
    }
    
    a{
        padding:20px; 
        border-radius: 5px; 
        color: white; 
        background-color: darkslateblue;
    }
    
    a:hover
    {
        border-radius: 8px;
        background-color: #1E90FF;
        color: black; 
        text-decoration: none;
    }
    
    form{
        margin: 0 auto;
    }
    
    .form-control{
        width: 220px;
        border-radius: 5px;
        border: 1px solid palevioletred;
        padding: 20px;
    }
        
</style>
    </head>
    <body>
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
  <div class="carousel-inner">
    <div class="carousel-item active">
      <img src="resources/image1.jpg" class="img-responsive">
    </div>
    <div class="carousel-item">
      <img src="resources/image2.jpg" class="img-responsive">
    </div>
    <div class="carousel-item">
      <img src="resources/image3.jpg" class="img-responsive">
    </div>
  </div>
            <div class="forms">
            <div class="container-fluid text-center">
                <div class="row">
                <h1 class="display-2" style="margin: 0 auto;"><b style="color: maroon; font-family: cursive;">M</b>ailer</h1>
                </div>
                <div class="row" style="margin:40px;">
                    <div class="col-md-6">
                        <a href="#" data-toggle="modal" data-target="#myModal1">New User?</a>
                    </div>
                    <div class="col-md-6">
                        <a href="#" data-toggle="modal" data-target="#myModal2">Login Here</a>
                    </div>
                </div>
                <p id="msg" class="display-5" style="color: darkblue; font-size: 18px; font-weight: bold;"></p>                
            </div>
            </div>
            
        </div>
        
        <div class="modal video-modal fade" id="myModal1">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">

      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Mailer Registration</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: window;">
          <form class="form" name="myform1" onsubmit="return validation()" action="register" method="post" enctype="multipart/form-data">
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Name 
                  </div>
                  <div class="col-md-4">
                      <input type="text" placeholder="Enter First Name" name="fname" class="form-control" id="fname" required></div>                                   
                      <div class="col-md-5">
                      <input type="text" placeholder="Enter Last Name" name="lname" class="form-control" id="lname" required>
                  </div>
                  <div class="col-md-1">
                      </div>
              </div>
              
<div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Email 
                  </div>
                  <div class="col-md-10">
                      <input type="email" placeholder="Enter Email" name="mail" style="width: 300px;" class="form-control" id="mail" required></div>                                   
              </div>
              
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Phone
                  </div>
                  <div class="col-md-10">
                      <input type="number" placeholder="Enter Phone Number" name="phone" style="width: 250px;" class="form-control" id="phone" required></div>                                   
              </div>
              
              
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Gender 
                  </div>
                  <div class="col-md-3">
                  <select name="gender" style="width:150px; padding:0;" class="form-control">
       <option> ---Select---</option>
   <option  value="Male">Male </option>
   <option  value="Female">Female </option>
   </select>
                  </div>
                  <div class="col-md-3" style="font-family: cursive; font-size: 20px;">
                      Date of Birth
                  </div>
                   <div class="col-md-4">
                  <input type="date" name="dob" class="form-control" id="dob" required>
              </div>            
              </div>
              <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Password 
                  </div>
                  <div class="col-md-4">
                      <input type="password" placeholder="Enter Password" name="pass" class="form-control" id="pass" required></div>                                   
                      <div class="col-md-5">
                      <input type="password" placeholder="Confirm Password" name="cpass" class="form-control" id="cpass" required>
                  </div>
                  <div class="col-md-1">
                      </div>
              </div>
              
                            <div class="row">
                  <div class="col-md-2" style="font-family: cursive; font-size: 20px;">
                      Profile 
                  </div>
                  <div class="col-md-10">
                      <input type="file" name="profile" class="form-control" style="padding:3px;" id="profile" required>
                      </div>
              </div>
                      <div class="row" style="margin-top: 30px;">
                  <div class="col-md-2"> 
                  </div>                          
                  <div class="col-md-4">
                      <input type="submit" class="btn btn-success" style="border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="smbt" value="Register">
                      </div>                          
                  <div class="col-md-4">
                      <input type="reset" class="btn btn-danger" style="border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="rst" value="Reset">
                      </div>
                                         <div class="col-md-2"> 
                  </div>    
              </div>
          </form>
          <br>
      </div>

    </div>
  </div>
</div>
                <div class="modal video-modal fade" id="myModal2">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
          <h3 style="color: darkblue; font-family: cursive;" class="modal-title">Mailer Login</h3>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
      </div>

      <div class="modal-body text-center" style="background-color: activeborder;">
          <form class="form text-center" action="login.jsp" method="post">
              <br>
              <div class="form-group">
              <input type="text" style="margin:0 auto; border:1px solid black; border-radius: 15px; padding: 25px; width: 350px;" class="form-control" placeholder="Enter Username" name="user" id="user" required>
              </div>
              <div class="form-group">
              <input type="password" style="margin:0 auto; border:1px solid black; border-radius: 15px; padding: 25px; width: 350px;" class="form-control" placeholder="Enter Password" name="pwd" id="pwd" required>
              </div>
              <a href="#" data-toggle="collapse" data-target="#demo" style="margin: 15px; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 40px; padding-right: 40px;" class="btn btn-info">Expand for Login</a>
              <div id="demo" class="collapse">
              <br>
              <div class="form-group">
              <input type="password" style="margin:0 auto; border:1px solid black; border-radius: 15px; padding: 25px; width: 350px;" class="form-control" placeholder="Enter Gmail Password" name="pass" id="pass" required>
              </div>
              <div class="form-group">
              <input type="submit" style="margin: 15px; border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" class="btn btn-success" value="Verify and Login">
              <input type="reset" class="btn btn-danger" style="border-radius:10px; padding-top: 15px; padding-bottom: 15px; padding-left: 45px; padding-right: 45px;" id="rst" value="Reset">
                      
              </div>
              </div>
              
          </form>
         
      </div>

    </div>
  </div>
</div>
      
            
        
        <script>
                function validation()
            {
                                var a = document.forms["myform1"]["phone"].value;
        if(a.length !== 10)
                {
                alert("Phone Number is not valid");
                    return false;
                }
                if(myform1.pass.value !== myform1.cpass.value)
                {
                    alert("Password does not match");
                    return false;               
            }
            else
            {
                if(myform1.pass.value.length <== 8)
                    {
                        alert("Password must not be less than 8 characters");
                    return false;
                    }
            }
            }
        
        </script>
    </body>
</html>
