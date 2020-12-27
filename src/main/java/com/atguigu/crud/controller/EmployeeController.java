package com.atguigu.crud.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


/*
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id){
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	/*
	 * 编写一个能检验用户名可用的方法
	 */
	//返回json数据
	@ResponseBody
	@RequestMapping("/checkuser")
	//因为这里面需要传入empName的值，它的变量名就是要从请求参数中取的值，所有加上@RequestParam注解,明确的告诉springmvc要取出empName的值
	public Msg checkuser(@RequestParam("empName")String empName){
		//先判断用户名是否合法的表达式
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		//string中本身就有matches,输入的用户名是否匹配这个正则
		if(!empName.matches(regx)){
			return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
		}
		//数据库用户名重复校验
		boolean b = employeeService.checkUser(empName);
		if(b){
			return Msg.success();
		}else{
			return Msg.fail().add("va_msg", "用户名不可用");
		}

	}
	
	
	/*
	 * 员工保存
	 *1、支持JSR303校验
	 *2、导入Hibernate-Validator
	 *
	 *
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	//返回json数据
	@ResponseBody
	//@Valid代表封装对象后要进行校验，与Employee对象中的自定义校验规则相对应,校验就会有成功失败，所以紧跟着BindingResult校验结果
	public Msg saveEmp(@Valid Employee employee,BindingResult result){
		if(result.hasErrors()){
			//校验失败，应该返回失败，在模态框中显示校验失败的错误信息
			Map<String, Object> map = new HashMap<String, Object>();
			
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误的字段名： "+fieldError.getField());
				System.out.println("错误信息： "+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();	
		}
		
	}
	/*
	 * 要想@ResponseBody注解能够生效，必须导入jackson包，去maven的中央仓库搜索
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model){
		/*
		 *这不是一个分页查询;
		引入PageHelper分页插件在pom.xml中导入依赖，搜索pagehelper
		在查询前只需要调用下面的方法就可以传入页码，以及每页的大小 
		Model是请求域
		 */
		
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
		//它封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数,把员工信息包装进pageInfo
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		return Msg.success().add("pageInfo",page);
	}
	/*
	 * 查询员工数据（分页查询）
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, Model model){
		/*
		 *这不是一个分页查询;
		引入PageHelper分页插件在pom.xml中导入依赖，搜索pagehelper
		在查询前只需要调用下面的方法就可以传入页码，以及每页的大小 
		Model是请求域
		 */
		
		PageHelper.startPage(pn, 5);
		//startPage后面紧跟的这个查询就是一个分页查询
		List<Employee> emps = employeeService.getAll();
		//使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
		//它封装了详细的分页信息，包括有我们查询出来的数据，传入连续显示的页数,把员工信息包装进pageInfo
		PageInfo<Employee> page = new PageInfo<Employee>(emps,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
