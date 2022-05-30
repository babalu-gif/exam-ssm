<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <%--创建模态窗口--%>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <%--导入分页插件--%>
    <link type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css"/>
    <script src="jquery/bs_pagination/en.js"></script>
    <script src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <%--layer插件--%>
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
    <%--文件上传--%>
    <script type="text/javascript" src="js/ajaxfileupload.js"></script>
    <title>Title</title>
</head>

<style>
    input[type="file"] {
        color: transparent;
    }
</style>

<script type="text/javascript">
    $(function (){

        // 页面加载完毕后,触发查询方法
        refresh(1, 2);

        // 为打开创建模态窗口绑定事件
        $("#addBt").click(function (){
            $("#createUserModal").modal("show");
        })

        // 为保存按钮绑定事件，执行添加操作
        $("#saveBt").click(function (){
            $.ajax({
                url : "user/save.do",
                data : {
                    "user_Name" : $("#create_username").val().trim(),
                    "user_Password" : $("#create_password").val().trim(),
                    "user_Sex" : $("#create_sex").val().trim(),
                    "user_Email" : $("#create_email").val().trim(),
                    "avatar" : $("#imgName").html()
                },
                type : "post",
                dataType:"json",
                success : function (data) {
                    if (data.code == "200"){
                        layer.alert("添加用户成功！", {icon:6});
                        // 清空添加模态窗口的数据
                        $("#userAddForm")[0].reset();
                        // 关闭模态窗口
                        $("#createUserModal").modal("hide");
                        /*
                            添加成功后，回到第一页，维持每页展示对的记录数
                        */
                        refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                        // 清空添加模态窗口的数据
                        $("#userAddForm")[0].reset();
                        // 关闭模态窗口
                        $("#createUserModal").modal("hide");
                        /*
                            添加成功后，回到第一页，维持每页展示对的记录数
                        */
                        refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                    } else {
                        layer.alert(data.message, {icon:5});
                    }

                },
                error : function () {
                    layer.alert("添加用户失败！", {icon:2});
                }
            })
        });

        // 为修改按钮绑定事件，执行修改操作
        $("#updateBt").click(function (){
            $.ajax({
                url : "user/set.do",
                data : {
                    "user_id" : $("#hidden_id").val().trim(),
                    "user_Name" : $("#update_username").val().trim(),
                    "user_Password" : $("#update_password").val().trim(),
                    "user_Sex" : $("#update_sex").val().trim(),
                    "user_Email" : $("#update_email").val().trim(),
                    "avatar":$("#updateImgName").html()
                },
                type : "post",
                dataType : "json",
                success : function (data) {
                    if (data.code == "200"){
                        layer.alert("修改用户成功！", {icon:6});
                        // 清空添加模态窗口的数据
                        $("#userUpdateForm")[0].reset();
                        // 关闭模态窗口
                        $("#updateUserModal").modal("hide");
                        /*
                            修改操作后，应该维持在当前页，维持每页展示的记录数
                        */
                        refresh($("#userPage").bs_pagination('getOption', 'currentPage')
                            ,$("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                    } else {
                        layer.alert("修改用户失败，用户名已存在！", {icon:5});
                    }

                },
                error : function () {
                    layer.alert("修改用户失败！", {icon:5});
                }
            })
        });

        // 为查询按钮绑定事件
        $("#search_Bt").click(function (){
            /*
                查询成功后，回到第一页，维持每页展示对的记录数
            */
            refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));

        })

        // 为删除按钮绑定事件
        $("#deleteBt").click(function (){
            // 找到复选框所有挑√的复选框的jquery对象
            var $xz = $("input[name=xz]:checked");
            if($xz.length == 0) {
                layer.alert("请选择需要删除的记录", {icon:0});
            }
            else {
                var param = [];
                for(var i = 0; i < $xz.length; i++) {
                    // 将查询出来的试题id以','分割放入数组中
                    param.push($($xz[i]).val());
                }
                // confirm 取消不删除，确定开始执行删除操作
                if(confirm("确定删除所选中的记录吗？")) {
                    $.ajax({
                        url : "user/delete.do?ids="+param,
                        type : "post",
                        dataType : "text",
                        success : function (data) {
                            layer.alert("删除用户成功", {icon:6});
                            /*
                                删除成功后，回到第一页，维持每页展示对的记录数
                            */
                            refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                        },
                        error : function () {
                            layer.alert("删除用户失败", {icon:2});
                        }
                    })
                }
            }
        })

        // 为全选按钮触发事件
        $("#qx").click(function () {
            $("input[name=xz]").prop("checked", this.checked);
        })

        /*
            动态生成的元素（不能以普通绑定事件的形式来进行操作），我们要以on方法的形式来触发事件
            语法格式：$(需要绑定事件的外层元素).on("绑定事件的方式", 需要绑定的jquery对象, 回调函数)
         */
        $("#userBody").on("click", $("input[name=xz]"), function () {
            $("#qx").prop("checked", $("input[name=xz]").length==$("input[name=xz]:checked").length);
        })

        // 为“批量导出”按钮绑定单击事件
        $("#exportUserAllBtn").click(function (){
            // 发送同步请求
            window.location.href="user/exportAllUsers.do";
        })

        // 为“批选择导出”按钮绑定单击事件
        $("#exportUserCheckedBtn").click(function (){
            // 找到复选框所有挑√的复选框的jquery对象
            var $check = $("input[name=xz]:checked");
            if ($check.length == 0){
                layer.alert("请选择需要导出的用户", {icon:7})
            } else {
                var param = [];
                for(var i = 0; i < $check.length; i++) {
                    // 将勾选的出来的用户id以','分割放入数组中
                    param.push($($check[i]).val());
                }
                // 发送同步请求
                window.location.href="user/exportCheckedUsers.do?id="+param;
            }
        })

        // 给“导入”按钮添加单击事件
        $("#importUserBtn").click(function (){
            // 收集参数
            var userFileName = $("#userFile").val();
            var type = userFileName.substr(userFileName.lastIndexOf(".")+1).toLowerCase(); // xls,XLS,Xls...
            if (type != "xls"){
                layer.alert("请选择xls文件类型的文件", {icon:7});
                return;
            }

            var userFile = $("#userFile")[0].files[0];
            if (userFile.size > (5*1024*1024)){
                layer.alert("文件大小不能超过5MB", {icon:7});
                return;
            }

            // FormData是ajax提供的接口，可以模拟键值对向后台提交参数
            // ForData最大的优势是不仅可以提交文本数据，还可以提交二进制数据
            var formData = new FormData();
            formData.append("userFile", userFile);
            // 发送请求
            $.ajax({
                url:"user/importUser.do",
                data:formData,
                type:"post",
                dataType:"json",
                processData: false, // processData处理数据
                contentType: false, // contentType发送数据的格式
                success:function (data){
                    if (data.code == "1"){
                        layer.alert(data.message, {icon:6});
                        // 关闭模态窗口
                        $("#importUserModal").modal("hide");
                        refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                    } else {
                        layer.alert(data.message, {icon:5});
                    }
                }
            })
        })


    });


    // 定义一个函数，发送请求不同页码对应的数据
    function refresh(page, pageSize) {
        // 将全选按钮框的√去掉
        $("#qx").prop("checked", false);

        // 将查询文本框的信息存储到隐藏域中，方便进行查询操作
        $("#hidden_username").val($("#search_username").val());
        $("#hidden_sex").val($("#search_sex").val());
        $("#hidden_email").val($("#search_email").val());

        $.post("user/find.do", {
            "page": page,
            "pageSize": pageSize,
            "user_Name" : $("#hidden_username").val(),
            "user_Sex" : $("#hidden_sex").val(),
            "user_Email" : $("#hidden_email").val()
        }, function (data) {

            /!*$("table tbody").html("");*!/
            // 清空userBody的数据
            $("#userBody").html("");
            var html = "";
            $.each(data.list, function(index, u) {
                html += '<tr>';
                html += '<td><input name="xz" type="checkbox" value="'+u.user_id+'"/></td>';
                html += '<td>'+u.user_Name+'</td>';
                html += '<td>'+u.user_Password+'</td>';
                html += '<td>'+u.user_Sex+'</td>';
                html += '<td>'+u.user_Email+'</td>';
                html += '<td><img src="images/shanchu.png"  alt="删除信息" onclick="deleteById('+u.user_id+')"/></td>';
                html += '<td><img src="images/xiugai.png"  alt="修改信息" onclick="updateById('+u.user_id+')"/></td>';
                html += '</tr>';
            })
            $("#userBody").append(html);

            //bootstrap的分页插件
            $("#userPage").bs_pagination({
                currentPage: data.pageNum, // 页码
                rowsPerPage: data.pageSize, // 每页显示的记录条数
                maxRowsPerPage: 20, // 每页最多显示的记录条数
                totalPages: data.pages, // 总页数
                totalRows: data.total, // 总记录条数
                visiblePageLinks: 2, // 显示几个卡片
                showGoToPage: true,
                showRowsPerPage: true,
                showRowsInfo: true,
                showRowsDefaultInfo: true,
                //回调函数，用户每次点击分页插件进行翻页的时候就会触发该函数
                onChangePage: function (event, obj) {
                    //currentPage:当前页码 rowsPerPage:每页记录数
                    refresh(obj.currentPage, obj.rowsPerPage);
                }
            });
        }, "json")
    }

    function updateById(user_id) {
        $.ajax({
            url : "user/getById.do",
            data : {
                "user_id" : user_id
            },
            type : "get",
            dataType : "json",
            success : function (data) {
                // 把查询出的数据存储到将要更新的域中
                $("#hidden_id").val(data.user_id);
                $("#update_username").val(data.user_Name);
                $("#update_password").val(data.user_Password);
                $("#update_sex").val(data.user_Sex);
                $("#update_email").val(data.user_Email);
                $("#updateImgName").html(data.avatar);
                $("#updateImgDiv").empty();  //清空原有数据
                //创建一个图片的标签
                var imgObj = $("<img>");
                //给img标签对象追加属性
                imgObj.attr("src", "image_user/" + data.avatar);
                /*imgObj.attr("width", "150px");
                imgObj.attr("height", "150px");*/
                imgObj.attr("style", "width:150px;height:150px;border-radius:50%;");
                //将图片img标签追加到imgDiv末尾
                $("#updateImgDiv").append(imgObj);
            }
        })

        // 为打开修改模态窗口绑定事件
        $("#updateUserModal").modal("show");
    }

    function deleteById(user_id) {
        if(confirm("您确定删除吗？")) {
            $.ajax({
                url : "user/deleteById.do",
                data: {
                    "user_id" : user_id
                },
                type : "post",
                dataType : "text",
                success : function () {
                    layer.alert("删除成功！", {icon:6});
                    /*
                        删除成功后，回到第一页，维持每页展示对的记录数
                     */
                    refresh(1, $("#userPage").bs_pagination('getOption', 'rowsPerPage'));
                },
                error : function () {
                    layer.alert("删除失败！", {icon:2});
                }
            })
        }
    }

    function fileChange() {//注意：此处不能使用jQuery中的change事件，因为仅触发一次，因此使用标签的：onchange属性
        $.ajaxFileUpload({
            url: "user/ajaxImg.do", //用于文件上传的服务器端请求地址
            secureuri: false, //安全协议，一般设置为false
            fileElementId: "addAvatar",//文件上传控件的id属性  <input type="file" id="addAvatar" name="userImage" />
            dataType: "json",
            success: function (data) {
                if (data.code == "200") {
                    $("#imgDiv").empty();  //清空原有数据
                    //创建一个图片的标签
                    var imgObj = $("<img>");
                    //给img标签对象追加属性
                    imgObj.attr("src", "image_user/" + data.retData);
                    /*imgObj.attr("width", "150px");
                    imgObj.attr("height", "150px");*/
                    imgObj.attr("style", "width:150px;height:150px;border-radius:50%;");
                    //将图片img标签追加到imgDiv末尾
                    $("#imgDiv").append(imgObj);
                    // 将图片的名称赋值给文本框
                    $("#imgName").html(data.retData);
                } else {
                    layer.alert(data.message, {icon: 7});
                }
            },
            error: function (e) {
                alert(e.message);
            }
        });
    }

    function fileChange2() {//注意：此处不能使用jQuery中的change事件，因为仅触发一次，因此使用标签的：onchange属性
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

<body>

<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>用户信息列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 180px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">用户名</div>
                        <input class="form-control" type="text" id="search_username">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">性别</div>
                        <select class="form-control" type="text" id="search_sex">
                            <option value=""></option>
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">邮箱</div>
                        <input class="form-control" type="text" id="search_email" />
                    </div>
                </div>
                <button type="button" class="btn btn-default" id="search_Bt">查询</button>

            </form>
        </div>

        <div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-danger" id="deleteBt"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addBt"><span class="glyphicon glyphicon-plus"></span> 创建</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-default" data-toggle="modal" data-target="#importUserModal" ><span class="glyphicon glyphicon-import"></span> 上传列表数据（导入）</button>
                <button id="exportUserAllBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（批量导出）</button>
                <button id="exportUserCheckedBtn" type="button" class="btn btn-default"><span class="glyphicon glyphicon-export"></span> 下载列表数据（选择导出）</button>
            </div>
        </div>


        <div style="position: relative;top: 10px;">
            <table class="table table-hover" style="text-align: center">
                <thead>
                <tr>
                    <td><input type="checkbox" id="qx"/></td>
                    <td>用户名</td>
                    <td>密码</td>
                    <td>性别</td>
                    <td>邮箱</td>
                    <td colspan="2">操作</td>
                </tr>
                </thead>
                <tbody id="userBody">

                </tbody>
            </table>
            <footer class="message_footer">
                <nav>
                    <%--分页插件--%>
                    <div  style="height: 50px; position: relative;top: 30px;">
                        <div id="userPage"></div>
                    </div>
                </nav>
            </footer>
        </div>

    </div>
</div>

<%--为更新文本框设置隐藏域--%>
<input type="hidden" id="hidden_id"/>
<%--为查询文本框设置隐藏域--%>
<input type="hidden" id="hidden_username"/>
<input type="hidden" id="hidden_sex"/>
<input type="hidden" id="hidden_email"/>

<!-- 创建用户信息的模态窗口 -->
<div class="modal fade" id="createUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form" id="userAddForm">

                    <div class="form-group">
                        <label for="create_username" class="col-sm-2 control-label">用户名<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create_username">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create_password" class="col-sm-2 control-label">密码<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="password" class="form-control" id="create_password">
                        </div>
                    </div>

                    <div class="form-group">

                        <label for="create_sex" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create_sex">
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="1" id="create_email"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create_username" class="col-sm-2 control-label">图片介绍<span style="font-size: 15px; color: red;"></span></label>
                       <%-- <td class="three">图片介绍</td>--%>
                        <td> <br><div id="imgDiv" style="display:block; width: 40px; height: 50px;"></div><br><br><br><br><br><br>
                            <input type="file" id="addAvatar" name="userImage" accept="image/jpg,image/png,image/jpeg,image/bmp" onchange="fileChange()">
                            <span id="imgName" >未选择文件...</span><br>
                        </td>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="saveBt">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改用户信息的模态窗口 -->
<div class="modal fade" id="updateUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel2">修改用户</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form" id="userUpdateForm">

                    <div class="form-group">
                        <label for="update_username" class="col-sm-2 control-label">用户名<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="update_username">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="update_password" class="col-sm-2 control-label">密码<span style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="password" class="form-control" id="update_password">
                        </div>
                    </div>

                    <div class="form-group">

                        <label for="update_sex" class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="update_sex">
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="update_email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="1" id="update_email"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create_username" class="col-sm-2 control-label">图片介绍<span style="font-size: 15px; color: red;"></span></label>
                        <%-- <td class="three">图片介绍</td>--%>
                        <td> <br><div id="updateImgDiv" style="display:block; width: 40px; height: 50px;"></div><br><br><br><br><br><br>
                            <input type="file" id="updateAvatar" name="userImage" accept="image/jpg,image/png,image/jpeg,image/bmp" onchange="fileChange2()">
                            <span id="updateImgName" >未选择文件...</span><br>
                        </td>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateBt">修改</button>
            </div>
        </div>
    </div>
</div>

<!-- 导入用户的模态窗口 -->
<div class="modal fade" id="importUserModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">导入用户</h4>
            </div>
            <div class="modal-body" style="height: 350px;">
                <div style="position: relative;top: 20px; left: 50px;">
                    请选择要上传的文件：<small style="color: gray;">[仅支持.xls]</small>
                </div>
                <div style="position: relative;top: 40px; left: 50px;">
                    <input type="file" id="userFile">
                </div>
                <div style="position: relative; width: 400px; height: 320px; left: 45% ; top: -40px;" >
                    <h3>重要提示</h3>
                    <ul>
                        <li>操作仅针对Excel，仅支持后缀名为XLS的文件。</li>
                        <li>给定文件的第一行将视为字段名。</li>
                        <li>请确认您的文件大小不超过5MB。</li>
                        <li>默认情况下，字符编码是UTF-8 (统一码)，请确保您导入的文件使用的是正确的字符编码方式。</li>
                        <li>建议您在导入真实数据之前用测试文件测试文件导入功能。</li>
                    </ul>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="importUserBtn" type="button" class="btn btn-primary">导入</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>