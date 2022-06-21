package cn.edu.hzvtc.controller;

import cn.edu.hzvtc.bean.Department;
import cn.edu.hzvtc.bean.Employee;
import cn.edu.hzvtc.service.DepartmentService;
import cn.edu.hzvtc.util.PageResult;
import cn.edu.hzvtc.util.QueryPageBean;
import cn.edu.hzvtc.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping("/list")
    @ResponseBody
    public PageResult getEmps(@RequestBody QueryPageBean queryPageBean){
        return  employeeService.getAll(queryPageBean);
    }

    @RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public boolean deleteEmp(@PathVariable("id" ) Integer id) {
        if (employeeService.deleteEmp(id)) {
            return true;
        }
        return false;
    }
    @RequestMapping(value = "/empAll/{ids}" , method = RequestMethod.DELETE)
    @ResponseBody
    public boolean deleteEmp(@PathVariable("ids") String ids){
        System.out.println(ids);
        if (ids.contains(",")) {
            List<Integer> del_ids = new ArrayList<Integer>();
            String[] str_ids = ids.split(",");
            for (String str_id : str_ids) {
                del_ids.add(Integer.parseInt(str_id));
            }
            if (!employeeService.deleteBatch(del_ids)) {
                return false;
            }
        }else {
            Integer id = Integer.parseInt(ids);
            if (!employeeService.deleteEmp(id)){
                return false;
            }
        }
        return true;
    }
    @RequestMapping("/input")
    @ResponseBody
    public List<Map<String,Object>> getEmp(){
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
    @RequestMapping(value = "/emp" , method = RequestMethod.POST)
    public String saveEmp(@RequestBody Employee employee) {
        employeeService.saveEmp(employee);
        return "list";
    }

    @RequestMapping(value = "/checkEmpName/{name}")
    @ResponseBody
    public boolean checkEmpName(@PathVariable("name") String empName) {
        return employeeService.checkEmpName(empName);
    }

    @RequestMapping( " /edit/{id}")
    public String edit(@PathVariable("id") Integer id,Map<String,Object> map) {
        map.put ("empId",id);
        return "edit" ;
    }

    @RequestMapping(value ="emp/{id}" , method = RequestMethod.GET)
    @ResponseBody
    public Employee getEmp(@PathVariable("id") Integer id) {
        return   employeeService.getEmp(id);
    }

    @RequestMapping(value = "/emp" , method = RequestMethod.PUT)
    @ResponseBody
    public boolean updateEmp(@RequestBody Employee employee) {
        try {
            employeeService.updateEmp(employee);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
