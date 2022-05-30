<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <meta charset="UTF-8">
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.css" />
    <link rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
    <title></title>

</head>

<script>
    $(function () {
        $("#register").click(function (){
            var userName = $.trim($("#userName").val());
            var password = $.trim($("#password").val());
            // 发送请求
            $.ajax({
                url: "user/register.do",
                data: {
                    userName:userName,
                    password:password
                },
                type:"post",
                dataType:"json",
                success:function (data){
                    if (data.code == "200"){
                        // 跳转到主页面
                        window.location.href="user/login.jsp";
                    } else {
                        layer.alert("用户名重复", {icon:5});
                    }
                }
            });
        })
    });

    function back() {
        document.location.href = "user/login.jsp";
    }
</script>

<body>
<div id="login">
    <div id="top">
        <img src="images/cloud.jpg" /><span>REGIST</span>
    </div>
    <div id="bottom">
        <form action="user/register.do">
            <table border="0px" id="table">
                <tr>
                    <td class="td1">用户名：</td>
                    <td><input id="userName" type="text" placeholder="Username" class="td2" name="myname"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="nameerr"></span></td>
                </tr>
                <tr>
                    <td class="td1">密码：</td>
                    <td><input id="password" type="password" placeholder="Password" class="td2" name="mypwd"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="pwderr"></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input id="register" type="button" value="注册" class="td3">
                        <input type="reset" onclick="back()" value="取消" class="td3	">
                    </td>
                </tr>
            </table>
        </form>
        ${is}
    </div>

</div>
</body>

</html>
