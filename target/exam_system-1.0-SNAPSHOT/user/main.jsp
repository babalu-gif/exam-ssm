<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <link rel="stylesheet" href="css/bootstrap.css" />
    <link rel="stylesheet" href="css/index.css" />
    <script type="text/javascript" src="jquery/jquery-3.4.1.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <title></title>

    <style type="text/css">

    </style>
</head>
<body>
    <!--整体部分-->
    <div id="all">
        <!--上部分-->
        <div id="top">
            <div id="top1">
                <span>在线考试管理系统</span>
            </div>
            <div id="top2"></div>
            <div id="top3">
                <span>欢迎您，${user.user_Name}</span>
            </div>
        </div>
        <!--下部分-->
        <div id="bottom">
            <!--下部分左边-->
            <div id="bleft">
                <div id="ltop">
                    <div id="lts">
                        <img src="images/logo.jpg" /><br/><br/>
                        <%--<p style="text-align: center;">${user.user_Name}</p>--%>
                    </div>
                </div>
                <div id="lbottom">
                    <ul>
                        <a href="user/users.jsp" target="myright" >
                            <li class="two"><span style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;用户管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: white;"></span></li>
                        </a>
                        <a href="question/questions.jsp" target="myright">
                            <li class="one"><span style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;试题管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: white;"></span> </li>
                        </a>
                        <a href="exam/exam.do" target="myright">
                            <li class="one"><span style="color: white;"></span>&nbsp;&nbsp;&nbsp;&nbsp;考试管理&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: white;"></span> </li>
                        </a>
                        <a href="http://www.cupde.cn/cms/conksgg/2009.htm" target="myright">
                            <li class="one"><span style="color: white"></span>&nbsp;&nbsp;&nbsp;&nbsp;通知公告&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="color: white;"></span> </li>
                        </a>
                    </ul>
                </div>
            </div>
            <!--下部分右边-->
            <div id="bright">
                <iframe frameborder="0" scrolling="yes" name="myright" width="1235px" height="700px" ></iframe>
            </div>
        </div>
    </div>
    </body>
</html>
