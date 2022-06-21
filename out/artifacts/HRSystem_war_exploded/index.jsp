<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="zh-CN">
  <head>
    <title>HRSystem</title>
    <script src="static/js/vue.js"></script>
    <script src="static/js/index.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
  </head>
  <style>
    .el-button{
      width: 80%;
      margin-top: 10px;
    }
    a{
      text-decoration: none;
    }
  </style>
<body>
<%
  pageContext.setAttribute("App_Path",request.getContextPath());
%>
<div id="app">
  <el-row>
    <el-col :span="24">
      <div class="grid-content bg-purple-dark">
          <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" @select="handleSelect" style="margin-left: 150px">
            <el-menu-item index="1" >人力资源管理系统</el-menu-item>
            <el-menu-item index="2" ><a href="index.jsp">首页</a></el-menu-item>
            <el-submenu index="3">
              <template slot="title">员工管理</template>
              <a href="list.jsp"><el-menu-item index="3-1" >查看员工信息</el-menu-item></a>
              <a href="input.jsp"><el-menu-item index="3-2" >新增员工信息</el-menu-item></a>

            </el-submenu>
          </el-menu>
      </div>
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <div class="grid-content bg-purple-dark" style="margin-left: 150px">
        <h3>请选择操作</h3>
        <hr>
      </div>
    </el-col>
  </el-row>
  <el-row>
  <el-col :span="24">
    <div class="grid-content bg-purple-dark" style="margin-left: 150px">
      <a href="list.jsp"><el-button type="primary" ><i class="el-icon-s-unfold"></i>查看员工信息</el-button></a>
    </div>
  </el-col>
 </el-row>
  <el-row>
    <el-col :span="24">
      <div class="grid-content bg-purple-dark" style="margin-left: 150px">
        <a href="input.jsp"><el-button type="primary"><i class="el-icon-download"></i>新增员工信息</el-button></a>
      </div>
    </el-col>
  </el-row>
  <el-footer>
    <el-row>
      <el-col :span="24">
        <div class="grid-content bg-purple-dark" style="margin-left: 150px; position: relative;top: 500px">
          @2020 杭州职业技术学院 软件技术软件2012yxt
        </div>
      </el-col>
    </el-row>
  </el-footer>
</div>

</body>
  <script>
    var app = new Vue({
      el:"#app",
      data:{
          visible: false ,
          activeIndex:'1',
      },
      methods: {
        handleSelect(key, keyPath) {
          console.log(key, keyPath);
        }
      },
    });
  </script>
</html>
