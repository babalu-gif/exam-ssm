package com.my.service;

import com.my.entity.Question;

import java.util.List;

public interface QuestionService
{
    List<Question> find(Question question);

    boolean save(Question question);

    boolean deleteById(Integer questionId);

    Question getById(Integer questionId);

    boolean update(Question question);

    Integer delete(String[] ids);
}
