<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
</head>

<script type="text/javascript">

    $(function (){

        // 给登录按钮添加单击事件
        $("#loginBtn").click(function (){
            var userName = $.trim($("#userName").val());
            var password = $.trim($("#password").val());
            var isRemPwd =$("#isRemPwd").prop("checked");
            // 表单验证
            if (userName == ""){
                layer.alert("用户名不能为空", {icon: 7});
                return;
            }
            if (password == ""){
                layer.alert("密码不能为空", {icon: 7});
                return;
            }

            $("#msg").text("正在努力验证...");

            // 发送请求
            $.ajax({
                url: "user/login.do",
                data: {
                    userName:userName,
                    password:password,
                    isRemPwd:isRemPwd
                },
                type:"post",
                dataType:"json",
                success:function (data){
                    if (data.code == "200"){
                        // 跳转到主页面
                        window.location.href="user/toMain.do";
                    } else {
                        layer.alert("用户名或密码错误", {icon:5});
                        $("#msg").text("");
                    }
                }
            });

        });

        // 给整个浏览器窗口添加键盘按下事件
        $(window).keydown(function (event){
            // 如果按的是回车键
            if (event.keyCode == 13){
                $("#loginBtn").click();
            }
        });

        var is = $("#isRemPwd").prop("checked");
        if (is){
            $("#loginBtn").click();
        }

        $("#register").click(function (){
            window.location.href="user/register.jsp";
        })
    })
</script>

<body>
<div id="login">
    <div id="top">
        <img src="images/cloud.jpg" /><span>LOGIN</span>
    </div>
    <div id="bottom">
            <form action="user/login.do" class="form-horizontal" role="form">
                <div class="form-group form-group-lg">
                    <div style="width: 350px;">
                        <input class="form-control" id="userName" type="text" value="${cookie.userName.value}" placeholder="用户名">
                    </div>
                    <div style="width: 350px; position: relative;top: 20px;">
                        <input class="form-control" id="password" type="password" value="${cookie.password.value}" placeholder="密码">
                    </div>
                    <div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
                        <label>
                            <c:if test="${not empty cookie.userName and not empty cookie.password}">
                                <input id="isRemPwd" type="checkbox" checked> 十天内免登录
                            </c:if>
                            <c:if test="${empty cookie.userName or empty cookie.password}">
                                <input id="isRemPwd" type="checkbox"> 十天内免登录
                            </c:if>
                        </label>
                        &nbsp;&nbsp;
                        <span id="msg" style="color: red"></span>
                    </div>
                    <button type="button" id="loginBtn" class="btn btn-primary btn-lg btn-block"  style="width: 175px; left:60px; position: relative;top: 50px; ">登录</button>
                   <%-- <button type="button" id="register" class="btn btn-primary btn-lg btn-block"  style="width: 175px; position: relative;left: 200px;">注册</button>--%>
                </div>
            </form>
    </div>

</div>
</body>
</html>
