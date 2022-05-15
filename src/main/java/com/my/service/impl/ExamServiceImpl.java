package com.my.service.impl;

import com.my.dao.ExamDao;
import com.my.entity.Question;
import com.my.service.ExamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ExamServiceImpl implements ExamService {
    @Autowired
    private ExamDao questionDao;

    @Override
    public List<Question> getRand() {
        List<Question> questionList = questionDao.getRand();
        return questionList;
    }
}
