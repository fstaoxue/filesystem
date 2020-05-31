package com.taoge.filesystem.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/gis")
public class MapController {

    @RequestMapping(value = "/map",method = RequestMethod.GET)
    public String toMap(){
        return "gis/map";
    }

}
