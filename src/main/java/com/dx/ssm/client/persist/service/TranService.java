package com.dx.ssm.client.persist.service;


import com.alibaba.fastjson.JSONObject;
import com.dx.ssm.client.model.TranDO;
import com.dx.ssm.client.model.UserInfo;
import com.dx.ssm.client.persist.mapper.TranMapper;

import com.dx.ssm.client.persist.service.transaction.*;
import org.springframework.stereotype.Service;


import javax.annotation.Resource;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.text.SimpleDateFormat;
import java.util.*;


@Service
public class TranService {
    @Resource

    private TranMapper tranMapper;
    String [] prostr={"您的url链接正在分析中，请稍后...","url链接出错，请检查是否具有时效性。",
            "正在将您要分析的微博数据存入数据库，请耐心等待...","您要分析的微博数据存在异常,请联系工程师或重启分析。",
            "正在获取相关用户信息，请稍后...","您要分析的微博用户信息存在异常,请联系工程师或重启分析。",
             "数据分析中请稍后...","数据分析完毕,即将为您跳转页面..."};
    int progress=0;//用于查询数组中的某个字符串

   public void waitDisplay(int p,int ss){
       progress=p;
       try{
           Thread.sleep(1000*ss);
       }catch (Exception e){
           System.out.println("Got an exception!");
       }
   }

    //开启爬虫
    public JSONObject uploadInfo(String urlstr )  {
        JSONObject json=new JSONObject();
        urlstr="https://weibo.cn/comment/IwSOzvSAm?uid=2058586920&rl=0&page=2";
        String index="http://localhost:8080/client/";
        waitDisplay(0,3);
        //1.分析url
        String res[]=analyseUrl(urlstr);
        String article="";
        if(res==null){//分析url失败
            waitDisplay(1,3);
            json.put("resurl",index);
        }else{//调用python
            article=res[2];
            waitDisplay(2,3);
            if(true){//调用成功
                //继续获取用户信息
                waitDisplay(4,3);
                if(true){//获取用户信息成功
                    waitDisplay(6,3);
                    //生成table.json文件
                    //跳转页面
                    waitDisplay(7,3);
                    json.put("resurl","https://www.baidu.com/");
                }else{//获取用户信息失败
                    waitDisplay(5,3);
                    json.put("resurl",index);
                }
            }else{//python调用失败
                waitDisplay(3,3);
                json.put("resurl",index);

            }


            /*if(urlToPython(res)==0){//调用成功
                //继续获取用户信息
                progress=4;
                if(getUserInfo(article)==0){//获取用户信息成功
                    progress=6;
                    //生成table.json文件
                    getContent(article);
                    //跳转页面
                    progress=7;

                }else{//获取用户信息失败
                    progress=5;
                }

            }else{//python调用失败
                progress=3;
            }*/
        }
        return  json;
    }

