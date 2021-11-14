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
    <title>Title</title>
</head>
<script type="text/javascript">

    $(function (){

        // 页面加载完毕，触发一个方法
        refresh(1, 2);

        // 为查询按钮绑定事件
        $("#search_Bt").click(function ()
        {
            /*
                查询成功后，回到第一页，维持每页展示对的记录数
            */
            refresh(1, $("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
        })

        // 为删除按钮绑定事件,打开创建试题的模态窗口
        $("#deleteBt").click(function ()
        {
            // 找到复选框所有挑√的复选框的jquery对象
            var $xz = $("input[name=xz]:checked");
            if($xz.length == 0)
            {
                layer.alert("请选择需要删除的记录", {icon:0});
            }
            else
            {
                var param = [];
                for(var i = 0; i < $xz.length; i++)
                {
                    /*param += "id=" + $($xz[i]).val();
                    // 如果不是最后一个元素
                    if(i < $xz.length-1)
                    {
                        param += "&";
                    }*/
                    // 将查询出来的试题id以','分割放入数组中
                    param.push($($xz[i]).val());
                }

                // confirm 取消不删除，确定开始执行删除操作
                if(confirm("确定删除所选中的记录吗？"))
                {
                    $.ajax({
                        url : "question/delete.do?ids="+param,
                        type : "post",
                        dataType : "text",
                        success : function (data)
                        {
                            layer.alert("删除试题成功", {icon:6});
                            /*
                                删除成功后，回到第一页，维持每页展示对的记录数
                            */
                            refresh(1, $("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
                        },
                        error : function ()
                        {
                            layer.alert("删除试题失败", {icon:2});
                        }
                    })
                }
            }
        })

        // 为创建按钮绑定事件
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
                    layer.alert("添加试题成功", {icon:6});
                    // 清空添加模态窗口的数据
                    $("#questionAddForm")[0].reset();
                    // 关闭模态窗口
                    $("#createQuestionModal").modal("hide");
                    /*
                        添加成功后，回到第一页，维持每页展示对的记录数
                    */
                    refresh(1, $("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
                },
                error : function ()
                {
                    layer.alert("添加试题失败！", {icon:2});
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
                    layer.alert("修改试题成功！", {icon:6});
                    // 清空修改模态窗口的数据
                    $("#questionUpdateForm")[0].reset();
                    // 关闭模态窗口
                    $("#updateQuestionModal").modal("hide");

                    /*
						修改操作后，应该维持在当前页，维持每页展示的记录数
					*/
                    refresh($("#questionPage").bs_pagination('getOption', 'currentPage')
                        ,$("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
                },
                error : function ()
                {
                    layer.alert("添加试题失败！", {icon:2});
                }
            })
        })

        // 为全选按钮触发事件
        $("#qx").click(function ()
        {
            $("input[name=xz]").prop("checked", this.checked);
        })

        /*
            动态生成的元素（不能以普通绑定事件的形式来进行操作），我们要以on方法的形式来触发事件
            语法格式：$(需要绑定事件的外层元素).on("绑定事件的方式", 需要绑定的jquery对象, 回调函数)
         */
        $("#questionBody").on("click", $("input[name=xz]"), function ()
        {
            $("#qx").prop("checked", $("input[name=xz]").length==$("input[name=xz]:checked").length);
        })

    })


    // 定义一个函数，发送请求不同页码对应的数据
    function refresh(page, pageSize) {
        // 将全选按钮框的√去掉
        $("#qx").prop("checked", false);

        // 将查询文本框的信息存储到隐藏域中，方便进行查询操作
        $("#hidden_title").val($("#search_title").val());

        $.post("question/find.do", {
            "page": page,
            "pageSize": pageSize,
            "questionId": $("#hidden_questionId").val(),
            "title": $("#hidden_title").val()
        }, function (data) {
            /!*$("table tbody").html("");*!/
            // 清空questionBody的数据
            $("#questionBody").html("");
            var html = "";
            $.each(data.list, function (index, q) {
                html += '<tr>';
                html += '<td><input name="xz" type="checkbox" value="'+q.questionId+'"/></td>';
                /*html += '<td>' + q.questionId + '</td>';*/
                html += '<td>' + q.title + '</td>';
                html += '<td>' + q.optionA + '</td>';
                html += '<td>' + q.optionB + '</td>';
                html += '<td>' + q.optionC + '</td>';
                html += '<td>' + q.optionD + '</td>';
                html += '<td>' + q.answer + '</td>';
                html += '<td><img src="images/shanchu.png"  alt="删除信息" onclick="deleteById(' + q.questionId + ')"/></td>';
                html += '<td><img src="images/xiugai.png"  alt="修改信息" onclick="updateById(' + q.questionId + ')"/></td>';
                html += '</tr>';
            })
            $("#questionBody").html(html);

            //bootstrap的分页插件
            $("#questionPage").bs_pagination({
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
                    layer.alert("删除成功！", {icon:6});
                    /*
                        删除成功后，回到第一页，维持每页展示对的记录数
                     */
                    refresh(1, $("#questionPage").bs_pagination('getOption', 'rowsPerPage'));
                },
                error: function () {
                    layer.alert("删除失败！", {icon:2});
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
                <button type="button" class="btn btn-danger" id="deleteBt"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" id="addBt"><span class="glyphicon glyphicon-plus"></span> 创建</button>
            </div>
        </div>

        <div style="position: relative;top: 10px;">
            <table class="table table-hover" style="text-align: center">
                <thead>
                <tr>
                    <td><input type="checkbox" id="qx"/></td>
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
            <footer class="message_footer">
                <nav>
                    <%--分页插件--%>
                    <div  style="height: 50px; position: relative;top: 30px;">
                        <div id="questionPage"></div>
                    </div>
                </nav>
            </footer>
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