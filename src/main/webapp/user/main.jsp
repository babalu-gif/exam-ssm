<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <link rel="stylesheet" href="css/index.css" />
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="bootstrap-3.3.7-dist/js/bootstrap.js"></script>
    <link rel="stylesheet" href="bootstrap-3.3.7-dist/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
    <title></title>

    <style type="text/css">

    </style>

    <script type="text/javascript">
        $(function (){
            //导航中所有文本颜色为黑色
            $(".liClass > a").css("color" , "black");

            //默认选中导航菜单中的第一个菜单项
            $(".liClass:first").addClass("active");

            // 给退出的“确定”按钮添加单击事件
            $("#logoutBtn").click(function (){
                window.location.href="user/logout.do";
            });


        })
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
           <%-- <div id="top2"></div>--%>
            <div style="position: absolute; top: 15px; right: 60px;">
                <ul>
                    <li class="dropdown user-dropdown" style="list-style: none">
                        <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${user.user_Name}<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span>我的资料</a></li>
                            <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span>修改密码</a></li>
                            <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span>安全退出</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <!--下部分-->
        <div id="bottom">
            <!--下部分左边-->
            <div id="bleft">
                <div id="ltop">
                    <div id="lts">
                        <img id="avatar" name="image" src="image_user/${sessionScope.user.avatar}" /><br/><br/>
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

    <!-- 退出系统的模态窗口 -->
    <div class="modal fade" id="exitModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">离开</h4>
                </div>
                <div class="modal-body">
                    <p>您确定要退出系统吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="logoutBtn">确定</button>
                </div>
            </div>
        </div>
    </div>


    </body>
</html>
