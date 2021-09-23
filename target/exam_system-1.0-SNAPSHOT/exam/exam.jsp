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
</head>
<body>
    <div>
        <div style="position: relative; left: 10px; top: -10px;">
            <div class="page-header">
                <h3>考试</h3>
            </div>
        </div>
    </div>

    <div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
        <div style="width: 100%; position: absolute;top: 5px; left: 10px;">


            <div style="position: relative;top: 10px;">
                <form action="exam/getScore.do">
                    <table border="2" style="text-align: center">
                        <tr>
                            <td>试题编号</td>
                            <td>题目信息</td>
                            <td>A</td>
                            <td>B</td>
                            <td>C</td>
                            <td>D</td>
                            <td>答案</td>
                        </tr>

                        <c:forEach items="${questionList}" var="question">
                            <tr>
                                <td>${question.questionId}</td>
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
                            <td align="center" colspan="3"><input type="submit" value="交卷"></td>
                            <td align="center" colspan="4"><input type="reset" value="重做"></td>
                        </tr>
                    </table>
                </form>
            </div>

        </div>
    </div>
</body>
</html>
