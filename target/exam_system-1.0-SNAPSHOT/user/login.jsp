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
    <script type="text/javascript" src="jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
</head>
<body>
<div id="login">
    <div id="top">
        <img src="images/cloud.jpg" /><span>LOGIN</span>
    </div>
    <div id="bottom">
        <form  action="user/login.do" method="post">
            <table border="0px" id="table">
                <tr>
                    <td class="td1">用户名：</td>
                    <td><input type="text" value="admin" placeholder="Username" class="td2" name="user_Name"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="nameerr"></span></td>
                </tr>
                <tr>
                    <td class="td1">密码：</td>
                    <td><input type="password"  value="admin" placeholder="Password" class="td2" name="user_Password"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="pwderr"></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="登录" class="td3">
                        <a href="user/register.jsp"><input type="button" value="注册" class="td3	"></a>
                    </td>
                </tr>
            </table>
        </form>
        ${errmsg}
    </div>

</div>
</body>
</html>
