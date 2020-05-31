package com.taoge.filesystem.controller;

import com.alibaba.fastjson.JSONObject;
import com.taoge.filesystem.entity.UploadFile;
import com.taoge.filesystem.repository.FileRepository;
import com.taoge.filesystem.util.FtpUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

@Controller
public class FileController {

    private Logger logger=LoggerFactory.getLogger(FileController.class);

    @Autowired
    private FileRepository fileRepository;


    /**
     * 获取服务器时间（主要用于测试前后端通信）
     * @return
     */
    @RequestMapping(value = "/getTime",method = RequestMethod.POST)
    @ResponseBody
    public String getTime(){
        long time=System.currentTimeMillis()/1000;
        logger.info("获取当前时间戳:"+time);
        return time+"";
    }

    @PostMapping("/uploadProgress")
    @ResponseBody
    public JSONObject uploadProgress(@RequestParam("file") MultipartFile file){
        JSONObject result=new JSONObject();
        Path path= Paths.get("D:\\temp\\"+file.getOriginalFilename());
        try {
            file.transferTo(path);
            result.put("status","success");
            result.put("code","200");
        } catch (IOException e) {
            e.printStackTrace();
            result.put("status","failed");
            result.put("code","404");
        }
        return result;
    }

    /**
     * 文件上传（不跨域）
     * @param file
     * @param request
     * @return
     */
    @RequestMapping(value = "/uploadForLocal",method = RequestMethod.POST)
    @ResponseBody
    public JSONObject upload(MultipartFile file,String fileDir, HttpServletRequest request){
        if(fileDir==null||fileDir.equals("")){
            fileDir="temp";
        }
        logger.info("文件上传(不跨域)已经达到后台！");
        JSONObject result=new JSONObject();
        result.put("status","failed");
        String contentType=file.getContentType();
        String filename=file.getOriginalFilename();
        logger.info("文件格式"+contentType+",文件名称"+filename);
        try {
            byte[] data=file.getBytes();
            result=FtpUtil.saveFile(fileDir,filename,data);
            insertRecord(result.getJSONObject("data"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 文件上传（跨域）为其他项目提供统一的上传服务
     * @param file
     * @param response
     */
    @RequestMapping(value = "/uploadForRemote",method = RequestMethod.POST)
    @ResponseBody
    public void upload4(@RequestParam("uploadFile")MultipartFile file,String fileDir, HttpServletResponse response){
        if(fileDir==null||fileDir.equals("")){
            fileDir="temp";
        }
        response.setHeader("Access-Control-Allow-Origin","*");
        response.setCharacterEncoding("UTF-8");
        JSONObject result=new JSONObject();
        result.put("status","failed");
        String contentType=file.getContentType();
        String filename=file.getOriginalFilename();
        logger.info("文件格式"+contentType+",文件名称"+filename);
        try {
            byte[] data=file.getBytes();
            result=FtpUtil.saveFile(fileDir,filename,data);
            insertRecord(result.getJSONObject("data"));
        } catch (IOException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
        try {
            response.getWriter().write(result.toJSONString());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 将所有的上传操作都记录到数据库中
     * @param object
     */
    private void insertRecord(JSONObject object){
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Random random=new Random();
        String filename=object.getString("filename");
        String url=object.getString("url");
        int size=object.getInteger("size");
        UploadFile file=new UploadFile();
        file.setFilename(filename);
        file.setUrl(url);
        file.setTime(sdf.format(new Date()));
        file.setUsername("saoliang"+random.nextInt(10000));
        file.setType("文档");
        fileRepository.save(file);

    }

    /**
     * 获取所有文件上传记录（分页）
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping(value="/getAllFiles",method = RequestMethod.GET)
    @ResponseBody
    public String getAllFiles(String page,String limit){
        Pageable pageable=PageRequest.of(Integer.parseInt(page)-1,Integer.parseInt(limit),Sort.by(Sort.Order.desc("id")));
        Page<UploadFile> files=fileRepository.findAll(pageable);

        JSONObject object=new JSONObject();
        object.put("code",0);
        object.put("msg","");
        object.put("count",files.getTotalElements());
        object.put("data",files.getContent());

        return object.toJSONString();
    }

    @RequestMapping(value="/delFileById",method = RequestMethod.GET)
    @ResponseBody
    public void deleFileById(int fileId,String filename){
        fileRepository.deleteById(fileId);
        FtpUtil.delFile(filename);
    }



}
