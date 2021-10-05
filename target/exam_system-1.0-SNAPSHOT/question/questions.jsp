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

        // 页面加载完毕，触发一个方法
        find();

        // 为查询按钮绑定事件
        $("#search_Bt").click(function ()
        {
            find();
        })

        // 为创建按钮绑定事件,打开创建试题的模态窗口
        $("#addBt").click(function ()
        {
           $("#createQuestionModal").modal("show");
        })

        // 为保存按钮绑定事件，执行新建试题操作
        $("#saveBt").click(function ()
        {
            $.ajax({
                url : "question/save.do",
                data : {
                    "title" : $("#create_title").val().trim(),
                    "optionA" : $("#create_optionA").val().trim(),
                    "optionB" : $("#create_optionB").val().trim(),
                    "optionC" : $("#create_optionC").val().trim(),
                    "optionD" : $("#create_optionD").val().trim(),
                    "answer" : $("#create_answer").val().trim()
                },
                type : "post",
                success : function ()
                {
                    alert("添加试题成功！")
                    // 清空添加模态窗口的数据
                    $("#questionAddForm")[0].reset();
                    // 关闭模态窗口
                    $("#createQuestionModal").modal("hide");
                    find();
                },
                error : function ()
                {
                    alert("添加试题失败！");
                }
            })
        })

        // 为修改按钮绑定事件，执行试题修改的操作
        $("#updateBt").click(function (){
            $.ajax({
                url : "question/update.do",
                data : {
                    "questionId" : $("#update_questionId").val().trim(),
                    "title" : $("#update_title").val().trim(),
                    "optionA" : $("#update_optionA").val().trim(),
                    "optionB" : $("#update_optionB").val().trim(),
                    "optionC" : $("#update_optionC").val().trim(),
                    "optionD" : $("#update_optionD").val().trim(),
                    "answer" : $("#update_answer").val().trim()
                },
                type : "post",
                success : function ()
                {
                    alert("修改试题成功！")
                    // 清空修改模态窗口的数据
                    $("#questionUpdateForm")[0].reset();
                    // 关闭模态窗口
                    $("#updateQuestionModal").modal("hide");
                    find();
                },
                error : function ()
                {
                    alert("添加试题失败！");
                }
            })
        })

    })


    function find()
    {
        // 将查询文本框的信息存储到隐藏域中，方便进行查询操作
        $("#hidden_title").val($("#search_title").val());

        $.ajax({
            url : "question/find.do",
            data : {
                "questionId" : $("#hidden_questionId").val(),
                "title" : $("#hidden_title").val()
            },
            type : "post",
            dataType: "json",
            success : function (data)
            {
                /*$("table tbody").html("");*/
                // 清空questionBody的数据
                $("#questionBody").html("");
                var html = "";
                $.each(data, function(index, q)
                {
                    html += '<tr>';
                    html += '<td>'+q.questionId+'</td>';
                    html += '<td>'+q.title+'</td>';
                    html += '<td>'+q.optionA+'</td>';
                    html += '<td>'+q.optionB+'</td>';
                    html += '<td>'+q.optionC+'</td>';
                    html += '<td>'+q.optionD+'</td>';
                    html += '<td>'+q.answer+'</td>';
                    html += '<td><img src="images/shanchu.png"  alt="删除信息" onclick="deleteById('+q.questionId+')"/></td>';
                    html += '<td><img src="images/xiugai.png"  alt="修改信息" onclick="updateById('+q.questionId+')"/></td>';
                    html += '</tr>';
                })
                $("#questionBody").html(html);
            },
            error : function ()
            {
                alert("查询失败！");
            }
        })
    }

    function deleteById(questionId)
    {
        if (confirm("您确定删除吗？")) {
            $.ajax({
                url: "question/deleteById.do",
                data: {
                    "questionId": questionId
                },
                type: "post",
                dataType: "text",
                success: function () {
                    alert("删除成功！");
                    find();
                },
                error: function () {
                    alert("删除失败！");
                }
            })
        }
    }

    function updateById(questionId)
    {

        $.ajax({
            url : "question/getById.do",
            data : {
                "questionId" : questionId
            },
            type : "get",
            dataType : "json",
            success : function (data)
            {
                // 把查询出的数据存储到将要更新的域中
                $("#update_questionId").val(data.questionId);
                $("#update_title").val(data.title);
                $("#update_optionA").val(data.optionA);
                $("#update_optionB").val(data.optionB);
                $("#update_optionC").val(data.optionC);
                $("#update_optionD").val(data.optionD);
                $("#update_answer").val(data.answer);
            }
        })

        // 为打开修改试题的模态窗口绑定事件
        $("#updateQuestionModal").modal("show");
    }
</script>

<body>
    <div>
        <div style="position: relative; left: 10px; top: -10px;">
            <div class="page-header">
                <h3>试题信息列表</h3>
            </div>
        </div>
    </div>

    <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
        <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

            <div class="btn-toolbar" role="toolbar" style="height: 80px;" align="center">
                <form class="form-inline" role="form" style="position: relative;top: 8%; ">

                    <div class="form-group">
                        <div class="input-group">
                            <div class="input-group-addon">题目</div>
                            <input class="form-control" type="text" id="search_title">
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
                            <td>题号</td>
                            <td>题目</td>
                            <td>A</td>
                            <td>B</td>
                            <td>C</td>
                            <td>D</td>
                            <td>答案</td>
                            <td colspan="2">操作</td>
                        </tr>
                    </thead>

                    <tbody id="questionBody">

                    </tbody>
                </table>
            </div>

        </div>
    </div>


    <%--为更新文本框设置隐藏域--%>
    <input type="hidden" id="update_questionId"/>
    <%--为查询文本框设置隐藏域--%>
    <input type="hidden" id="hidden_title"/>

    <!-- 创建试题的模态窗口 -->
    <div class="modal fade" id="createQuestionModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">创建试题</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form" id="questionAddForm">

                        <div class="form-group">
                            <label for="create_title" class="col-sm-2 control-label">题目<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 775px;">
                                <textarea class="form-control" rows="2" id="create_title"></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="create_optionA" class="col-sm-2 control-label">A<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create_optionA">
                            </div>

                            <label for="create_optionB" class="col-sm-2 control-label">B<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create_optionB">
                            </div>

                            <label for="create_optionC" class="col-sm-2 control-label">C<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create_optionC">
                            </div>

                            <label for="create_optionD" class="col-sm-2 control-label">D<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create_optionD">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="create_answer" class="col-sm-2 control-label">答案<span style="font-size: 15px; color: red;"></span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="create_answer">
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
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

    <!-- 修改试题的模态窗口 -->
    <div class="modal fade" id="updateQuestionModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">修改试题</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form" id="questionUpdateForm">

                        <div class="form-group">
                            <label for="update_title" class="col-sm-2 control-label">题目<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 775px;">
                                <textarea class="form-control" rows="2" id="update_title"></textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="update_optionA" class="col-sm-2 control-label">A<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="update_optionA">
                            </div>

                            <label for="update_optionB" class="col-sm-2 control-label">B<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="update_optionB">
                            </div>

                            <label for="update_optionC" class="col-sm-2 control-label">C<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="update_optionC">
                            </div>

                            <label for="update_optionD" class="col-sm-2 control-label">D<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="update_optionD">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="update_answer" class="col-sm-2 control-label">答案<span style="font-size: 15px; color: red;"></span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="update_answer">
                                    <option value="A">A</option>
                                    <option value="B">B</option>
                                    <option value="C">C</option>
                                    <option value="D">D</option>
                                </select>
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