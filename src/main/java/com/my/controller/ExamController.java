package com.my.controller;

import com.my.entity.Question;
import com.my.entity.User;
import com.my.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping(value = "/exam")
public class ExamController {
    @Autowired
    private ExamService questionService;

    @RequestMapping(value = "/exam.do")
    public String getRandQuestion(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        List<Question> questionList = questionService.getRand();
        session.setAttribute("questionList", questionList);
        return "forward:/exam/exam.jsp";
    }

    @RequestMapping(value = "/getScore.do")
    public String getScore(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        // 从当前用户私人储物柜得到系统提供的四种题目信息
        List<Question> questions = (List<Question>) session.getAttribute("questionList");

        int score = 0;
        for(Question question : questions) {
            Integer questionId = question.getQuestionId();
            String answer = question.getAnswer();
            String userAnswer = request.getParameter("answer_"+questionId);
            // 判分
            if(answer.equals(userAnswer)) { // 防止用户不选择，出现空指针异常
                score += 25;
            }
        }

        String username = ((User) session.getAttribute("user")).getUser_Name();
        // 将分数写到request中，作为共享数据
        request.setAttribute("info", username + "，您本次考试成绩："+score);
        // 请求转发调用jsp将用户本次考试分数写入到响应体
        return "forward:/exam/info.jsp";
    }
}
