<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String base = request.getContextPath() + "/";
    String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + base;
%>
<html>
<head>
    <base href="<%=url%>">
    <title>Title</title>
    <link rel="stylesheet" href="css/bootstrap.css" />
    <script type="text/javascript" src="jquery/jquery-2.1.1.min.js"></script>
    <script type="text/javascript" src="jquery/bootstrap.js"></script>
    <script type="text/javascript" src="jquery/layer-3.5.1/layer.js"></script>
</head>
<style>
    .app{
        font-size:40px;
        font-family:"微软雅黑";
        font-style:oblique;
        color:black;
    }
</style>
<script type="text/javascript">
     var maxtime = 3 * 60; //一个小时，按秒计算，自己调整!
     function CountDown() {
        if (maxtime >= 0) {
            minutes = Math.floor(maxtime / 60);
            seconds = Math.floor(maxtime % 60);
            msg = "距离结束还有" + minutes + "分" + seconds + "秒";
            document.all["timer"].innerHTML = msg;
            if (maxtime == 1 * 60)
                layer.alert("还剩1分钟", {icon: 7});
               --maxtime;
       } else{
           clearInterval(timer);
            layer.alert("时间到，结束!", {icon: 6});
            document.location.href="exam/getScore.do";
        }
     }
     timer = setInterval("CountDown()", 1000);
</script>

<body>
    <div id="timer" style="color:red; position: center"></div>
    <div>
        <div style="position: relative; left: 10px; top: -10px;">
            <div class="page-header">
                <h3>考试</h3>
            </div>
        </div>
    </div>

    <br/><br/><br/><br/>

    <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
        <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

            <div class="btn-toolbar" role="toolbar" style="height: 80px;" align="center">
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon app">题目</div>
                    </div>
                </div>
            </div>


            <div style="position: relative;top: 10px;" align="center">
                <form action="exam/getScore.do">
                    <table border="2" class="table table-hover" style="text-align: center">
                        <tr>
                            <td>题目信息</td>
                            <td>A</td>
                            <td>B</td>
                            <td>C</td>
                            <td>D</td>
                            <td>答案</td>
                        </tr>

                        <c:forEach items="${questionList}" var="question">
                            <tr>
                                <td>${question.title}</td>
                                <td>${question.optionA}</td>
                                <td>${question.optionB}</td>
                                <td>${question.optionC}</td>
                                <td>${question.optionD}</td>
                                <td>
                                    <input type="radio" name="answer_${question.questionId}" value="A"/>A
                                    <input type="radio" name="answer_${question.questionId}" value="B"/>B
                                    <input type="radio" name="answer_${question.questionId}" value="C"/>C
                                    <input type="radio" name="answer_${question.questionId}" value="D"/>D
                                </td>
                            </tr>
                        </c:forEach>

                        <tr>
                            <td align="center" colspan="3"><input id="sure" type="submit" value="交卷"></td>
                            <td align="center" colspan="4"><input type="reset" value="重做"></td>
                        </tr>
                    </table>
                </form>
            </div>

        </div>
    </div>
</body>
</html>
