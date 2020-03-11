package com.dx.ssm.client.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dx.ssm.client.model.TranDO;
import com.dx.ssm.client.model.domain.UserDO;
import com.dx.ssm.client.persist.service.TranService;
import com.dx.ssm.client.persist.service.UserService;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.io.UnsupportedEncodingException;
import java.util.List;

/**
 * @author daxia
 */
@Controller
@RequestMapping("/")
public class CustomController {

    @Resource
    private UserService userService;
    @Resource
    private TranService tranService;


    /**test.jsp
     * @return
     */
    @RequestMapping("/test")
    public String test()
    {
        // 动态跳转页面
        return "test";
    }



    /**返回tran.jsp
     * @return
     */
    @RequestMapping("/tran")
    public String tran()
    {
        // 动态跳转页面
        return "tran";
    }

    /**返回bomb.jsp
     * @return
     */
    @RequestMapping("/bomb")
    public String bomb()
    {
        // 动态跳转页面
        return "bomb";
    }

    /**返回path.jsp
     * @return
     */
    @RequestMapping("/path")
    public String path()
    {
        // 动态跳转页面
        return "path";
    }

       /**返回attend.jsp
     * @return
     */
    @RequestMapping("/attend")
    public String attend()
    {
        // 动态跳转页面
        return "attend";
    }

    /**返回content.jsp
     * @return
     */
    @RequestMapping("/content")
    public String content()
    {
        // 动态跳转页面
        return "content";
    }

    /**返回water.jsp
     * @return
     */
    @RequestMapping("/water")
    public String water()
    {
        // 动态跳转页面
        return "water";
    }


    /**
     * 开启爬虫
     * @return
     */
    @RequestMapping("/test/uploadInfo")
    @ResponseBody
    public String uploadInfo(String urlstr){
        String res=JSON.toJSONString(tranService.uploadInfo(urlstr));
        System.out.println("uploadInfo:"+res);
        return res;
    }



    /**
     * 返回爬虫的处理结果
     * @return
     */
    @RequestMapping("/getProcess")
    @ResponseBody
    public String getProcess(){
        String res=JSON.toJSONString(tranService.getProcess());
        System.out.println("getProcess:"+res);
        return res;
    }



    /**
     * 返回一篇文章的评论内容
     * @return
     */
    @RequestMapping("/getContent")
    @ResponseBody
    public String getContent(String article){
        String res=JSON.toJSONString(tranService.getContent(article));
        System.out.println("getContent:"+res);
        return res;
    }


    /**
     * 返回一篇文章的转发者信息
     * @return
     */
    @RequestMapping("/attendPerson")
    @ResponseBody
    public String attendPerson(String article){
        String res=JSON.toJSONString(tranService.attendPerson(article));
        System.out.println("attendPerson:"+res);
        return res;
    }

    /**
     * 返回一篇文章的被转发的路径
     * @return
     */
    @RequestMapping("/queryPath")
    @ResponseBody
    public String queryPath(String article){
        String res=JSON.toJSONString(tranService.queryPath(article));
        System.out.println("queryPath:"+res);
        return res;
    }

    /**
     * 返回一篇文章的被转发的层数
     * @return
     */
    @RequestMapping("/queryLevelBar")
    @ResponseBody
    public String queryLevelBar(String article){
        String res=JSON.toJSONString(tranService.queryLevelBar(article));
        System.out.println("queryLevelBar:"+res);
        return res;
    }

    /**
     * 返回一篇文章的所有评论
     * @return
     */
    @RequestMapping("/queryBombPoint")
    @ResponseBody
    public String queryBombPoint(String article){
        String res=JSON.toJSONString(tranService.queryBombPoint(article));
        System.out.println("queryBombPoint:"+res);
        return res;
    }


    /**
     * 返回一篇文章的所有评论
     * @return
     */
    @RequestMapping("/queryByTime")
    @ResponseBody
    public String queryByTime(String article){
        String res=JSON.toJSONString(tranService.queryByTime(article));
        System.out.println("queryByTime:"+res);
        return res;
    }


    /**
     * 返回该文章的发布者，内容
     * @return
     */
    @RequestMapping("/queryFromWho")
    @ResponseBody
    public String queryFromWho(String article){
        String res=JSON.toJSONString(tranService.queryFromWho(article,article));
        System.out.println("queryByTime:"+res);
        return res;
    }


    /**
            * 查 所有用户
     * @return
             */
    @RequestMapping("/listUsers")
    @ResponseBody
    public String listUsers(){
        return JSON.toJSONString(userService.listUsers());
    }

    /**
     * 查 按条件查用户
     * @return
     */
    @RequestMapping("/listUserByUserName")
    @ResponseBody
    public String listUserByUserName(String userName) throws UnsupportedEncodingException {
        String result = new String(JSON.toJSONString(userService.listUserByUserName(userName)).getBytes("iso-8859-1"),"UTF-8");
        System.out.println(result);
        return result;
    }

    /**
     * 删 按id删除
     * @return
     */
    @RequestMapping("/removeUserById")
    public String removeUserById(@Param("id") int id){
        userService.removeUserById(id);
        return"index";
    }

    /**
     * 增 添加用户
     * @return
     */
    @RequestMapping("/saveUser")
    public String saveUser(UserDO user){
        UserDO exist = userService.getUserByIrd(user.getId());
        if(exist==null){
            System.out.println(user.getUserName()+user.getUserPassword());
            userService.saveUser(user);
        }else{
            System.out.println(user.getUserName()+user.getUserPassword());
            userService.updateUser(user);
        }
        return"index";
    }

}

