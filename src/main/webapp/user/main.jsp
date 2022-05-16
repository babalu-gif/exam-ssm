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
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <title></title>

    <style type="text/css">

    </style>

    <script type="text/javascript">
        function fileChange(){//注意：此处不能使用jQuery中的change事件，因此仅触发一次，因此使用标签的：onchange属性


        }


        /*$(function (){
            //使用bind方法绑定click事件
            $("#avatar").bind("click",function(){
                alert('你点击了图片');
                // document.getElementById("avatar").src = "images/xiugai.png";

                $.ajaxFileUpload({
                    url: "user/updateAvatar.do", //用于文件上传的服务器端请求地址
                    secureuri: false, //安全协议，一般设置为false
                    fileElementId: "avatar",//文件上传控件的id属性  <input type="file" id="pimage" name="pimage" />
                    dataType: "json",
                    success: function(obj) {
                        document.getElementById("avatar").src = "image_user/"+obj.imgurl;
                    },
                    error: function (e) {
                        alert(e.message);
                    }
                });
            })
        });*/
    </script>
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
                        <img id="avatar" name="image" src="image_user/${sessionScope.user.avatar}" /><br/><br/>
                        <%--<p style="text-align: center;">${user.user_Name}</p>--%>

<%--                                <input type="file" id="avatar" name="pimage" onchange="fileChange()" src="image_user/${sessionScope.user.avatar}">--%>
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
