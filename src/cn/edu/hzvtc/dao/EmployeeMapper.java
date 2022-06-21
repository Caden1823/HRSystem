package cn.edu.hzvtc.dao;

import cn.edu.hzvtc.bean.Employee;
import com.github.pagehelper.Page;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {

    int deleteByPrimaryKey(Integer empId);

    int insert(Employee record);

    Employee selectByPrimaryKey(int empId);


    Page<Employee> selectAll(String queryString);

    int updateByPrimaryKey(Employee record);

    int deleteBatch(@Param( "ids") List<Integer> ids);

    List<Employee> selectByCondition(Employee employee);
}