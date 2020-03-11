<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="js/vintage.js" type="text/javascript"></script>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/style.css" />
<script src="js/jquery-3.4.1.js"></script>
<script src="js/jquery-3.4.1.min.js"></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>
 <script src="https://cdn.staticfile.org/echarts/4.3.0/echarts.min.js"></script>


<title>微博分析系统</title>
</head>
<%
   String article=request.getParameter("article");
   String path_url="http://localhost:8080/client/path?article="+article;
   String bomb_url="http://localhost:8080/client/bomb?article="+article;
   String attend_url="http://localhost:8080/client/attend?article="+article;
   String content_url="http://localhost:8080/client/content?article="+article;
 %>
<body>
<div class="top" >
  <center><h1><b><font color="grey">微博分析系统</font></b></h1></center>
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
    <p>    
    </p>
  </div>
</div>
<div class="right_graph"  id="main">
</div>
</div>
<script type="text/javascript">

$(document).ready(function(){
  changeBar(4);
  queryFromWho('<%=article%>');
  queryBombPoint('<%=article%>');
});

//左侧功能栏的选中状态
function changeBar(posi){
    var bar= $("li").eq(posi);
    bar.css('background-color', '#b0c4de');
}
//查询文章内容
     function queryFromWho(art){
         $.post("queryFromWho",{tablename:art,article:art},function (msg) {
             var info = JSON.parse(msg);
             var name =info.uname .replace('"','').replace('"','');
              $(".right_info_name").html(" <b>"+name+"</b> ");
             $(".right_info_content").html(""+ info.content );
         });
     }



 //查询echart表的内容
         function queryBombPoint(art){
          $.post("queryBombPoint",{article:art},function (msg) {
            var res= JSON.parse(msg);
            var aa=JSON.parse(res.categories);
            var bb=JSON.parse(res.nodes);
            var cc=JSON.parse(res.links);
            var option = {
                          legend: {
                                          x: 'left',//图例位置
                                          //图例的名称
                                          //此处的数据必须和关系网类别中name相对应
                                           data:['引爆点','男','女','性别未知']
                            },
                            series: [{
                              edgeSymbol: 'arrow',
                                type: 'graph',
                                layout: 'force',
                                // animation: false,
                                label: {
                                    normal: {
                                        show:true,
                                        position: 'right'
                                    }
                                },
                                force: {
                                    layoutAnimation:true,
                                    xAxisIndex : 200, //x轴坐标 有多种坐标系轴坐标选项
                                    yAxisIndex : 330, //y轴坐标
                                    gravity:0.01,  //节点受到的向中心的引力因子。该值越大节点越往中心点靠拢。
                                    edgeLength: 100,  //边的两个节点之间的距离，这个距离也会受 repulsion。[10, 50] 。值越小则长度越长
                                    repulsion: 150  //节点之间的斥力因子。支持数组表达斥力范围，值越大斥力越大。
                                },
                                 animation: false,
                                 name:"",
                                  type: 'graph',//关系图类型
                                   layout: 'force',//引力布局
                                   roam: true,//可以拖动
                                   useWorker: false,
                                    minRadius: 60,
                                    maxRadius: 65,
                                    gravity: 1.1,
                                    zoom:1.8,
                                    scaling: 2,
                                     //categories: aa,
                                     categories:[
                                     {name: "引爆点",
                                     },
                                     { name: "男",
                                       itemStyle: {
                                           borderType : 'solid',

                                           color: " #87CEFF",
                                           borderWidth: 2
                                            },
                                     },
                                     { name: "女",
                                       itemStyle: {
                                           borderType : 'solid',
                                           color: "#FF3E96",//girl
                                            borderWidth: 2
                                            },
                                      },
                                      { name: "性别未知",
                                       itemStyle: {
                                        borderType : 'solid',
                                        color: "#CDAD00",
                                        borderWidth: 2
                                         },
                                       },
                                    ],
                                     nodes:bb,//数据内容
                                      //接收格式均为json对象数组
                                      links:cc
                            }]
                        };
                     var myChart = echarts.init(document.getElementById("main"));
                     myChart.setOption(option);
          });
         }


    </script>
</div>


</body>
</html>