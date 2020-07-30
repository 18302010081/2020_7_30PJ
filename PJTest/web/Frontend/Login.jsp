<%--
  Created by IntelliJ IDEA.
  User: 魏文婕
  Date: 2020/7/15
  Time: 16:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang='en'>
<head>
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrapValidator.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="loginPage">
    <h1><b>Travel</b><small>share and enjoy!</small></h1>
    <div class="navPart" role="navigation">
        <ul class="nav nav-pills" >
            <li role="presentation" ><a href="../index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li role="presentation" ><a href="Search.jsp"><span class="glyphicon glyphicon-search"></span> Search</a></li>
        </ul>
    </div>
<br><br><br>
    <div class="loginForm">
        <form action="LoginServlet" method="post" id="loginForm">
            <div class="form-group">
                <p>Username: <input type="text" name="username" class="form-control" value="${sessionScope.loginUsername}"> </p>
            </div>
            <div class="form-group">
                <p>Password:  <input type="password" name="password" class="form-control" value="${sessionScope.loginPassword}"></p>
            </div>
            <span style="color: red;">${sessionScope.LoginStatus}</span><br><br>
            <input type="submit" class="btn btn-success" style="font-family: 'Comic Sans MS'" value="Login">

        </form>
    </div>
</div>

</body>
</html>
<script>
    $(function () {
        $('#loginForm').bootstrapValidator({
            // 默认的提示消息
            message: 'This value is not valid',
            // 表单框里右侧的icon
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username:{
                    message: 'Username is not valid',
                    validators:{
                        notEmpty:{
                            message:'Username should not be empty'
                        },
                        stringLength: {  //长度限制
                            min: 4,
                            max: 15,
                            message: 'Invalid Register Username'
                        },
                    }
                },
                password:{
                    message: 'Password is not valid',
                    validators:{
                        notEmpty:{
                            message:'Password should not be empty'
                        },
                        stringLength: {  //长度限制
                            min: 6,
                            max: 12,
                            message: 'Invalid Register Password',
                        },
                    },

                },

            }
        });
    });

</script>
<style>
    body{
        background-color: #FFFFCC;
    }
    .navPart{
        float:right;
    }
    .loginPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .loginForm{
        background: url("../Resources/MyImages/login.jpg");
        padding: 10%;
        margin:2px;
        border-radius: 2px;box-shadow: 0 2px 4px rgba(0, 0, 0, .44), 0 0 6px rgba(0, 0, 0, .44);color: #0c5460;color: black;
    }
    p{
        color: white;
        font-family: "Comic Sans MS";
    }
    input{
        border-radius: 2px;
        color: #0f0f0f;
    }
</style>
