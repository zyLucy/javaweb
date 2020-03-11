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
<title>微博信息传播分析系统</title>
</head>

<body>
<script type="text/javascript">
$(document).ready(function(){

$.getJSON ("json/test.json",  "", function (data)
{
   alert("testOk");
});
});
</script>
</body>
</html>