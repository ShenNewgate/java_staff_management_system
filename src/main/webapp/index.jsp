<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<!-- 在当前页面域中通过java代码拿到项目路径 ,此方法以/开始，不以/结束-->
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());

%>
<!-- WEB路径
不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出现问题
以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:3306);需要加上项目名
			http://localhost:3306/crud




 -->
<!--  引入jquery-->
<script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.7.2.min.js"></script>
<!-- 引入样式 -->
 <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<!--  引入js文件 -->
  <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- ，下面的页面显示，分页，导航栏都完成了，再通过bootstrapt找到插件再找到模态框 ，只不过写在了最前面而已-->


<!-- 员工修改的模态框Modal -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" >员工修改</h4>
      </div>
      <!-- 表单项的name要与java bean中的属性名一样才能springmvc封装方便自动，提交的数据能自动为我们封装Employee对象 -->
      <div class="modal-body">
        	<form class="form-horizontal">
		  <div class="form-group">
		  <!-- label是提示信息 -->
		    <label  class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		     	<p class="form-control-static" id="empName_update_static"></p>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
		   	 <!-- 校验结果返回的提示信息 -->
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <!-- 下拉列表，还是在bootstrapt中全局样式表单下找到 -->
		      <!-- 部门提交部门id即可 -->
		      <select class="form-control" name="dId" id="dept_add_select">
				  <!--不是写死的，要从数据库中取 
				  <option>1</option>
				  <option>2</option>
				  <option>3</option>
				  <option>4</option>
				  <option>5</option> -->
				</select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
      </div>
    </div>
  </div>
</div>










<!-- ，下面的页面显示，分页，导航栏都完成了，再通过bootstrapt找到插件再找到模态框 ，只不过写在了最前面而已-->
<!-- 员工添加的模态框Modal -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
      </div>
      <!-- 表单项的name要与java bean中的属性名一样才能springmvc封装方便自动，提交的数据能自动为我们封装Employee对象 -->
      <div class="modal-body">
        	<form class="form-horizontal">
		  <div class="form-group">
		  <!-- label是提示信息 -->
		    <label  class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <!-- 校验结果返回的提示信息 -->
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
		   	 <!-- 校验结果返回的提示信息 -->
		      <span  class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
				  <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
				</label>
				<label class="radio-inline">
				  <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
				</label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label  class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <!-- 下拉列表，还是在bootstrapt中全局样式表单下找到 -->
		      <!-- 部门提交部门id即可 -->
		      <select class="form-control" name="dId" id="dept_add_select">
				  <!--不是写死的，要从数据库中取 
				  <option>1</option>
				  <option>2</option>
				  <option>3</option>
				  <option>4</option>
				  <option>5</option> -->
				</select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
      </div>
    </div>
  </div>
</div>







