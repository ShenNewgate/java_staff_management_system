<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  //首页直接转到emps请求，然后EmployeeController接收到emps请求，然后查询出所有的员工数据以及分页信息，然后返回list页面  
  <jsp:forward page="/emps"></jsp:forward>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
引入jquery
<script type="text/javascript" src="static/js/jquery-1.7.2.min.js"></script>
引入样式
 <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
 引入js文件
  <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
	<button class="btn btn-success">按钮</button>
</body>
</html> -->