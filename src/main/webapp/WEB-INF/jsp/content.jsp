<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/contentstyle.css" />
<script src="js/jquery-3.4.1.js"></script>
<script src="js/jquery-3.4.1.min.js"></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
 <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>
 <script src="js/echarts-wordcloud.js"></script>
<script src="js/dark.js" type="text/javascript"></script>
<script src="js/vintage.js" type="text/javascript"></script>
<title>微博信息传播分析系统</title>
</head>
<%
   String article=request.getParameter("article");
   String tran_url="http://localhost:8080/client/tran?article="+article;
   String path_url="http://localhost:8080/client/path?article="+article;
   String bomb_url="http://localhost:8080/client/bomb?article="+article;
   String attend_url="http://localhost:8080/client/attend?article="+article;
   String content_url="http://localhost:8080/client/content?article="+article;

 %>
<body>
<div class="top" >
  <center><h1><b><font color="grey">微博信息传播分析系统</font></b></h1></center>
</div>
<div class="middle">
<div class="left">

  <ul class="nav nav-list">
    <li class="nav-header"> <a href="#"> <img src="pic/all.png"  alt=" 总览" />&nbsp; 总览 </a> </li>
    <li> <a href= "<%=tran_url%>"><img src="pic/trans.png"  alt="传播分析" /><i class="tran_analyse"> </i> 传播分析 </a> </li>
    <li > <a href= "<%=path_url%>" > <img src="pic/path.png"  alt="传播路径" /><i class="tran_path"> </i> 传播路径 </a> </li>
    <li> <a href="<%=attend_url%>">  <img src="pic/attend.png"  alt="参与者信息" /> <i class="attend_info"> </i> 参与者信息 </a> </li>
    <li> <a href="<%=bomb_url%>"> <img src="pic/bomb.png"  alt="引爆点" /><i class="bomb_point"> </i> 引爆点 </a> </li>
    <li> <a href="#"> <img src="pic/water.png"  alt="水军分析" /><i class="water_anamy"> </i> 水军分析 </a> </li>
    <li> <a href="<%=content_url%>"> <img src="pic/content.png"  alt="内容分析" /><i class="content-analyse"> </i>内容分析</a> </li>
  </ul>
</div>
<div class="right"  >
    <div class="right_info">
        <div class="right_info_person">
            <div class="right_info_pic" >
                <img src="pic/touxiang.png"  alt="头像" />
            </div>
             <div class="right_info_name">
                <center><b></b></center>
            </div>
        </div>
        <div class="right_info_content">
        <p>    </p>
        </div>
    </div>
    <div class="right_content">
        <div class="right_left"  >
            <div class="right_left_top" >
                <div class="right_left_top_label"><center>情感值</center></div>
                <div class="right_left_top_image" id="gauge"></div>
            </div>
            <div class="right_left_bot">
                <div class="right_left_bot_label"><center>关键词</center></div>
                <div class="right_left_bot_image"  id="word"></div>
            </div>
        </div>
        <div class="right_right">
             <div class="right_label">

                   <h6><center>高频词：</center></h6>
                   <button type="button" class="btn btn-w3r btn-sm" id="b0" title="测试" onclick="btnToTable('0')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b1" title="测试" onclick="btnToTable('1')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b2" title="测试" onclick="btnToTable('2')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b3" title="测试" onclick="btnToTable('3')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b4" title="测试" onclick="btnToTable('4')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b5" title="测试" onclick="btnToTable('5')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b6" title="测试" onclick="btnToTable('6')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b7" title="测试" onclick="btnToTable('7')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b8" title="测试" onclick="btnToTable('8')">信息</button>
                   <button type="button" class="btn btn-w3r btn-sm" id="b9" title="测试" onclick="btnToTable('9')">信息</button>

                    <button type="button" class="btn btn-w3r btn-sm" id="b10" title="测试" onclick="btnToTable('10')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b11" title="测试" onclick="btnToTable('11')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b12" title="测试" onclick="btnToTable('12')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b13" title="测试" onclick="btnToTable('13')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b14" title="测试" onclick="btnToTable('14')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b15" title="测试" onclick="btnToTable('15')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b16" title="测试" onclick="btnToTable('16')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b17" title="测试" onclick="btnToTable('17')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b18" title="测试" onclick="btnToTable('18')">信息</button>
                    <button type="button" class="btn btn-w3r btn-sm" id="b19" title="测试" onclick="btnToTable('19')">信息</button>

             </div>
             <div class="right_url">
                <div class="right_url_table" >
                    <table class="table table-striped" id="tabledata">
                        <caption><center><b><font color="black">友情提示:点击高频词显示提及微博</font></b></center></caption>
                        <thead>
                        <tr>
                            <th><center>昵称</center></th>
                            <th><center>二次转发</center></th>
                            <th><center>转发时间</center></th>
                            <th><center>微博地址</center></th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                     </table>
                </div>
             </div>
        </div>
    </div>
