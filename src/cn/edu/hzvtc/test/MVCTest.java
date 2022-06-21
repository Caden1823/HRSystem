package cn.edu.hzvtc.test;

import cn.edu.hzvtc.bean.Employee;
import cn.edu.hzvtc.util.PageResult;
import cn.edu.hzvtc.util.QueryPageBean;
import com.github.pagehelper.PageInfo;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcExtensionsKt;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:./web/WEB-INF/dispatcherServlet-servlet.xm1"})
public class MVCTest {
    //传入SpringAVC的IoC容器@Autowired
    private WebApplicationContext context;
    //虚拟mvc请求，获取处理结果
    private MockMvc mockMvc;

    @Before
    public void initMockMVC() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testEmpsPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps ").param("currentPage", "1")
                .param("pageSize","5").param("queryString","a")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageResult pageInfo = (PageResult) request.getAttribute("pageResult");

        System.out.println("总页码:" + pageInfo.getTotal());


        List<Employee> emps = pageInfo.getRows();
        for (Employee emp : emps) {
            System.out.println("ID:" + emp.getEmpId() + "Name : " + emp.getEmpName());
        }
    }
}
