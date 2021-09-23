package com.my.controller;

import com.my.entity.Question;
import com.my.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
@RequestMapping(value = "/question")
public class QuestionController
{
    @Autowired
    private QuestionService questionService;

    // 修改试题信息
    @ResponseBody
    @RequestMapping(value = "/update.do")
    public void update(Question question)
    {
        boolean flag = questionService.update(question);
        return;
    }

    // 根据试题id返回试题信息
    @ResponseBody
    @RequestMapping(value = "/getById.do")
    public Question getById(Integer questionId)
    {
        Question question = questionService.getById(questionId);
        return question;
    }

    // 删除试题
    @ResponseBody
    @RequestMapping(value = "/deleteById.do")
    public void deleteById(Integer questionId)
    {
        boolean flag = questionService.deleteById(questionId);
        return;
    }

    // 添加试题
    @ResponseBody
    @RequestMapping(value = "/save.do")
    public void save(Question question)
    {
        boolean flag = questionService.save(question);
        return;
    }

    // 根据条件查询试题
    @ResponseBody
    @RequestMapping(value = "/find.do")
    public List<Question> find(Question question)
    {
        List<Question> questionList = questionService.find(question);
        return questionList;
    }
}
