package cn.edu.hzvtc.dao;

import cn.edu.hzvtc.bean.Department;
import java.util.List;

public interface DepartmentMapper {

    int deleteByPrimaryKey(Integer deptId);


    int insert(Department record);


    Department selectByPrimaryKey(Integer deptId);

    List<Department> selectAll();

    int updateByPrimaryKey(Department record);
}