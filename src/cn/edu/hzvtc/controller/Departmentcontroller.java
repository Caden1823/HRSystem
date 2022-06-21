package cn.edu.hzvtc.controller;

import cn.edu.hzvtc.bean.Department;
import cn.edu.hzvtc.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class Departmentcontroller {
    @Autowired
    private DepartmentService departmentService;
    @RequestMapping( "/depts")
    @ResponseBody
    public List<Map<String,Object>> getDeptsJson(){
        List <Map<String,Object>> list = new ArrayList<Map<String,Object>>();
        List <Department> list2 = departmentService.getAll();
        for (Department department:list2) {
            Map<String,Object> map= new HashMap<>();
            map.put("label",department.getDeptName());
            map.put("value",department.getDeptId());
            list.add(map);
        }
        return  list;
    }
}