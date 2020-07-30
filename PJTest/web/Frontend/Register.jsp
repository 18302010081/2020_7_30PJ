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
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="../Resources/bootstrap-3.3.7-dist/css/bootstrapValidator.min.css"/>
    <script src="../Resources/bootstrap-3.3.7-dist/js/jquery-3.5.1.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="../Resources/bootstrap-3.3.7-dist/js/bootstrapValidator.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<div class="registerPage">
    <h1><b>Travel</b><small>share and enjoy!</small></h1>
    <div class="navPart" role="navigation">
        <ul class="nav nav-pills" >
            <li role="presentation" ><a href="../index.jsp"><span class="glyphicon glyphicon-home"></span> Home</a></li>
            <li role="presentation" ><a href="Search.jsp"><span class="glyphicon glyphicon-search"></span> Search</a></li>
        </ul>
    </div>
    <br><br><br>
    <div class="registerForm">
        <form action="RegisterServlet" method="post" id="registerForm">
            <span style="color: red;">${sessionScope.RegisterStatus}</span><br>
            <div class="form-group">
                <p>Username: <input type="text" name="username" value="${sessionScope.registerUsername}"
                                    class="form-control" placeholder=" Enter your user name..."></p>
            </div>
            <div class="form-group">
                <p>Password:  <input type="password" name="password" value="${sessionScope.registerPassword}"
                                     class="form-control" placeholder=" Enter your password..."></p>
            </div>
            <div class="form-group">
                <p>Confirm Password:  <input type="password" name="confirmPassword" value="${sessionScope.registerPassword}"
                                    class="form-control" placeholder=" Confirm your password..."></p>
            </div>
            <div class="form-group">
                <p>Email: <input type="email" name="email" value="${sessionScope.registerEmail}"
                                 class="form-control" placeholder=" Enter your Email..."> </p>
            </div>
            <%--            <p>Captcha:  <input name="captcha" required></p><br>--%>

            <div style="padding-left: 10%;padding-top: 5%">
                <button type="submit" class="btn btn-success"
                        style="font-family: 'Comic Sans MS'">Register</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
<script>
    $(function () {
        $('#registerForm').bootstrapValidator({
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
                                        message: 'The length of username must be 4-15'
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
                            message: 'The length of password must be 6-12',
                        },
                    },

                },
                confirmPassword:{
                    message: 'Invalid input ',
                    validators:{
                        notEmpty:{
                            message:'Confirm password should not be empty'
                        },
                        identical: {  //比较是否相同
                            field: 'password',  //需要进行比较的input name值
                            message: 'The two password inputs are inconsistent'
                        },
                    },

                },
                email:{
                    message: 'Email is not valid',
                    validators:{
                        notEmpty:{
                            message:'email should not be empty'
                        },
                        emailAddress: {
                            message: 'Please enter a valid email address!'
                        }
                    },

                },


                // username: {
                //     message: '用户名验证失败',
                //     validators: {
                //         notEmpty: {
                //             message: '用户名不能为空'
                //         },
                //         stringLength: {  //长度限制
                //             min: 6,
                //             max: 18,
                //             message: '用户名长度必须在6到18位之间'
                //         },
                //         regexp: { //正则表达式
                //             regexp: /^[a-zA-Z0-9_]+$/,
                //             message: '用户名只能包含大写、小写、数字和下划线'
                //         },
                //         different: {  //比较
                //             field: 'username', //需要进行比较的input name值
                //             message: '密码不能与用户名相同'
                //         },
                //         identical: {  //比较是否相同
                //             field: 'password',  //需要进行比较的input name值
                //             message: '两次密码不一致'
                //         },
                //         remote: { // ajax校验，获得一个json数据（{'valid': true or false}）
                //             url: 'user.php',       //验证地址
                //             message: '用户已存在',   //提示信息
                //             type: 'POST',          //请求方式
                //             data: function(validator){  //自定义提交数据，默认为当前input name值
                //                 return {
                //                     act: 'is_registered',
                //                     username: $("input[name='username']").val()
                //                 };
                //             }
                //         }
                //     }
                // },
                // email: {
                //     validators: {
                //         notEmpty: {
                //             message: '邮箱地址不能为空'
                //         },
                //         emailAddress: {
                //             message: '邮箱地址格式有误'
                //         }
                //     }
                // }
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
    .registerPage{
        padding-left: 10%;
        padding-right: 10%;
        padding-top: 2%;
    }
    .registerForm{
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
        color: #0f0f0f;
        border-radius: 2px;
    }

</style>