    //调用python，启动爬虫，获取用户信息
    public  int getUserInfo(String table){
        return 0;
    }
    //调用python，启动爬虫，获取转发信息
    public  int urlToPython(String getUrl[]){
        String[] arguments = new String[] {"python", "E:\\大四下\\res\\pyfile\\connect\\testzhuanfa.py",getUrl[0],getUrl[1],getUrl[2]};
        try {
            Process process = Runtime.getRuntime().exec(arguments);
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"GBK"));
            //返回值为1表示调用python脚本失败，这和我们通常意义上见到的0与1定义正好相反
            int re = process.waitFor();
            return re;
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.toString());
        }
        return 1;
    }
    //分析url
    public  String[] analyseUrl (String urlstr){
        String uid="";
        String article="";
        //判断是https://weibo.com/开头还是https://weibo.cn/开头
        if(urlstr.startsWith("https://weibo.com/")){
            String string=urlstr.substring("https://weibo.com/".length());
            String str[]=string.split("/");
            uid=str[0];
            article=str[1].split("\\?")[0];
        }else if (urlstr.startsWith("https://weibo.cn/")){
            String string=urlstr.substring("https://weibo.cn/".length());
            String str[]=string.split("/");
            article=str[1].split("\\?")[0];
            String uidstr=string.split("&")[0];
            uid=uidstr.split("=")[1];
        }else{
            return null;

        }
        String url="https://weibo.cn/repost/"+article+"?uid="+uid;
        String s[]={url,uid,article};
        return s;
    }

    //返回爬虫的处理结果
    public JSONObject getProcess( ){
        JSONObject json=new JSONObject();
        json.put("progress",prostr[progress]);
        return  json;
    }





    /**
     * 返回一篇文章的评论内容的分析结果
     * @return
     */
    public JSONObject getContent(String article){
        JSONObject json=new JSONObject();
        String path="E:\\ideaproject\\client\\src\\main\\webapp\\json\\"+article+".json";
        File testFile = new File(path);
        if(!testFile.exists()){
            String[] arguments = new String[] {"python", "E:\\大四下\\res\\pyfile\\content\\finContent.py",article};
            try {
                Process process = Runtime.getRuntime().exec(arguments);
                BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream(),"GBK"));
                //返回值为1表示调用python脚本失败，这和我们通常意义上见到的0与1定义正好相反
                int re = process.waitFor();
                if(re==0){
                    json.put("success","file create");
                }else{
                    json.put("fail","python");
                }
            } catch (Exception e) {
                e.printStackTrace();
                System.out.println(e.toString());
                json.put("fail","exception");
            }
        }else{
            json.put("success","file exits");
        }
        return  json;
    }




    /**
     * 返回一篇文章的转发者信息
     * @return
     */
    public JSONObject attendPerson(String article){
        List<UserInfo> userInfos=tranMapper.attendPerson(article);
        HashMap proMap=new HashMap();
        ArrayList<SexInfo> sexInfo =new ArrayList<>();
        sexInfo.add(new SexInfo(0,"男"));
        sexInfo.add(new SexInfo(0,"女"));
        int []people={0,0,0,0,0,0,0,0};
        String p=null;String s=null;int f=0;
        for(int i=0;i<userInfos.size();i++){
            p=userInfos.get(i).getProvince();
            s=userInfos.get(i).getSex();
            f=userInfos.get(i).getFans();
            int posi=getPeople(f);
            people[posi]+=1;
            int countPro = proMap.containsKey(p) ? (int) proMap.get(p) : 0;
            proMap.put(p,countPro+1);
            if(s.contains("男")){
                sexInfo.get(0).setValue(sexInfo.get(0).getValue()+1);
            }else{
                sexInfo.get(1).setValue(sexInfo.get(1).getValue()+1);
            }
        }

        String peoStr=JSONObject.toJSONString(people);


        String sexJson=JSONObject.toJSONString(sexInfo);
        String map=JSONObject.toJSONString(getProvinces(proMap));
        proMap.remove("其他");
        JSONObject json=new JSONObject();
        json.put("map",map);
        json.put("provinceName",proMap.keySet());
        json.put("provinceCount",proMap.values());
        json.put("sex",sexJson);
        json.put("peopleCount",peoStr);
        return  json;
    }

    public int  getPeople(int fans){
    int posi=-1;
    if(fans<=49){
        posi=0;
    }else if(fans<=199){
        posi=1;
    }else if(fans<=499){
        posi=2;
    }else if(fans<=799){
        posi=3;
    }else if(fans<=999){
        posi=4;
    }else if(fans<=1599){
        posi=5;
    }else if(fans<=1999){
        posi=6;
    }else {
        posi=7;
    }
    return posi;
    }
    public ArrayList getProvinces(HashMap maps){
        ArrayList<Province> arrayList=new ArrayList<>();
        String []pNames={"南海诸岛","北京","天津","上海","重庆","河北","河南","云南","辽宁","黑龙江","湖南",
                "安徽","山东","新疆","江苏","浙江","江西","湖北","广西","甘肃","山西","内蒙古",
                "陕西","吉林","福建","贵州","广东","青海","西藏","四川","宁夏","海南","台湾","香港","澳门"};
        for(int i=0;i<pNames.length;i++){
            String pName=pNames[i];
            arrayList.add(new Province(pName,maps.containsKey(pName) ? (int) maps.get(pName) : 0));
        }
        return  arrayList;

    }

    /**
     * 返回一篇文章的被转发的路径
     * @return
     */
    public JSONObject queryPath(String article){
        List<TranDO> tranDOS=tranMapper.queryPath(article);
        HashMap userMap=new HashMap();
        for(int i=0;i<tranDOS.size();i++){
            userMap.put(tranDOS.get(i).getUid(),i);
        }

        List<Link> linklist = new ArrayList<Link>();
        List<Node> nodelist = new ArrayList<Node>();
        List<Category> strlist = new ArrayList<Category>();

        String str[]={"第一层","第二层","第三层","第四层","四层+"};
        TranDO tran=null;  int category=-1;int symbolSize=30;String name=null;String fromwho=null;
        boolean strbool[]={false,false,false,false,false};
        int size[]={30,12,18,16,6};
        for(int i=0;i<tranDOS.size();i++){
            tran=tranDOS.get(i);
            //size&&category
            category=tran.getLevel();
            if(category<=3){
                strbool[category]=true;
                symbolSize=size[category];
            }else{
                strbool[4]=true;
                symbolSize=size[4];
            }
            //name
            name=tran.getUname();

            //fromwho
            fromwho=tran.getFromwho();
            if(category!=0){
                Link link=new Link();
                link.setSource(i);
                int weight=2+category;
                try{
                    int temp=(int)userMap.get(fromwho);
                    link.setTarget(temp);

                }catch (Exception e){
                    link.setTarget(0);
                }
                link.setWeight(weight);
                linklist.add(link);
            }else{
                str[0]=name.substring(1,name.length()-1);
            }
            Node node=new Node();
            node.setCategory(category);
            node.setName(name.substring(1,name.length()-1));
           // node.setValue(i);
            node.setId(i);
            node.setSymbolSize(symbolSize);
            nodelist.add(node);

        }
        for(int i=0;i<strbool.length;i++){
            if(strbool[i]){
                Category categorie=new Category();
                categorie.setName(str[i]);
                strlist.add(categorie);
            }
        }



        String cateJson=JSONObject.toJSONString(strlist);
        String nodeJson=JSONObject.toJSONString(nodelist);
        String linkJson=JSONObject.toJSONString(linklist);

        JSONObject json=new JSONObject();
        json.put("nodes",nodeJson);
        json.put("links",linkJson);
        json.put("categories",cateJson);
        return  json;
    }

    /**
     * 返回一篇文章的被转发的层数
     * @return
     */
    public JSONObject queryLevelBar(String article){
        List<TranDO> tranDOS=tranMapper.queryLevelBar(article);
        String str[]={"第一层","第二层","第三层","第四层","四层+"};
        HashMap map=new HashMap();
        for(int i=0;i<tranDOS.size();i++){
            int level=tranDOS.get(i).getLevel();
            if(level!=0){
                if(level<=4){
                    int count = map.containsKey(str[level-1]) ? (int) map.get(str[level-1]) : 0;
                    map.put(str[level-1], count + 1);
                }else{
                    int count = map.containsKey(str[4]) ? (int) map.get(str[4]) : 0;
                    map.put(str[4], count + 1);
                }
            }
        }
        LinkedHashMap putMap=new LinkedHashMap();
        for(int i=0;i<5;i++){
            putMap.put(str[i],map.get(str[i]));
        }
        JSONObject json=new JSONObject();
        json.put("level",putMap.keySet());
        json.put("count",putMap.values());
        return  json;
    }

    /**
     * 返回该文章引爆点
     * @return
     */
    public JSONObject queryBombPoint(String article){

        List<TranDO> tranInfo=tranMapper.queryBombPoint(article);//包含用户信息

        List<TranDO>  tranDOS=tranMapper.queryBombs(article);
        List<Link> linklist = new ArrayList<Link>();
        List<Node> nodelist = new ArrayList<Node>();
        List<Category> strlist = new ArrayList<Category>();


        //引爆点分类
        Category categorie=new Category();
        categorie.setName("引爆点");
        strlist.add(categorie);
        categorie=null;
        categorie=new Category();
        categorie.setName("引爆信息");
        strlist.add(categorie);

        //加入首节点
        Node n=new Node();
        n.setId(0);
        n.setName("引爆点");
        n.setSymbolSize(50);
        n.setCategory(0);
        nodelist.add(n);
        //加入引爆各点和link
        int count=10;
        for(int i=1;i<=count;i++){
            Node nodes=new Node();
            boolean find=false;
            for(int j=0;j<tranInfo.size();j++){
                if(tranInfo.get(i).getUid().equals(tranDOS.get(i).getUid())){
                    find=true;
                    if(tranInfo.get(i).getUserInfo().getSex().contains("男")){
                        nodes.setCategory(1);
                    }else if(tranInfo.get(i).getUserInfo().getSex().contains("女")){
                        nodes.setCategory(2);
                    }
                    break;
                }
            }
           if(!find){
               nodes.setCategory(3);
           }
            nodes.setSymbolSize(20);
             String name=tranDOS.get(i).getUname();
             int fans=tranDOS.get(i).getFollows();
             String timeStr=tranDOS.get(i).getTimestr();
           nodes.setName(name+"\n"+"转发量:"+fans+"\n"+"发布时间"+timeStr.substring(0,timeStr.length()-3));
           nodes.setId(i);
           nodelist.add(nodes);


           Link link=new Link();
           link.setSource(0);
           link.setTarget(i);
           linklist.add(link);
        }


        String cateJson=JSONObject.toJSONString(strlist);
        String nodeJson=JSONObject.toJSONString(nodelist);
        String linkJson=JSONObject.toJSONString(linklist);

        JSONObject json=new JSONObject();
        json.put("nodes",nodeJson);
        json.put("links",linkJson);
        json.put("categories",cateJson);
        return  json;
    }

    /**
     * 返回该文章按照时间查询的结果
     * @return
     */
    public JSONObject queryByTime(String article){
        TreeMap map=new TreeMap();
        System.out.println("thisis"+article);
        List<TranDO> tranDOS=tranMapper.queryByTime(article);
        TranDO t=new TranDO();
        int max=1;
        HashMap hashMap=new HashMap();
        for(int i=0;i<tranDOS.size();i++){
            t=tranDOS.get(i);
            long longtime=t.getTime();
            String time=LongToString(longtime);
            String yu=""+(int)(longtime/1800000);//以十分钟为间隔
            int counts = hashMap.containsKey(yu) ? (int) hashMap.get(yu) : 0;
            hashMap.put(yu, counts +1);
            map.put(time, counts + 1);

            /*int count = map.containsKey(time) ? (int) map.get(time) : 0;
            if((count+1)>max){
                max=count+1;
            }
            map.put(time, count + 1);*/
        }
        JSONObject json=new JSONObject();
        json.put("time",map.keySet());
        json.put("count",map.values());
        return  json;
    }
    public static String LongToString(long time){
        String DATE_FORMAT= "yyyy-MM-dd HH:mm:ss";
        if (time > 0l) {
            SimpleDateFormat sf = new SimpleDateFormat(DATE_FORMAT);
            Date date = new Date(time);
            return sf.format(date);
        }
        return "";

    }
    /**
     * 返回该文章的发布者，内容
     * @return
     */
    public TranDO queryFromWho(String tablename,String article){

        return tranMapper.queryFromWho(tablename,article);
    }



}
