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
    <script type="text/javascript" src="/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="/js/"></script>
</head>
<body>
<div id="login">
    <div id="top">
        <img src="/images/cloud.jpg" /><span>LOGIN</span>
    </div>
    <div id="bottom">
        <form  action="/admin/login.do" method="post">
            <table border="0px" id="table">
                <tr>
                    <td class="td1">用户名：</td>
                    <td><input type="text" value="admin" placeholder="Username" class="td2" name="name"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="nameerr"></span></td>
                </tr>
                <tr>
                    <td class="td1">密码：</td>
                    <td><input type="password"  value="123" placeholder="Password" class="td2" name="pwd"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="pwderr"></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="登录" class="td3">
                        <a href="/regist.jsp"><input type="button" value="注册" class="td3	"></a>
                    </td>
                </tr>
            </table>
        </form>
        ${errmsg}
    </div>

</div>
</body>
</html>
