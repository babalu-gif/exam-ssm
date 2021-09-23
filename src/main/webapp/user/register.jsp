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
    <link rel="stylesheet" href="css/login.css" />
    <script type="text/javascript" src="jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <title></title>

</head>

<script>
    function back()
    {
        document.location.href = "user/login.jsp";
    }
</script>

<body>
<div id="login">
    <div id="top">
        <img src="images/cloud.jpg" /><span>REGIST</span>
    </div>
    <div id="bottom">
        <form action="user/register.do" method="post">
            <table border="0px" id="table">
                <tr>
                    <td class="td1">用户名：</td>
                    <td><input type="text" placeholder="Username" class="td2" name="myname"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="nameerr"></span></td>
                </tr>
                <tr>
                    <td class="td1">密码：</td>
                    <td><input type="password" placeholder="Password" class="td2" name="mypwd"></td>
                </tr>
                <tr>
                    <td></td>
                    <td><span id="pwderr"></span></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="注册" class="td3">
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
