package com.my.service.impl;

import com.my.dao.QuestionDao;
import com.my.entity.Question;
import com.my.service.QuestionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService
{
    @Autowired
    private QuestionDao questionDao;

    @Override
    public Integer delete(String[] ids)
    {
        // 删除试题信息
        return questionDao.delete(ids);
    }

    @Override
    public boolean update(Question question)
    {
        boolean flag = true;
        int count = questionDao.update(question);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public Question getById(Integer questionId)
    {
        Question question = questionDao.getById(questionId);
        return question;
    }

    @Override
    public boolean deleteById(Integer questionId)
    {
        boolean flag = true;
        int count = questionDao.deleteById(questionId);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean save(Question question)
    {
        boolean flag = true;
        int count = questionDao.save(question);
        if(count != 1)
        {
            flag = false;
        }
        return flag;
    }

    @Override
    public List<Question> find(Question question)
    {
        List<Question> questionList = questionDao.find(question);
        return questionList;
    }
}
