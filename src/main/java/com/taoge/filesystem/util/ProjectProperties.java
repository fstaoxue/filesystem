package com.taoge.filesystem.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@Configuration
@PropertySource("classpath:ftp.properties")
public class ProjectProperties {
    @Value("${ftp_host}")
    private String host;
    @Value("${ftp_port}")
    private String port;
    @Value("${ftp_username}")
    private String username;
    @Value("${ftp_password}")
    private String password;
    @Value("${ftp_filepath}")
    private String filepath;

    @Value("${ftp_download}")
    private String download;

    public String getDownload() {
        return download;
    }

    public void setDownload(String download) {
        this.download = download;
    }

    public String getFilepath() {
        return filepath;
    }

    public void setFilepath(String filepath) {
        this.filepath = filepath;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public String getPort() {
        return port;
    }

    public void setPort(String port) {
        this.port = port;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
