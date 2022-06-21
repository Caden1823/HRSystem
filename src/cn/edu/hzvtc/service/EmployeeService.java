package cn.edu.hzvtc.service;

import cn.edu.hzvtc.bean.Employee;
import cn.edu.hzvtc.util.PageResult;
import cn.edu.hzvtc.util.QueryPageBean;

import java.util.List;


public interface EmployeeService {
    public PageResult getAll(QueryPageBean queryPageBean);

    boolean deleteEmp(Integer id);

    boolean deleteBatch(List<Integer> ids);

    boolean saveEmp(Employee employee);

    public Boolean checkEmpName(String empName);

    public Employee getEmp(Integer id);

    public void updateEmp(Employee employee);
}