</div>
</div>

<script type="text/javascript">
changeBar(6);
var msg;
var user;//关键词对应的评论信息
$(document).ready(function(){
    var art='<%=article%>'
    queryFromWho(art);
    $.post("getContent",{article:art},function (msg) {
             var fileName="json/"+'<%=article%>'+".json"
                //获取数据
                $.getJSON (fileName,  "", function (data)
                {
                    msg=data;
                   user=msg.infos
                    //设置词云
                    word(msg.words);

                    //设置仪表盘的情感值
                    gauge(msg.emotion);

                    //设置表格
                    var msgCount=0;
                    setTableInfo(msgCount);

                    //设置btn标签
                     changeBtnName( msg.label);
                });
        });
});
//左侧功能栏的选中状态
function changeBar(posi){
    var bar= $("li").eq(posi);
    bar.css('background-color', '#b0c4de');
}

function queryFromWho(art){
    $.post("queryFromWho",{tablename:art,article:art},function (msg) {
        var info = JSON.parse(msg);
        var name =info.uname .replace('"','').replace('"','');
        $(".right_info_name").html(" <b>"+name+"</b> ");
        $(".right_info_content").html(""+ info.content );
    });
}

//设置btn的标签名
function changeBtnName(Keys){
   console.log(Keys)
    var count=0;
    while(count<20){
    btn="b"+count;
    label=Keys[count];
    var btn = document.getElementById(btn);
    btn.innerHTML=label.name;
    btn.setAttribute("title","词频:"+label.value);
    count++;
    }
}

//设置表的信息
function setTableInfo(msgCount){
    //var user=msg.infos;
    var item=user[msgCount];
    var count=0;
    while(count<=11){
        var userInfo = item.users[count];
        tt=userInfo.time;
        addRows(userInfo.uname,userInfo.follows,tt.substring(0,16),userInfo.url);
        count++;
     }
}

//修改按钮上的名字
function btnToTable(id){
   var table = document.getElementById("tabledata");
   $("#tabledata tr:not(:first)").empty();//清空表
   setTableInfo(id);
}
//向表中添加行
function addRows(name,count,time,address){
        var tbody = document.getElementById("tabledata");
		var tr = tbody.insertRow (tbody.rows.length);
		tr.style['text-align'] = 'center';
		var td1 = tr.insertCell (tr.cells.length).innerHTML=name;
	    var td2 = tr.insertCell (tr.cells.length).innerHTML=count;
	    var td3 = tr.insertCell (tr.cells.length).innerHTML=time;
	    var td4 = tr.insertCell (tr.cells.length).innerHTML=address;    
}

//词云
function word(worddata){
    //var worddata=msg.words
    var myChart = echarts.init(document.getElementById('word'));
    option = {
    tooltip: {
        show: true
    },
    series: [{
        name: '热点分析',//数据提示窗标题
        type: 'wordCloud',
        sizeRange: [6, 66],//画布范围，如果设置太大会出现少词（溢出屏幕）
        rotationRange: [-45, 90],//数据翻转范围
        //shape: 'circle',
        textPadding: 0,
        autoSize: {
            enable: true,
            minSize: 6
        },
        textStyle: {
            normal: {
                color: function() {
                    return 'rgb(' + [
                        Math.round(Math.random() * 160),
                        Math.round(Math.random() * 160),
                        Math.round(Math.random() * 160)
                    ].join(',') + ')';
                }
            },
            emphasis: {
                shadowBlur: 10,
                shadowColor: '#333'
            }
        },
        data: worddata//name和value建议用小写，大写有时会出现兼容问题
    }]
};
	 myChart.setOption(option);
}

//仪器表盘图
function gauge(vv){
var myChart = echarts.init(document.getElementById('gauge'));
        option = {
            legend: {
               orient: 'vertical',
               left: 'left',
               data: ['负能量', '中性', '正能量']
            },
            tooltip: {
               formatter: '{a} <br/>{b} '
             },
            toolbox: {
               feature: {
                    restore: {},
                    saveAsImage: {}
               }
            },

            series: [
            {
            min:-100,
            max:100,
            name: '情感比例',
            color:'#000',
            type: 'gauge',
            detail: {formatter: '{value}'},
            data: [{value: vv, name: '情感值'}]

            }
            ]
        };
        myChart.setOption(option);
}

</script>
</body>
</html>