<!-- 引用bootstrap的栅格系统 ,搭建显示页面-->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 显示表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
						
					</tbody>
					
					<!-- 引用标签库，使用c,forEach把里面的数据都遍历出来 -->
					
					
				</table>
			</div>
		</div>
		<!-- 显示分页信息 -->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area">
				<!-- 当前 页，总  页，总 记录数 -->
			</div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area">
				
			</div>
		</div>
	</div>
			
	<script type="text/javascript">
		//定义一个总记录数
		var totalRecord;
		//1.页面加载完成后，直接去发送一个ajax请求，要到分页数据
		$(function(){
			//去首页
			to_page(1);
		});
	function to_page(pn){
		$.ajax({
			url:"${APP_PATH}/emps",
			data:"pn="+pn,
			type:"GET",
			success:function(result){
				//console.log(result);
				//1.解析并显示员工信息
				build_emps_table(result);
				//2.解析并显示分页信息
				build_page_info(result);
				//3。解析并显示分页条信息
				build_page_nav(result);
				
				
			}
		});
		}
		
		
	function build_emps_table(result){
		//在构建之前必须要清空table表格用jquery中使用empty方法
			$("#emps_table tbody").empty();
		
			//先取出所有的员工信息，通过页面返回的json数据，观察到所有的员工信息存储在返回结果result下面的extend下面的pageInfo下面的list中
			var emps = result.extend.pageInfo.list;
			//然后遍历员工,用jquery提供的$.each(要遍历的元素，每次遍历要返回的回调函数)方法,回调函数中index代表索引，item代表当前对象(即每一条员工数据)
			$.each(emps,function(index,item){
				//先测试下用alert(item.empName);
				//使用jquery构造出table表单的td单元格
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"男":"女");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				/**
				<button class="btn btn-primary btn-sm">
							<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> 编辑
							</button>
				*/
				//先通过$("<button></button>")创建一个button按钮,然后再调用jquery中的addClass方法添加的类返回的结果类型还是原来的
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
								.append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				//为编辑按钮添加一个自定义的属性，来表示当前员工id
				editBtn.attr("edit-id",item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm")
								.append($("<span></span>").addClass("glyphicon glyphicon-trash delete_btn")).append("删除");
				//把两个按钮单元格追加到一个单元格中
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				//使用jquery构造出table表单的一行tr,用来存放员工的所有信息
				//能够链式往后加的原因是append方法执行完成后还是返回原来的元素
				$("<tr></tr>").append(empIdTd)
								.append(empNameTd)
								.append(genderTd)
								.append(emailTd)
								.append(deptNameTd)
								.append(deptNameTd)
								.append(btnTd)
								.appendTo("#emps_table tbody");
				
			});
			
			
		}
		//解析显示分页信息
		//也得先清空
		$("#page_info_area").empty();
		function build_page_info(result){
			$("#page_info_area").append("当前 "+result.extend.pageInfo.pageNum+"页，总"+result.extend.pageInfo.pages +  "页，总"+result.extend.pageInfo.total+" 记录数");
			//总记录数
			totalRecord = result.extend.pageInfo.total;
		}
		
		//解析显示分页条,点击分页要能去下一页。。。。
	function build_page_nav(result){
			//也得先清空
			$("#page_nav_area").empty();
		//page_nav_area
		//通过javastrapt模板里面找到组件，找到分页条，然后对照着写
		//都是绑定单击事件，等点击了再发送ajax请求跳转，jQuery中添加属性使用attr
		var ul = $("<ul></ul>").addClass("pagination");
		//构建元素
		var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
		var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
		if(result.extend.pageInfo.hasPreviousPage == false){
			firstPageLi.addClass("disabled");
			prePageLi.addClass("disabled");
		}else{
			//为元素添加点击翻页事件
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum -1);
			});
		}
		
		
		var nextPageLi = $("<li></li>").append($("<a></a>").append("&requo;"));
		var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
		if(result.extend.pageInfo.hasNextPage == false){
			nextPageLi.addClass("disabled");
			lastPageLi.addClass("disabled");
		}else{
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum +1);
			});
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});	
		}
		
		//先添加首页和前一页的提示
		ul.append(firstPageLi).append(prePageLi);
		//1,2,3,4,5 遍历页码号
		$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
			var numLi = $("<li></li>").append($("<a></a>").append(item));	
			//如果当前页码等于要遍历的页码，就把li标签添加一个class="active"的类
			if(result.extend.pageInfo.pageNum == item){
				numLi.addClass("active");
			}
			numLi.click(function(){
				to_page(item);
			});
			//再添加页码号
			ul.append(numLi);
		})
		//添加下一页和末页的提示
		ul.append(nextPageLi).append(lastPageLi);
		
		//把ul加入到nav导航条中
		var navEle = $("<nav></nav>").append(ul);
		navEle.appendTo("#page_nav_area");
		
	}
		//清空表单样式及内容
		function reset_form(ele){
			$(ele)[0].reset();
			//清空表单样式
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		//点击新增按钮，手动打开模态框
		$("#emp_add_modal_btn").click(function(){
			//清除表单数据（表单完整重置（表单的数据，表单的样式））,jquery中没有reset方法，只能取出dom，dom有
			reset_form("#empAddModal form");
			
			//$("#empAddModal form")[0].reset();
			//首先第一件事要发送ajax请求，查出部门信息，显示在下拉列表中
			getDepts("#dept_add_select");
			//弹出模块框
			$("empAddModal").modal({
				backdrop:"static"
			});
		});
		//查出所有的部门信息并显示在下拉列表中
		function getDepts(ele){
			//首先清空之前的下拉列表的值
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result)
					//{"code":100,"msg":"处理成功！","extend":{"depts":[{"deptId":1,"deptName":"开发部"}，{"deptId":2,"deptName":"测试部"}]}}
					//显示部门信息在下拉列表中,先遍历
					//$("#dept_add_select")
					$.each(result.extend.depts,function(){
						//构建部门下拉列表
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						//添加到下拉框中
						optionEle.appendTo(ele);
					});
				}
			});
		}
		//校验表单数据
		function validate_add_form(){
			//1、拿到要校验的数据，使用正则表达式
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				//alert("用户名需要是2-5位中文，或者6-16位英文和数字的组合");
				//通过bootstrap找到全局样式中表单校验
				//$("#empName_add_input").parent().addClass("has-error");
				//$("#empName_add_input").next("span").text("用户名需要是2-5位中文，或者6-16位英文和数字的组合");
				//然后为了以后数据量大，还是用一个方法简单
				show_validate_msg("#empName_add_input","error","用户名需要是2-5位中文，或者6-16位英文和数字的组合");
				return false;
			}else{
				//校验成功
				//$("#empName_add_input").parent().addClass("has-success");
				//$("#empName_add_input").next("span").text("");
				show_validate_msg("#empName_add_input","success","");
			};
			//2、校验邮箱信息
			var email = $("#email_add_input").val();
			var regeEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; 
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空这个元素之前的样式
				
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确");
				show_validate_msg("#email_add_input", "error", "邮箱格式不正确");
				return false;
			}else{
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		//显示校验结果的提示信息
		function show_validate_msg(ele,status,msg){
			//不管校验成功失败，都应该先清除当前元素校验状态
			$(ele).parent().removeClass("has-success has-error");
			$("ele").next("span").text("");
			if("success" == status){
				$("ele").parent().addClass("has-success");
				$("ele").next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		//校验用户名是否可用
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					//因为返回的对象是Msg属性对象，所以里面的属性都有
					if(result.code==100){
						//引用上面提示信息函数
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
						
					}else{
						show_validate_msg("#empName_add_input","error","result.extend.va_msg");
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
				
				
			});
			
		});
		
		//点击保存员工的方法
		$("#emp_save_btn").click(function(){
			//1、将模态框中填写的表单数据提交给服务器进行保存
			//1、先对提交给服务器的数据进行前端校验
			if(!validate_add_form()){
				return false;
			}
			//1、在保存之前，用数据库和页面校验之后还需要判断之前的ajax用户名校验是否成功。如果成功
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			//2、发送ajax请求保存员工
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				//serialize()方法可以快速拿到表单中的内容，不用一点一点拼接
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//alert(result.msg);
					
					if(result.code == 100){
						//员工保存成功后
						//1、关闭模态框
						$("#empAddModal").modal('hide');
						//2、来到最后一页，显示刚才保存的数据
						//发送ajax请求显示最后一页数据即可
						//to_page(99999999999999);传入一个较大的数字
						//或者将总记录数当作页面数，即使一个记录一页也可以
						to_page(totalRecord);	
					}else{
						//显示失败信息
						//console.log(result);
						//有哪个字段的错误信息就显示那个字段
						//alert(result.extend.errorFields.email);
						//alert(result.extend.errorFields.empName);
					if(underfined != result.extend.errorFields.email){
						//显示邮箱错误信息
						show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
					}
					if(underfined != result.extend.errorFields.empName){
						//显示员工名字错误信息
						show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
					}
					
					}
				}
			});
		});
		
		//1、我们是按钮创建之前就绑定了click,所以绑定不上
		//1）、可以在创建按钮的时候绑定（太过耦合）   2）绑定点击.live()可以为后来添加的后元素绑定
		//jquery新版没有live,使用on进行替代
		$(document).on("click",".edit_btn",function(){
			//alert("edit");
			
			//1、查出部门信息，并显示部门列表
			getDepts("#empUpdateModal select");
			//2、查出员工信息，显示员工信息
			getEmp($(this).attr("edit-id"));
			//弹出模态框
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
			
		});
		
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					//console.log(result);
				$("#empName_update_static").text(empData.empName);
				//给input传值，直接用val()方法即可添加元素
				$("#email_update_input").val(empDate.email);
				//单选框传值
				$("#empUpdateModal input[name=gender]").val([empData.gender]);
				//下拉列表传值
				$("#empUpdateModal select").val([empData.dId]);
				}
			});
		}
		
		//点击更新，更新员工信息，为更新按钮绑定一个单击事件
		$("#emp_update_btn").click(function(){
			//验证邮箱是否合法
			//复制上面的校验邮箱信息，然后改下id值即可 
			//1、校验邮箱信息
			var email = $("#email_update_input").val();
			var regeEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; 
			if(!regEmail.test(email)){
				//alert("邮箱格式不正确");
				//应该清空这个元素之前的样式
				
				//$("#email_add_input").parent().addClass("has-error");
				//$("#email_add_input").next("span").text("邮箱格式不正确");
				show_validate_msg("#email_update_input", "error", "邮箱格式不正确");
				return false;
			}else{
				//$("#email_add_input").parent().addClass("has-success");
				//$("#email_add_input").next("span").text("");
				show_validate_msg("#email_update_input", "success", "");
			}
		});
		
	</script>







</body>
</html>