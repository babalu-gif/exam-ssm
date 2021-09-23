<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <script type="text/javascript" src="jquery/jquery-3.4.1.js"></script>
    <%--创建模态窗口--%>
    <script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

    <title>Title</title>
</head>
<script type="text/javascript">
    $(function (){

        // 页面加载完毕后,触发查询方法
        find();

        // 为打开创建模态窗口绑定事件
        $("#addBt").click(function (){
            $("#createUserModal").modal("show");
        })

        // 为保存按钮绑定事件，执行添加操作
        $("#saveBt").click(function (){
            $.ajax({
                url : "user/save.do",
                data : {
                    "user_Name" : $("#create_username").val(),
                    "user_Password" : $("#create_password").val(),
                    "user_Sex" : $("#create_sex").val(),
                    "user_Email" : $("#create_email").val()
                },
                type : "post",
                success : function ()
                {
                    alert("添加用户成功！")
                    // 清空添加模态窗口的数据
                    $("#userAddForm")[0].reset();
                    // 关闭模态窗口
                    $("#createUserModal").modal("hide");
                    find();
                },
                error : function ()
                {
                    alert("添加用户失败！");
                }
            })
        })

        // 为修改按钮绑定事件，执行修改操作
        $("#updateBt").click(function (){
            $.ajax({
                url : "user/set.do",
                data : {
                    "user_id" : $("#hidden_id").val(),
                    "user_Name" : $("#update_username").val(),
                    "user_Password" : $("#update_password").val(),
                    "user_Sex" : $("#update_sex").val(),
                    "user_Email" : $("#update_email").val()
                },
                type : "post",
                dataType : "text",
                success : function ()
                {
                    alert("修改用户成功！")
                    // 清空添加模态窗口的数据
                    $("#userUpdateForm")[0].reset();
                    // 关闭模态窗口
                    $("#updateUserModal").modal("hide");
                    find();
                },
                error : function ()
                {
                    alert("修改用户失败！");
                }
            })
        })

        // 为查询按钮绑定事件
        $("#search_Bt").click(function (){

            find();

        })
    })

    function find()
    {
        // 将查询文本框的信息存储到隐藏域中，方便进行查询操作
        $("#hidden_username").val($("#search_username").val());
        $("#hidden_sex").val($("#search_sex").val());
        $("#hidden_email").val($("#search_email").val());

        $.ajax({
            url : "user/find.do",
            data : {
                "user_Name" : $("#hidden_username").val(),
                "user_Sex" : $("#hidden_sex").val(),
                "user_Email" : $("#hidden_email").val()
            },
            type : "post",
            dataType: "json",
            success : function (data)
            {
                /*$("table tbody").html("");*/
                // 清空userBody的数据
                $("#userBody").html("");
                var html = "";
                $.each(data, function(index, u)
                {
                    html += '<tr>';
                    html += '<td>'+u.user_Name+'</td>';
                    html += '<td>'+u.user_Password+'</td>';
                    html += '<td>'+u.user_Sex+'</td>';
                    html += '<td>'+u.user_Email+'</td>';
                    html += '<td><img src="images/shanchu.png"  alt="删除信息" onclick="deleteById('+u.user_id+')"/></td>';
                    html += '<td><img src="images/xiugai.png"  alt="修改信息" onclick="updateById('+u.user_id+')"/></td>';
                    html += '</tr>';
                })
                $("#userBody").html(html);
            },
            error : function ()
            {
                alert("查询失败！");
            }
        })
    }

    function updateById(user_id)
    {
        $.ajax({
            url : "user/getById.do",
            data : {
                "user_id" : user_id
            },
            type : "get",
            dataType : "json",
            success : function (data)
            {
                // 把查询出的数据存储到将要更新的域中
                $("#hidden_id").val(data.user_id);
                $("#update_username").val(data.user_Name);
                $("#update_password").val(data.user_Password);
                $("#update_sex").val(data.user_Sex);
                $("#update_email").val(data.user_Email);
            }
        })

        // 为打开修改模态窗口绑定事件
        $("#updateUserModal").modal("show");
    }

    function deleteById(user_id)
    {
        if(confirm("您确定删除吗？"))
        {
            $.ajax({
                url : "user/deleteById.do",
                data: {
                    "user_id" : user_id
                },
                type : "post",
                dataType : "text",
                success : function ()
                {
                   alert("删除成功！");
                   find();
                },
                error : function ()
                {
                    alert("删除失败！");
                }
            })
        }
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
                    <button type="button" class="btn btn-primary" id="addBt"><span class="glyphicon glyphicon-plus"></span> 创建</button>
                </div>
            </div>


            <div style="position: relative;top: 10px;">
                <table class="table table-hover" style="text-align: center">
                    <thead>
                    <tr>
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

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateBt">修改</button>
                </div>
            </div>
        </div>
    </div>


</body>
</html>