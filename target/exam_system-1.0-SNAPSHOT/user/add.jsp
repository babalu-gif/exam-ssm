<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
    <title>Title</title>
    <script type="text/javascript">
        function sub()
        {
            $.ajax({
                url : "user/add.do",
                data: {
                    "user_Name" : $("#form").document("#")
                },
                type : "post",
                dataType : "text",
                success : function (msg)
                {
                    layer.alert(msg, {icon:6});
                    $("#table").load("http://localhost:8080${pageContext.request.contextPath}/user/getAll.do #table");
                }
            })
        }
    </script>
</head>
<body>
    <div align="center">
        <form action="user/add.do" method="post" onsubmit="return sub();">
            <table border="2" style="text-align: center" id="form">
                <tr>
                    <td>用户姓名</td>
                    <td><input type="text" name="user_Name"/></td>
                </tr>
                <tr>
                    <td>用户密码</td>
                    <td><input type="password" name="user_Password"/></td>
                </tr>
                <tr>
                    <td>用户性别</td>
                    <td>
                        <input type="radio" name="user_Sex" value="男"/>男
                        <input type="radio" name="user_Sex" value="女"/>女
                    </td>
                </tr>
                <tr>
                    <td>用户邮箱</td>
                    <td><input type="text" name="user_Email"/></td>
                </tr>
                <tr>
                    <td><input type="button" value="用户注册" onclick="sub()"/></td>
                    <td><input type="reset" /></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
