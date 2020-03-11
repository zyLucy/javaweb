<%@page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>微博分析系统</title>
<style>
body{
background:url(./css/back.jpg)  no-repeat center center;
   background-size:cover;
   background-attachment:fixed;
   background-color:#CCCCCC;
}

#top{
margin-top:200px;

}

#con{
	background-color:rgba(255,255,255,0.5);
	margin-left: 400px;
	margin-top:10px;
	width: 500px;
	height: 80px;
}
.txtclass {
	float:left;
	margin:10px;
	border: 2px solid #000080;
	width: 400px;
	height: 60px;
	background:#CDC5BF;
}

.submitclass {
    float:right;
	border: 2px;
	width:60px;
	height: 60px;
	border-style: solid;
	border-color: #000080;
	margin:10px;
	background:#CDC5BF;
}

</style>
</head>

<body>
<div id="top">
 <center><h1><b><font color="grey">微博信息传播分析系统</font></b></h1></center>
</div>
<div id="con">
<form action=path method="get" class="formclass" >
		<input name="article" type="text" placeholder="请输入文章号"
					class="txtclass" id="input_txt">
		<input type="submit" value="Go" class="submitclass">
		</form>
</div>

</body>
</html>