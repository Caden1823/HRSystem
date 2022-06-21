package cn.edu.hzvtc.service.Impl;

import cn.edu.hzvtc.bean.Employee;
import cn.edu.hzvtc.util.PageResult;
import cn.edu.hzvtc.util.QueryPageBean;
import cn.edu.hzvtc.dao.EmployeeMapper;
import cn.edu.hzvtc.service.EmployeeService;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Override
    public PageResult getAll(QueryPageBean queryPageBean) {
        Integer currentPage = queryPageBean.getCurrentPage();
        Integer pageSize = queryPageBean.getPageSize();
        String queryString = queryPageBean.getQueryString();//查询条件
        // 完成分页查询,基于mybatis框架提供的分页助手插件完成
        System.out.println(queryString);
        PageHelper.startPage(currentPage,pageSize);
        // select * from t_checkGroup limit 0,10
        Page<Employee> page = employeeMapper.selectAll(queryString);
        long total = page.getTotal();
        List<Employee> rows = page.getResult();
        return  new PageResult(total,rows);
    }

    @Override
    public boolean deleteEmp(Integer id) {
        Boolean result = false;
        if ( employeeMapper.selectByPrimaryKey(id) != null){
            employeeMapper.deleteByPrimaryKey(id);
            result = true;
        }
        return result;

    }
    public boolean deleteBatch(List<Integer> del_ids) {
        Boolean result = false;
        if(employeeMapper.deleteBatch(del_ids)>0) {
            result = true;
        }
            return result;
    }

    @Override
    public boolean saveEmp(Employee employee) {
        boolean result = false;
        System.out.println(employee);
        if (employee.getEmpGender().equals("男")){
            employee.setEmpGender("m");
        }else {
            employee.setEmpGender("v");
        }

        if(employeeMapper.insert(employee)>0){
            result=true;
        }
        return result;
    }
    public Boolean checkEmpName(String empName) {
        Boolean result = false;
        Employee employee = new Employee();
        employee.setEmpName(empName) ;
        List<Employee> employees = employeeMapper.selectByCondition(employee);
        if (employees.size() == 0) {
            result = true;
        }
        return result;
    }
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }
    public void updateEmp(Employee employee) {
        if (employee.getEmpGender().equals("男")){
            employee.setEmpGender("m");
        }else {
            employee.setEmpGender("v");
        }
        employeeMapper.updateByPrimaryKey( employee);
    }
}
