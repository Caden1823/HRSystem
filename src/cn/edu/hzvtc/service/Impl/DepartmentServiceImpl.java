package cn.edu.hzvtc.service.Impl;

import cn.edu.hzvtc.bean.Department;
import cn.edu.hzvtc.dao.DepartmentMapper;
import cn.edu.hzvtc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    @Override
    public List<Department> getAll() {
        return departmentMapper.selectAll();
    }


}
