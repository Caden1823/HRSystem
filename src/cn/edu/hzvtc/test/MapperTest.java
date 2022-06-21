package cn.edu.hzvtc.test;

import cn.edu.hzvtc.bean.Department;
import cn.edu.hzvtc.bean.Employee;
import cn.edu.hzvtc.dao.DepartmentMapper;
import cn.edu.hzvtc.dao.EmployeeMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {


    @Autowired
    private DepartmentMapper departmentMapper;
    @Autowired
    private EmployeeMapper employeeMapper;
    @Test
    public void testInsertDept() {
        departmentMapper.insert(new Department(null, "开发部"));
        departmentMapper.insert(new Department(null, "市场部"));
        departmentMapper.insert(new Department(null, "财务部"));
        departmentMapper.insert(new Department(null, "后勤部"));
    }
    @Test public void testInsertEmp(){
        for (int i = 0; i < 100; i++) {
            String uid = UUID.randomUUID().toString().substring(0,6);
            employeeMapper.insert(new Employee(null,uid,"m",
            uid + "@qq.com ",
            new Department((int) (Math.random() * 4 + 1),null)));
        }
    }
}
