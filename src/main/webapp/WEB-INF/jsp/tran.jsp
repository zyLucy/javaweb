<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
 <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>


<title>微博信息传播分析系统</title>
</head>
<%
   String article=request.getParameter("article");
   String path_url="http://localhost:8080/client/path?article="+article;
   String bomb_url="http://localhost:8080/client/bomb?article="+article;
   String attend_url="http://localhost:8080/client/attend?article="+article;
 %>
<body>
<div class="top" >
  <center><h1><b><font color="grey">微博信息传播分析系统</font></b></h1></center>
</div>
<div class="middle">
<div class="left">
  <ul class="nav nav-list">
    <li class="nav-header"> <a href="#"> <img src="pic/all.png"  alt=" 总览" />&nbsp; 总览 </a> </li>
    <li > <a href="#"><img src="pic/trans.png"  alt="传播分析" /><i class="tran_analyse"> </i> 传播分析 </a> </li>
    <li> <a href= "<%=path_url%>" > <img src="pic/path.png"  alt="传播路径" /><i class="tran_path"> </i> 传播路径 </a> </li>
    <li> <a href="<%=attend_url%>">  <img src="pic/attend.png"  alt="参与者信息" /> <i class="attend_info"> </i> 参与者信息 </a> </li>
    <li> <a href="<%=bomb_url%>"> <img src="pic/bomb.png"  alt="引爆点" /><i class="bomb_point"> </i> 引爆点 </a> </li>
    <li> <a href="#"> <img src="pic/water.png"  alt="水军分析" /><i class="water_anamy"> </i> 水军分析 </a> </li>
    <li> <a href="#"> <img src="pic/content.png"  alt="内容分析" /><i class="content-analyse"> </i>内容分析</a> </li>
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
    <p>    
    </p>
  </div>
</div>
<div class="right_graph"  id="main">
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
  queryFromWho('<%=article%>');
  queryByTime('<%=article%>');
  changeBar(1);
});
//查询文章内容
     function queryFromWho(art){
         $.post("queryFromWho",{tablename:art,article:art},function (msg) {
             var info = JSON.parse(msg);
             var name =info.uname .replace('"','').replace('"','');
              $(".right_info_name").html(" <b>"+name+"</b> ");
             $(".right_info_content").html(""+ info.content );
         });
     }
//左侧功能栏的选中状态
function changeBar(posi){
    var bar= $("li").eq(posi);
    bar.css('background-color', '#b0c4de');
}


 //查询echart表的内容
         function queryByTime(art){
             $.post("queryByTime",{article:art},function (msg) {
                 var ec = JSON.parse(msg);
                 //$("p").html(""+ec.count);
                 //echarts进行初始化
                 	var myChart = echarts.init(document.getElementById("main"));
                 	myChart.setOption({
                         //图标题
                 		title:{text: '传播分析'},
                         //图提示框,放在一个点上会有提示
                 		  tooltip : { },
                         //图例
                 		legend:{
                 			data:['转发量']
                 		},
                         //x轴属性
                 		xAxis:{
                 			data:ec.time
                 		},
                         //y轴属性
                 		yAxis:{},
                 		//图属性
                 		series:[
                 			{
                 				name:'转发量',
                 				type:'line',//图类型：柱状图
                 				color:['#C0FF3E'],//设置图像颜色
                 				data: ec.count  //图表的数值
                 			}
                 		]
                 	});
             });
         }


    </script>
</div>


</body>
</html>