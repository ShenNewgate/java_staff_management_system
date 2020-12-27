package com.atguigu.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.EmployeeExample;
import com.atguigu.crud.bean.EmployeeExample.Criteria;
import com.atguigu.crud.dao.EmployeeMapper;;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	/*
	 * 查询所有员工
	 */
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}
	/*
	 * 员工保存
	 */
	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}
	
	
	/*
	 * 检验用户名是否可用
	 * .countByExample()方法是按照条件，统计符合条件的记录数
	 * @return true 代表当前姓名可用 false 代表当前姓名不可用
	 */
	public boolean checkUser(String empName) {
		EmployeeExample example = new EmployeeExample();
		//创建查询条件
		Criteria criteria = example.createCriteria();
		//判断是否存在，然后返回long型的count
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		// TODO Auto-generated method stub
		return count == 0;
	}
	/*
	 *按照员工id查询员工 
	 */
	public Employee getEmp(Integer id) {
		
		// TODO Auto-generated method stub
		Employee employee = employeeMapper.selectByPrimaryKey(id);
		return employee;
	}

}
