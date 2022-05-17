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
    <%--文件上传--%>
    <script type="text/javascript" src="js/ajaxfileupload.js"></script>
    <title></title>

    <style type="text/css">

    </style>

    <script type="text/javascript">
        $(function (){

            // 为“修改头像”添加单击事件
            $("#editAvatarModalBtn").click(function () {

                $.ajax({
                    url : "user/getById.do",
                    data : {
                        user_id:"${sessionScope.user.user_id}",
                    },
                    type : "post",
                    dataType : "json",
                    success : function (data) {
                        $("#updateImgName").html(data.avatar);
                        $("#updateImgDiv").empty();  //清空原有数据
                        //创建一个图片的标签
                        var imgObj = $("<img>");
                        //给img标签对象追加属性
                        imgObj.attr("src", "image_user/"+data.avatar);
                        imgObj.attr("style", "width:150px;height:150px;border-radius:50%;");
                        /*imgObj.attr("width", "150px");
                        imgObj.attr("height", "150px");
                        imgObj.attr("border-radius", "50%");*/
                        //将图片img标签追加到imgDiv末尾
                        $("#updateImgDiv").append(imgObj);

                        // 显示修改头像的模态窗口
                        $("#editAvatarModal").modal("show");
                    },
                    error : function () {
                        layer.alert("系统忙，请稍后再试...", {icon:5});
                    }
                })

            });

            // 为修改头像模态窗口的“更新”按钮绑定单击事件
            $("#updateAvatarBtn").click(function () {
                var avatar = $("#updateImgName").html();
                $.ajax({
                    url : "user/setAvatar.do",
                    data : {
                        user_id:"${sessionScope.user.user_id}",
                        avatar:$("#updateImgName").html()
                    },
                    type : "post",
                    dataType : "json",
                    success : function (data) {
                        if (data.code == "200"){
                            layer.alert(data.message, {icon:6});
                            var userAvatar = document.getElementById("avatar");
                            userAvatar.src = "image_user/"+avatar;
                            // 关闭模态窗口
                            $("#editAvatarModal").modal("hide");
                        } else {
                            layer.alert(data.message, {icon:5});
                        }

                    },
                    error : function () {
                        layer.alert("系统忙，请稍后再试...", {icon:5});
                    }
                })
            });

            // 为修改密码的模态窗口的“修改”按钮添加单击事件
            $("#updatePwd").click(function () {
                var oldPwd = $.trim($("#oldPwd").val());
                var newPwd = $.trim($("#newPwd").val());
                var confirmPwd = $.trim($("#confirmPwd").val());

                // 表单验证
                if (oldPwd != "${sessionScope.user.user_Password}"){
                    layer.alert("原密码输入错误", {icon: 7});
                    return;
                }
                if (newPwd == ""){
                    layer.alert("新密码不能为空", {icon: 7});
                    return;
                }
                if (newPwd == oldPwd){
                    layer.alert("新密码不能和原密码一样", {icon: 7});
                    return;
                }
                if (newPwd != confirmPwd){
                    layer.alert("新密码和确认的密码不一致", {icon: 7});
                    return;
                }

               $.ajax({
                   url:"user/updatePwd.do",
                   data:{
                       user_id:${sessionScope.user.user_id},
                       user_Password:newPwd
                   },
                   type:"post",
                   dataType:"json",
                   success:function (data) {
                       if (data.code == "200"){
                           window.location.href="user/toLogin.do";
                       }
                       if (data.code == "304"){
                           layer.alert(data.message, {icon: 5});
                       }
                   }
               })
            });

            // 给退出的“确定”按钮添加单击事件
            $("#logoutBtn").click(function (){
                window.location.href="user/logout.do";
            });


        });

        function fileChange() {//注意：此处不能使用jQuery中的change事件，因为仅触发一次，因此使用标签的：onchange属性
            $.ajaxFileUpload({
                url: "user/ajaxImg.do", //用于文件上传的服务器端请求地址
                secureuri: false, //安全协议，一般设置为false
                fileElementId: "updateAvatar",//文件上传控件的id属性  <input type="file" id="updateAvatar" name="userImage" />
                dataType: "json",
                success: function (data) {
                    if (data.code == "200") {
                        $("#updateImgDiv").empty();  //清空原有数据
                        //创建一个图片的标签
                        var imgObj = $("<img>");
                        //给img标签对象追加属性
                        imgObj.attr("src", "image_user/" + data.retData);
                        /*imgObj.attr("width", "150px");
                        imgObj.attr("height", "150px");*/
                        imgObj.attr("style", "width:150px;height:150px;border-radius:50%;");
                        //将图片img标签追加到imgDiv末尾
                        $("#updateImgDiv").append(imgObj);
                        // 将图片的名称赋值给文本框
                        $("#updateImgName").html(data.retData);
                    } else {
                        layer.alert(data.message, {icon: 7});
                    }
                },
                error: function (e) {
                    alert(e.message);
                }
            });
        }
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
            <div style="position: absolute; top: 15px; right: 80px;">
                <ul>
                    <li class="dropdown user-dropdown" style="list-style: none">
                        <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-user"></span>${user.user_Name}<span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span>我的资料</a></li>
                            <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span>修改密码</a></li>
                            <li><a id="editAvatarModalBtn" href="javascript:void(0)" data-toggle="modal"><span class="glyphicon glyphicon-edit"></span>修改头像</a></li>
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

    <!-- 我的资料 -->
    <div class="modal fade" id="myInformation" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">我的资料</h4>
                </div>
                <div class="modal-body">
                    <div style="position: relative; left: 40px;">
                        姓名：<b>${sessionScope.user.user_Name}</b><br><br>
                        性别：<b>${sessionScope.user.user_Sex}</b><br><br>
                        邮箱：<b>${sessionScope.user.user_Email}</b><br><br>
                        头像:
                        <div>
                            <img style="width: 150px; height: 150px; border-radius:50%;" id="avatar2" name="image" src="image_user/${sessionScope.user.avatar}" /><br/><br/>
                        </div>
                        <b>${sessionScope.user.avatar}</b><br><br>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改头像的模态窗口 -->
    <div class="modal fade" id="editAvatarModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">修改头像</h4>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">图片介绍<span style="font-size: 50px; color: red;"></span></label>
                    <%-- <td class="three">图片介绍</td>--%>
                    <td> <br><div id="updateImgDiv" style="display:block; width: 40px; height: 50px;"></div><br><br><br><br><br><br>
                        <input type="file" id="updateAvatar" name="userImage" accept="image/jpg,image/png,image/jpeg,image/bmp" onchange="fileChange()">
                        <span id="updateImgName" >未选择文件...</span><br>
                    </td>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="updateAvatarBtn" type="button" class="btn btn-primary">更新</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改密码的模态窗口 -->
    <div class="modal fade" id="editPwdModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 70%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="oldPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="newPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button id="updatePwd" type="button" class="btn btn-primary">更新</button>
                </div>
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
