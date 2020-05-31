package com.taoge.filesystem.util;

import com.alibaba.fastjson.JSONObject;
import com.jcraft.jsch.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.util.Properties;

/**
 * 文件上传至nginx工具类
 */
public class FtpUtil {

    private static Logger logger=LoggerFactory.getLogger(FtpUtil.class);

    /**
     * 文件保存至nginx服务器
     * @param fileName
     * @param data
     * @return
     * @throws SftpException
     */
    public static JSONObject saveFile(String fileDir,String fileName, byte[] data) throws SftpException {
        JSONObject result=new JSONObject();
        result.put("code","404");
        result.put("msg","failed");
        if(null != data){
            //写入结果文件到nginx静态文件目录
            System.out.println("输出结果文件--------------");
            ChannelSftp sftp = connect(ConfigConstant.host,ConfigConstant.port,ConfigConstant.username,ConfigConstant.password);
            if(null != sftp){
                logger.info("==========" + fileName);
                String d1=getParentPath(fileName);
                try{
                    createDir(ConfigConstant.filepath+fileDir+"/"+d1, sftp);
                    sftp.cd(ConfigConstant.filepath+fileDir+"/"+d1);
                    int repeatCount=1;
                    String tempFileName=fileName;
                    while(isFileExist(ConfigConstant.filepath+fileDir+"/"+d1,tempFileName,sftp)){
                        tempFileName="副本"+repeatCount+"_"+fileName;
                        repeatCount++;
                    }
                    fileName=tempFileName;
                    InputStream inputStream = new ByteArrayInputStream(data);
                    sftp.put(inputStream, fileName);
                    logger.info("文件保存完毕--------------");
                    String url=ConfigConstant.download+fileDir+"/"+d1+fileName;
                    JSONObject tempData=new JSONObject();
                    tempData.put("status","success");
                    tempData.put("url",url);
                    tempData.put("filename",fileName);
                    tempData.put("size",data.length);
                    result.put("data",tempData);
                    result.put("code","200");
                    result.put("msg","success");
                }catch (Exception e){
                    result.put("code","404");
                    result.put("msg","failed");
                }
            }
        }
        return result;
    }

    public static boolean delFile(String fileName) {
        try{
            ChannelSftp sftp = connect(ConfigConstant.host,ConfigConstant.port,ConfigConstant.username,ConfigConstant.password);
            boolean result=delFile(fileName,sftp);
            return result;
        }catch(Exception e){
            return false;
        }

    }

    /**
     * main方法测试类
     */
//    public static void main(String[] args) {
//        byte[] datas="tasxdbhjqwdbcuyh".getBytes();
//        try {
//            String result=FtpUtil.saveFile("yyy",datas);
//            System.out.println(result);
//        } catch (SftpException e) {
//            e.printStackTrace();
//        }
//        System.out.println("结束");
//    }


    /**
     * 获取sftp连接
     * @param host
     * @param port
     * @param username
     * @param password
     * @return
     */
    @SuppressWarnings("all")
    private static ChannelSftp connect(String host , Integer port, String username, String password){
        ChannelSftp sftp = null;

        try{

            JSch jsch = new JSch();
            jsch.getSession(username, host, port);
            Session sshSession = jsch.getSession(username,host,port);
            sshSession.setPassword(password);
            Properties sshConfig = new Properties();
            sshConfig.put("StrictHostKeyChecking", "no");
            sshSession.setConfig(sshConfig);
            sshSession.connect();
            Channel channel = sshSession.openChannel("sftp");
            channel.connect();
            sftp= (ChannelSftp)channel;
        }catch(Exception e){
            e.printStackTrace();
        }

        return sftp;
    }

    /**
     * 创建文件目录
     * @param createPath
     * @param sftp
     */
    @SuppressWarnings("all")
    private static void createDir(String createPath, ChannelSftp sftp) {
        try {
            if(!isDirExist(createPath,sftp)){
                String pathArry[] =createPath.split("/");
                StringBuffer filePath = new StringBuffer("/");
                for (String path:pathArry){
                    if("".equals(path)) continue;
                    filePath.append(path+"/");
                    if(!isDirExist(filePath.toString(),sftp)){
                        //建立目录
                        sftp.mkdir(filePath.toString());
                        sftp.cd(filePath.toString());
                    }
                }

            }
        }catch(SftpException e){
            e.printStackTrace();
        }
    }

    /**
     * 判断文件目录是否存在
     * @param directoty
     * @param sftp
     * @return
     */
    @SuppressWarnings("all")
    private static  boolean isDirExist(String directoty, ChannelSftp sftp){
        boolean isDirExistFlag  = false;
        try {
            SftpATTRS sftpATTRS = sftp.lstat(directoty);
            isDirExistFlag =true;
            return  sftpATTRS.isDir();
        }catch (Exception e){
            if(e.getMessage().toLowerCase().equals("no such file")){
                isDirExistFlag  = false;
            }
        }
        return isDirExistFlag;
    }
    /**
     * 判断文件目录是否存在
     * @param directoty
     * @param sftp
     * @return
     */
    @SuppressWarnings("all")
    private static  boolean isFileExist(String directoty,String filename, ChannelSftp sftp){
        boolean isFileExistFlag  = false;
        try {
            SftpATTRS sftpATTRS = sftp.lstat(directoty+"/"+filename);
            isFileExistFlag =true;
        }catch (Exception e){
            if(e.getMessage().toLowerCase().equals("no such file")){
                isFileExistFlag  = false;
            }
        }
        return isFileExistFlag;
    }


    /**
     * 删除文件
     * @param sftp
     * @return
     */
    private static  boolean delFile(String filename, ChannelSftp sftp){
        try {
            String d1=getParentPath(filename);
            sftp.cd(ConfigConstant.filepath+d1);
            sftp.rm(filename);
        } catch (SftpException e) {
            return false;
        }
        return true;
    }


    /**
     * 目录分离算法:为文件创建二级目录
     *
     * @param filename
     * @return
     */
    public static String getParentPath(String filename) {
        int code1 = filename.hashCode();
        int d1 = Math.abs(code1%10);
        return d1 + "/";
    }

    /**
     * 将文件名中的汉字转Unicode
     * @param s
     * @return
     */
    public static String toUnicode(String s){
        String as[] = new String[s.length()];
        String s1="";
        for (int i = 0; i < s.length() ; i++) {
            as[i] = Integer.toHexString(s.charAt(i) & 0xffff);
            s1=s1+as[i];
        }
        return s1;
    }

}
