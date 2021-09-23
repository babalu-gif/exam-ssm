package com.my.dao;

import com.my.entity.Question;

import java.util.List;

public interface QuestionDao
{
    List<Question> find(Question question);

    int save(Question question);

    int deleteById(Integer questionId);

    Question getById(Integer questionId);

    int update(Question question);
}
