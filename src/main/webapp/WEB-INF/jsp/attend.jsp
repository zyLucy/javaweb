<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="css/attendstyle.css" />
<script src="js/echarts.js"></script>
<script src="js/china.js"></script>
<script src="js/vintage.js"></script>
<script src="js/dark.js"></script>
<script src="js/jquery-3.4.1.js"></script>
<script src="js/jquery-3.4.1.min.js"></script>
<script src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js'></script>



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

                </div>
            </div>
            <div class="right_info_content">
               <p>    
               </p>
            </div>
       </div>
       <div class="region_label">
         <center>地域分析</center>
       </div>
       <div class="region">
             <div class="region_map" id="map">
             </div>
             <div class="region_bar" id="map_bar">
             </div>
       </div>
       <div class="pie_charts">
             <div class="pie_sex">
                  <div class="pie_sex_txt" ><center>男女比例</center></div>
                  <div class="pie_sex_graph" id="sex"></div>
             </div>
             <div class="fans">
                    <div class="pie_fans_txt" ><center>粉丝数量</center></div>
                     <div class="pie_fans_graph" id="fans"></div>
             </div>
       </div>

</div>

</div>
<script type="text/javascript">
$(document).ready(function(){
  changeBar(3);
  queryFromWho('<%=article%>');
  queryPersonInfo('<%=article%>');

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
             var name =info.uname.replace('"','').replace('"','');
              $(".right_info_name").html(" <b>"+name+"</b> ");
             $(".right_info_content").html(""+ info.content );
         });
     }

    function queryPersonInfo(art){
        $.post("attendPerson",{article:art},function (msg) {
            var info = JSON.parse(msg);
            mapBar(info.provinceName,info.provinceCount);
            sex(JSON.parse(info.sex));
            queryMap(JSON.parse(info.map));
            console.log(info.peopleCount);
            fansBar(JSON.parse(info.peopleCount));
         });
    }

     function  fansBar(peopleCount){
         var myChart = echarts.init(document.getElementById('fans'));
                  option = {
                  xAxis: {
                     type: 'category',
                     data: ['0-49','50-199','200-499','500-799','800-999','1000-1599','1600-1999','2000以上'],
                     offset:10,
                     axisLabel:{ //坐标轴刻度标签的相关设置
                        show:true, //是否显示 //坐标轴刻度标签的显示间隔，在类目轴中有效。默认会采用标签不重叠的策略间隔显示标签。可以设置成 0 强制显示所有标签。如果设置为 1，表示『隔一个标签显示一个标签』，如果值为 2，表示隔两个标签显示一个标签，以此类推
                        inside:false, //刻度标签是否朝内，默认朝外
                        rotate:30, //刻度标签旋转的角度，在类目轴的类目标签显示不下的时候可以通过旋转防止标签之间重叠。旋转的角度从 -90 度到 90 度
                        margin:8, //刻度标签与轴线之间的距离
                      }
                 },
                 yAxis: {
                     type: 'value',
                      offset:5
                 },
                 series: [{
                     data:peopleCount,
                     type: 'bar'
                 }]
                 };
                 myChart.setOption(option);

     }
     function mapBar(provinceName,provinceCount){
         var myChart = echarts.init(document.getElementById('map_bar'));
          option = {
          xAxis: {
             type: 'category',
             data: provinceName,
          axisLabel:{//竖着显示
             formatter:function(value){
                 return value.split("").join("\n");
             }
         }
         },
         yAxis: {
             type: 'value',
             offset:5
         },
         series: [{
             data:provinceCount,
             type: 'bar'
         }]
         };
         myChart.setOption(option);
      }

     function sex(sexData){
         var myChart = echarts.init(document.getElementById('sex'));
             myChart.setOption({
             legend: {
                     type: 'scroll',
                     orient: 'vertical',
                     right: 10,
                     top: 20,
                     bottom: 20,
                     data: ['男','女']
                     },
                 series : [
                     {
                         name: '访问来源',
                         type: 'pie',    // 设置图表类型为饼图
                         radius: '55%',  // 饼图的半径，外半径为可视区尺寸（容器高宽中较小一项）的 55% 长度。
                         data:sexData
                     }
                 ]
             })
      }

     //查询地理信息
             function queryMap(maps){
                     //echarts进行初始化
                     var myChart = echarts.init(document.getElementById("map"),'vintage');
                     var dataList=maps;

                     	option = {
                     	backgroundColor:'rgba(255, 255, 255, 0)',
                                    tooltip: {
                                            formatter:function(params,ticket, callback){
                                                return params.seriesName+'<br />'+params.name+'：'+params.value
                                            }//数据格式化
                                        },
                                    visualMap: {
                                        min: 0,
                                        max: 100,
                                        left: 'left',
                                        top: 'bottom',
                                        itemWidth:20,                           //图形的宽度，即长条的宽度。
                                        itemHeight:100,
                                        text: ['高','低'],//取值范围的文字
                                        inRange: {
                                            color: ['#e0ffff', '#006edd']//取值范围的颜色
                                        },
                                        show:true//图注
                                    },
                                    geo: {
                                        map: 'china',
                                        roam: false,//不开启缩放和平移
                                        zoom:1.23,//视角缩放比例

                                        itemStyle: {
                                            normal:{
                                                borderColor: 'rgba(0, 0, 0, 0.2)'
                                            },
                                            emphasis:{
                                                areaColor: '#F3B329',//鼠标选择区域颜色
                                                shadowOffsetX: 0,
                                                shadowOffsetY: 0,
                                                shadowBlur: 20,
                                                borderWidth: 0,
                                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                                            }
                                        }
                                    },
                                    series : [
                                        {
                                            name: '信息量',
                                            type: 'map',
                                            geoIndex: 0,
                                            data:dataList
                                        }
                                    ]
                                };
                  myChart.setOption(option);
                  myChart.on('click', function (params) {
                     alert(params.name);
                  });
             }

    </script>



</body>
</html>