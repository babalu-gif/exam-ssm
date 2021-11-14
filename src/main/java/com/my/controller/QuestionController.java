package com.my.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.my.entity.Question;
import com.my.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
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

    // 删除多个试题
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public void delete(String ids)
    {
        String[] d = ids.split(",");
        questionService.delete(d); //把数组里的值逗号隔开
        return;
    }

    // 删除单个试题
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
    public PageInfo<Question> find(Integer page, Integer pageSize, Question question)
    {
        PageHelper.startPage(page, pageSize);
        List<Question> questionList = questionService.find(question);
        PageInfo<Question> pageInfo = new PageInfo<>(questionList);
        return pageInfo;
    }
}
