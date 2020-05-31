package com.taoge.filesystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageController {

    /**
     * 主页跳转
     * @return
     */
    @RequestMapping(value="/index",method = RequestMethod.GET)
    public String toindex(){
        return "index";
    }

    /**
     * 上传功能页面跳转
     * @return
     */
    @RequestMapping(value="/upload",method = RequestMethod.GET)
    public String toupload(){
        return "upload";
    }

    @GetMapping("/uploadProgress")
    public String uploadProgress(){
        return "upload_progress";
    }

    /**
     * 上传测试页面跳转
     * @return
     */
    @RequestMapping(value="/uploadForTest",method = RequestMethod.GET)
    public String touploadTest(){
        return "uploadForTest";
    }

    /**
     * 欢迎页跳转
     * @return
     */
    @RequestMapping(value="/welcome",method = RequestMethod.GET)
    public String towelcome(){
        return "welcome";
    }


    /**
     * 展示页面（显示所有上传文件列表）
     * @return
     */
    @RequestMapping(value="/show",method = RequestMethod.GET)
    public String showFile(){
        return "fileList";
    }

    /**
     * 打点页面跳转
     * @return
     */
    @RequestMapping(value="/showPoint",method = RequestMethod.GET)
    public String showPoints(){
        return "showPoint";
    }

    /**
     * 坐标系转换页面跳转
     * @return
     */
    @RequestMapping(value = "/convert",method = RequestMethod.GET)
    public String toConvert(){
        return "gis/convert";
    }

}
