package com.my.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.my.entity.Question;
import com.my.entity.ReturnObject;
import com.my.entity.User;
import com.my.service.QuestionService;
import com.my.utils.HSSFUtils;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/question")
public class QuestionController {
    @Autowired
    private QuestionService questionService;

    // 修改试题信息
    @ResponseBody
    @RequestMapping(value = "/update.do")
    public void update(Question question) {
        boolean flag = questionService.update(question);
        return;
    }

    // 根据试题id返回试题信息
    @ResponseBody
    @RequestMapping(value = "/getById.do")
    public Question getById(Integer questionId) {
        Question question = questionService.getById(questionId);
        return question;
    }

    // 删除多个试题
    @ResponseBody
    @RequestMapping(value = "/delete.do")
    public void delete(String ids) {
        // 将字符串以','分割保存到数组中
        String[] d = ids.split(",");
        questionService.delete(d); //把数组里的值逗号隔开
        return;
    }

    // 删除单个试题
    @ResponseBody
    @RequestMapping(value = "/deleteById.do")
    public void deleteById(Integer questionId) {
        boolean flag = questionService.deleteById(questionId);
        return;
    }

    // 添加试题
    @ResponseBody
    @RequestMapping(value = "/save.do")
    public void save(Question question) {
        boolean flag = questionService.save(question);
        return;
    }

    // 根据条件查询试题
    @ResponseBody
    @RequestMapping(value = "/find.do")
    public PageInfo<Question> find(Integer page, Integer pageSize, Question question) {
        PageHelper.startPage(page, pageSize);
        List<Question> questionList = questionService.find(question);
        PageInfo<Question> pageInfo = new PageInfo<>(questionList);
        return pageInfo;
    }

    @RequestMapping("/exportAllQuestion.do")
    public void exportCheckedUsers(HttpServletResponse response) throws IOException {
        // 调用service层方法，查询所有的试题
        List<Question> questionList = questionService.findAllQuestions();
        // 创建excel文件，并且把questionList写入到excel文件中
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("试题信息列表");
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("ID");
        cell = row.createCell(1);
        cell.setCellValue("题目");
        cell = row.createCell(2);
        cell.setCellValue("A");
        cell = row.createCell(3);
        cell.setCellValue("B");
        cell = row.createCell(4);
        cell.setCellValue("C");
        cell = row.createCell(5);
        cell.setCellValue("D");
        cell = row.createCell(6);
        cell.setCellValue("答案");

        if (questionList != null && questionList.size() > 0){
            Question question = null;
            // 遍历activityList，创建HSSFRow对象，生成所有数据行
            for (int i = 0; i < questionList.size(); i++){
                question = questionList.get(i);
                // 每遍历一个question，生成一行
                row = sheet.createRow(i+1);
                cell = row.createCell(0);
                cell.setCellValue(question.getQuestionId());
                cell = row.createCell(1);
                cell.setCellValue(question.getTitle());
                cell = row.createCell(2);
                cell.setCellValue(question.getOptionA());
                cell = row.createCell(3);
                cell.setCellValue(question.getOptionB());
                cell = row.createCell(4);
                cell.setCellValue(question.getOptionC());
                cell = row.createCell(5);
                cell.setCellValue(question.getOptionD());
                cell = row.createCell(6);
                cell.setCellValue(question.getAnswer());
            }
        }

        // 把生成的excel文件下载到客户端
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=questionList.xls");
        OutputStream out = response.getOutputStream();

        wb.write(out);

        wb.close();
        out.flush();
    }

    @RequestMapping("/exportCheckedQuestion.do")
    public void exportCheckedQuestions(HttpServletResponse response, String[] id) throws IOException {
        // 调用service层方法，查询勾选的试题
        List<Question> questionList = questionService.findQuestionsByIds(id);
        // 创建excel文件，并且把questionList写入到excel文件中
        HSSFWorkbook wb = new HSSFWorkbook();
        HSSFSheet sheet = wb.createSheet("试题信息列表");
        HSSFRow row = sheet.createRow(0);
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("ID");
        cell = row.createCell(1);
        cell.setCellValue("题目");
        cell = row.createCell(2);
        cell.setCellValue("A");
        cell = row.createCell(3);
        cell.setCellValue("B");
        cell = row.createCell(4);
        cell.setCellValue("C");
        cell = row.createCell(5);
        cell.setCellValue("D");
        cell = row.createCell(6);
        cell.setCellValue("答案");

        if (questionList != null && questionList.size() > 0){
            Question question = null;
            // 遍历activityList，创建HSSFRow对象，生成所有数据行
            for (int i = 0; i < questionList.size(); i++){
                question = questionList.get(i);
                // 每遍历一个question，生成一行
                row = sheet.createRow(i+1);
                cell = row.createCell(0);
                cell.setCellValue(question.getQuestionId());
                cell = row.createCell(1);
                cell.setCellValue(question.getTitle());
                cell = row.createCell(2);
                cell.setCellValue(question.getOptionA());
                cell = row.createCell(3);
                cell.setCellValue(question.getOptionB());
                cell = row.createCell(4);
                cell.setCellValue(question.getOptionC());
                cell = row.createCell(5);
                cell.setCellValue(question.getOptionD());
                cell = row.createCell(6);
                cell.setCellValue(question.getAnswer());
            }
        }

        // 把生成的excel文件下载到客户端
        response.setContentType("application/octet-stream;charset=UTF-8");
        response.addHeader("Content-Disposition", "attachment;filename=questionList.xls");
        OutputStream out = response.getOutputStream();

        wb.write(out);

        wb.close();
        out.flush();
    }

    @RequestMapping("/importQuestion.do")
    @ResponseBody
    public Object importQuestion(MultipartFile questionFile){
        ReturnObject returnObject = new ReturnObject();

        try {
            InputStream is = questionFile.getInputStream();
            HSSFWorkbook wb = new HSSFWorkbook(is);
            HSSFSheet sheet = wb.getSheetAt(0); // 页的下标，下标从0开始，依次递增
            // 根据sheet获取HSSFRow对象，封装了一行所有的信息
            HSSFRow row = null;
            HSSFCell cell = null;
            Question question = null;
            List<Question> questionList = new ArrayList<>();
            for (int i = 1; i <= sheet.getLastRowNum(); i++){
                row = sheet.getRow(i);  // 行的下标，下标从0开始，依次增加
                question = new Question();
                for (int j = 0; j < row.getLastCellNum(); j++){
                    cell = row.getCell(j); // 列的下标，下标从0开始，依次增加
                    // 获取列中的数据
                    String cellValue = HSSFUtils.getCellValueForStr(cell);
                    if (j == 1){
                        question.setTitle(cellValue);
                    } else if (j == 2){
                        question.setOptionA(cellValue);
                    } else if (j == 3){
                        question.setOptionB(cellValue);
                    } else if (j == 4){
                        question.setOptionC(cellValue);
                    } else if (j == 5){
                        question.setOptionD(cellValue);
                    } else if (j == 6){
                        question.setAnswer(cellValue);
                    }
                }
                // 每一行中所有列封装完之后，把question保存到list中
                questionList.add(question);
            }

            // 调用service层方法，保存试题
            int result = questionService.saveQuestions(questionList);
            returnObject.setCode("1");
            returnObject.setMessage("成功导入"+result+"条数据");
        } catch (Exception e){
            returnObject.setCode("0");
            returnObject.setMessage("系统忙，请稍后重试...");
        }
        return returnObject;
    }
}
