package com.taoge.filesystem;

import com.taoge.filesystem.util.ConfigConstant;
import com.taoge.filesystem.util.ProjectProperties;
import com.taoge.filesystem.util.SpringContextUtil;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@SpringBootApplication
public class HelloController {

    //分支1234
    //分支ppo
    //1234

    /**
     * 测试
     * @return
     */
    @RequestMapping("/")
    @ResponseBody
    String home() {
        return "Hello World!";
    }

    //wujiqiehuan

    /**
     * springboot启动类
     * @param args
     * @throws Exception
     */
    public static void main(String[] args) throws Exception {
        SpringApplication.run(HelloController.class, args);
        //从配置文件中读取ftp文件上传的相关配置，如果出现异常则直接使用预定义的
        ProjectProperties projectProperties= SpringContextUtil.getBean(ProjectProperties.class);
        if(projectProperties!=null&&projectProperties.getHost()!=null){
            ConfigConstant.host=projectProperties.getHost();
            ConfigConstant.port=Integer.parseInt(projectProperties.getPort());
            ConfigConstant.username=projectProperties.getUsername();
            ConfigConstant.password=projectProperties.getPassword();
            ConfigConstant.filepath=projectProperties.getFilepath();
            ConfigConstant.download=projectProperties.getDownload();
        }
    }

}