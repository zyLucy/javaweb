<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://cdn.staticfile.org/jquery/3.2.1/jquery.min.js"></script>
<script src="https://cdn.staticfile.org/popper.js/1.15.0/umd/popper.min.js"></script>
<script src="https://cdn.staticfile.org/twitter-bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/zzsc.css" />
<title>微博分析系统</title>
</head>
<%
   String urlStr=request.getParameter("urlstr");
 %>
<body scroll="no" style="overflow-x:hidden;overflow-y:hidden">
<div id="top">
 <center><h1><b><font color="grey">微博信息传播分析系统</font></b></h1></center>
</div>

<div class="out">
	<div class="fade-in">
		<div class="container">
			<div class="one common"></div>
			<div class="two common"></div>
			<div class="three common"></div>
			<div class="four common"></div>
			<div class="five common"></div>
			<div class="six common"></div>
			<div class="seven common"></div>
			<div class="eight common"></div>
		</div>
		 <div class="info" >
                   <center><font color="red" id="info">这里是红色</font></center>
         </div>
		<div class="bar">
        	<div class="progress"></div>
        </div>

	</div>
</div>

<script  type="text/javascript">


startProject("https://weibo.cn/comment/IwSOzvSAm?uid=2058586920&rl=0&page=2");



 var intelval=setInterval(function () {
        //执行ajax
        $.ajax({
            url:"getProcess",
            dataType:"json",
            type:"get",
            processData: false,   // jQuery不要去处理发送的数据
            contentType: false,
            success:function (data) {
                var txt=data.progress;
                $("#info").text(txt);
                console.log(txt);
            }
        })
    },2000);



function startProject(url){
    var formData = new FormData();
    formData.append("urlstr",url);
    $.ajax({
        url:"http://localhost:8080/client/test/uploadInfo?",
        data:formData,
        dataType:"json",
        type:"post",
        processData: false,   // jQuery不要去处理发送的数据
        contentType: false,
        success:function (data) {
         //结束后台进度查询
            clearInterval(intelval);
            var art=data.resurl;
            window.open(art);

        }
    });
}


</script>


</body>
</html>