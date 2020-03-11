<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/pathstyle.css" />
<script src="http://cdn.bootcss.com/jquery/1.11.0/jquery.min.js" type="text/javascript"></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>

<script src="js/echarts.js" type="text/javascript"></script>
<script src="js/dark.js" type="text/javascript"></script>
<script src="js/vintage.js" type="text/javascript"></script>
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

     </div>
  </div>
  <div class="right_info_content">
    <p>    
    </p>
  </div>
</div>


<div class="right_path"  >
    <div class="right_path_label" ><b>传播路径</b></div>
    <div class="right_path_graph" id="graph" ></div>
</div>
<div class="right_level"  >
     <div class="right_level_label"  >
      层级分析
      </div>
      <div class="right_level_num"  >
      </div>
<div class="right_level_graph"  id="main"></div>
</div>


</div>
<script type="text/javascript">
$(document).ready(function(){
  changeBar(2);
  queryFromWho('<%=article%>');
  queryLevelBar('<%=article%>');
   queryPath('<%=article%>');
});

//左侧功能栏的选中状态
function changeBar(posi){
    var bar= $("li").eq(posi);
    bar.css('background-color', '#b0c4de');
}

function queryLevel(res){
    var length=res.count.length;
    var allcount=0;
    //计算总转发量
    for(j=0;j<length;j++){
          allcount+=res.count[j];
    }

    var h=280/length;
    for(i=0;i<length;i++){
    var divLevel = document.createElement('div'); //创建一个input控件  
    divLevel.setAttribute('class',"divlevel"+i); //type="button"  
    var percent=res.count[i]/allcount;
    divLevel.innerHTML=res.level[i]+"："+Number(percent*100).toFixed(1)+"%";
    divLevel.style.height=h+"px";
    divLevel.style.fontSize = "larger";
     divLevel.style.lineHeight=h+"px";
     divLevel.style.marginLeft="40px";
    $(".right_level_num").append(divLevel);

}
}
      //查询echart路径图
            function queryPath(art){
             $.post("queryPath",{tablename:art,article:art},function (msg) {
             var res= JSON.parse(msg);
             var aa=JSON.parse(res.categories);
             var bb=JSON.parse(res.nodes);
             var cc=JSON.parse(res.links);
            var myChart = echarts.init(document.getElementById("graph"),'dark');
             myChart.showLoading();
                   var option={
                    legend: {
                              x: 'left',//图例位置
                              //图例的名称
                              //此处的数据必须和关系网类别中name相对应
                               data:aa
                               },

                                series: [{
                                   itemStyle: {
                                       normal: {
                                           label: {
                                               position: 'top',
                                               //show: true,显示每个node的名字
                                               textStyle: {
                                                   color: '#333'
                                               }
                                           },
                                           nodeStyle: {
                                               brushType: 'both',
                                               borderColor: 'rgba(255,215,0,0.4)',
                                               borderWidth: 1
                                           },
                                           linkStyle: {
                                               normal: {
                                                   color: 'source',
                                                   curveness: 0,
                                                   type: "solid"
                                               }
                                           }
                                       },

                                   },
                                        force:{
                                       initLayout: 'circular',//初始布局
                                       repulsion:100,//斥力大小

                                   },

                                   animation: false,
                                   name:"",
                                   type: 'graph',//关系图类型
                                   layout: 'force',//引力布局
                                   roam: true,//可以拖动
                                 //  legendHoverLink: true,//是否启用图例 hover(悬停) 时的联动高亮。
                                  // hoverAnimation: false,//是否开启鼠标悬停节点的显示动画
                                  // coordinateSystem: null,//坐标系可选
                                 //  xAxisIndex: 0, //x轴坐标 有多种坐标系轴坐标选项
                                 //  yAxisIndex: 0, //y轴坐标
                                  // ribbonType: true,
                                   useWorker: false,
                                   minRadius: 60,
                                   maxRadius: 65,
                                   gravity: 1.1,

                                   scaling: 1.1,
                                  categories: aa,
                                  nodes:bb
                                   ,//数据内容
                                   //接收格式均为json对象数组
                                   links:cc
                                   //关系对应
                               } ]
                   }
                    myChart.hideLoading();
                      myChart.setOption(option);//将option添加到mychart中


               });
             }

//查询文章内容
     function queryFromWho(art){
         $.post("queryFromWho",{tablename:art,article:art},function (msg) {
             var info = JSON.parse(msg);
             var name =info.uname.replace('"','').replace('"','');
              $(".right_info_name").html(" <b>"+name+"</b> ");
             $(".right_info_content").html(""+ info.content );
         });
     }


//查询echart柱状图
         function queryLevelBar(art){
            $.post("queryLevelBar",{article:art},function (msg) {
                var res= JSON.parse(msg);
                //进行数值显示
                //console.log(res);

                 //echarts进行初始化
                 	var myChart = echarts.init(document.getElementById("main"));
                 	myChart.setOption({
                    tooltip: {
                        show: true
                    },
                    legend: {
                        data:['转发量']
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : res.level
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                        {
                            "name":"转发量",
                            "type":"bar",
                            "data":res.count
                        }
                    ]
                 	});
                 	queryLevel(res);
             });

          }



    </script>
</div>


</body>
</html>