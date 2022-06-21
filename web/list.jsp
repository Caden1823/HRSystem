
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-CN">
<head>
    <title>HRSystem</title>
    <script src="static/js/vue.js"></script>
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="static/js/index.js"></script>
    <script src="static/js/jquery.min.js"></script>
    <script src="static/js/axios-0.18.0.js"></script>
</head>
<style>
    a{
        text-decoration: none;
        color: white;
    }
</style>
<body>
<div id="app">
    <el-row>
        <el-col :span="24">
            <div class="grid-content bg-purple-dark">
                <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" style="margin-left: 150px">
                    <el-menu-item index="1" >人力资源管理系统</el-menu-item>
                    <el-menu-item index="2" ><a href="index.jsp">首页</a></el-menu-item>
                    <el-submenu index="3">
                        <template slot="title">员工信息</template>
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
                <h3>查看员工操作</h3>
                <hr>
            </div>
        </el-col>
    </el-row>
    <el-row>
        <el-col :span="24">
            <div class="grid-content bg-purple-dark" style="margin-right: 150px;margin-left: 150px">
                <el-button @click="DeleteAll()" type="danger" icon="el-icon-close" style="float: right">批量删除</el-button>
                <el-button  @click="add()"type="primary" icon="el-icon-plus" style="float: right">新增</el-button>
                <el-input placeholder="id/姓名" v-model="pagination.queryString" style="width: 200px;" class="filter-item"></el-input>
                <el-button @click="findPage()" class="dalfBut">查询</el-button>
            </div>
        </el-col>
    </el-row>
    <div class="grid-content bg-purple-dark" style="margin-right: 150px;margin-left: 150px;margin-bottom: 100px" >
    <template >
        <el-table
                ref="multipleTable"
                :data="tableData"
                tooltip-effect="dark"
                style="width: 100%"
                @selection-change="handleSelectionChange">
            <el-table-column
                    prop="select"
                    type="selection"
                    width="55">
            </el-table-column>
            <el-table-column
                    prop="empId"
                    label="Id"
                    width="120">
               <%-- <template slot-scope="scope">{{ scope.row.id }}</template>--%>
            </el-table-column>
            <el-table-column
                    prop="empName"
                    label="姓名"
                    width="120">
            </el-table-column>
            <el-table-column
                    prop="empGender"
                    label="性别"
                    width="120">
            </el-table-column>
            <el-table-column
                    prop="empEmail"
                    label="邮箱"
                    show-overflow-tooltip>
            </el-table-column>
            <el-table-column
                    prop="department.deptName"
                    label="部门"
                    show-overflow-tooltip>
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            @click="handleEdit(scope.row)"
                            icon="el-icon-info">修改</el-button>
                    <el-button
                            size="mini"
                            type="danger"
                            @click="handleDelete(scope.row)"
                            icon="el-icon-error">删除</el-button>
                </template>
            </el-table-column>
        </el-table>
    </template>
    </div>
        <el-row>
            <el-col :span="24">
                <div class="grid-content bg-purple-dark" style="text-align: center">
                    <el-pagination
                            background
                            class="pagiantion"
                            @current-change="handleCurrentChange"
                            :current-page="pagination.currentPage"
                            :page-size="pagination.pageSize"
                            layout="prev, pager, next"
                            :total="pagination.total">>
                    </el-pagination>
                </div>
            </el-col>
        </el-row>

    <el-footer>
        <el-row>
            <el-col :span="24">
                <div class="grid-content bg-purple-dark" style="margin-left: 150px; position: relative;top: 300px">
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
            select:[1,2],
            pagination: {//分页相关模型数据
                currentPage: 1,//当前页码
                pageSize:5,//每页显示的记录数
                total:20,//总记录数
                queryString:null//查询条件
            },
            formData: {},//表单数据
            //当前页要展示的分页列表数据
            tableData: [{
                empId: '1',
                empName: '王小虎',
                empGender:'男',
                empEmail: '上海市普陀区金沙江路 1518 弄',
                deptName:'开发部',
            }],
            multipleSelection:[]
        },
        created() {
            this.findPage();
        },
        methods: {
            //每次改变复选框记录下值来
            handleSelectionChange(val){
                this.multipleSelection = val;
            },
            // 编辑
            handleEdit(row) {
                window.location.href="edit.jsp?empId="+row.empId;
        },
            // 删除
            handleDelete(row) {
                this.$confirm("你确定要删除当前数据吗？","提示",{
                    type: 'warning',
                }).then(()=>{
                    axios.delete("/emp/"+row.empId).then((res)=>{
                        if (res.data==true){
                            this.$message({
                                type:'success',
                                message:"删除成功",
                            });
                            this.findPage();
                        }else {
                            this.$message("删除失败");
                        }
                    })
                }).catch(()=>{
                    this.$message({
                        type:'info',
                        message:'操作取消',
                    })
                });
            },
            // 批量删除
            DeleteAll(){
                var ids = new Array (this.multipleSelection.length);
                for (var i =0; i<this.multipleSelection.length;i++){
                    ids[i] = this.multipleSelection[i].empId;
                }
                this.$confirm("你确定要删除当前数据吗？","提示",{
                    type: 'warning',
                }).then(()=>{
                    axios.delete("/empAll/"+ids).then((res)=>{
                        if (res.data==true){
                            this.$message({
                                type:'success',
                                message:"删除成功",
                            });
                            this.findPage();
                        }else {
                            this.$message("删除失败");
                        }
                    })
                }).catch(()=>{
                    this.$message({
                        type:'info',
                        message:'操作取消',
                    })
                });
                alert(this.multipleSelection);
            },
            //换页
            handleCurrentChange(currentPage) {
                this.pagination.currentPage = currentPage;
                this.findPage2();
            },
            // 分页查询
            findPage(){
                var param = {
                    currentPage:1,//当前页码
                    pageSize:this.pagination.pageSize,//每页显示的记录数
                    queryString:this.pagination.queryString//查询条件
                };
                axios.post("/list",param).then((res)=>{
                    for (var i =0; i<res.data.rows.length;i++){
                        if (res.data.rows[i].empGender=='m'){
                            res.data.rows[i].empGender="男"
                        }else {
                            res.data.rows[i].empGender="女"
                        }
                    }
                    this.tableData = res.data.rows;
                    this.pagination.total = res.data.total;
                });
            },
            findPage2(){
                var param = {
                    currentPage:this.pagination.currentPage,//当前页码
                    pageSize:this.pagination.pageSize,//每页显示的记录数
                    queryString:this.pagination.queryString//查询条件
                };
                axios.post("/list",param).then((res)=>{
                    for (var i =0; i<res.data.rows.length;i++){
                        if (res.data.rows[i].empGender=='m'){
                            res.data.rows[i].empGender="男"
                        }else {
                            res.data.rows[i].empGender="女"
                        }
                    }
                    this.tableData = res.data.rows;
                    this.pagination.total = res.data.total;
                });
            },
            add(){
                window.location.href="input.jsp";
            }
        },
    });
</script>
</html>
