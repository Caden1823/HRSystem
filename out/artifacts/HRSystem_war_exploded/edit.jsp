
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>HRSystem</title>
    <script src="static/js/vue.js"></script>
    <link rel="stylesheet" href="static/css/index.css">
    <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
    <script src="static/js/index.js"></script>

    <script src="static/js/axios-0.18.0.js"></script>
    <script>
        function getUrlParam(paraName) {
            var url = document.location.toString();
            //alert(url);
            var arrObj = url.split("?");
            if (arrObj.length > 1) {
                var arrPara = arrObj[1].split("&");
                var arr;
                for (var i = 0; i < arrPara.length; i++) {
                    arr = arrPara[i].split("=");
                    if (arr != null && arr[0] == paraName) {
                        return arr[1];
                    }
                }
                return "";
            }
            else {
                return "";
            }
        }
        var empId = getUrlParam("empId");
    </script>
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
                <h3>添加员工操作</h3>
                <hr>
            </div>
        </el-col>
    </el-row>
    <el-form ref="form" :model="emp" label-width="80px" style="margin-left: 150px;margin-right: 150px;" :rules="rules">
        <el-form-item label="用户名" prop="empName" >
            <el-input v-model="emp.empName" placeholder="请输入用户名" id="empName2"></el-input>
        </el-form-item>
        <el-form-item label="Email" prop="empEmail">
            <el-input v-model="emp.empEmail" placeholder="请输入Email" ></el-input>
        </el-form-item>

        <el-form-item label="性别">
            <el-radio-group v-model="emp.empGender">
                <el-radio label="男" ></el-radio>
                <el-radio label="女" ></el-radio>
            </el-radio-group>
        </el-form-item>
        <el-form-item label="部门">
            <el-select  v-model="emp.dId" placeholder="请选择部门">
                <el-option
                        v-for="item in options"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value"
                >
                </el-option>

            </el-select>
        </el-form-item>
        <el-form-item>
            <el-button type="primary" @click="edit">修改员工信息</el-button>
        </el-form-item>
    </el-form>
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
<script  src="static/js/jquery-3.6.0.js"></script>
<script>
    var checkEmail = (rule, value, callback) => {
        var reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;
        if(reg.test(value)){
            callback();
        }
        return callback(new Error('Email格式不正确'));

    };
    var checkName = (rule, value, callback) => {
        var reg = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
    if(!reg.test(value)){
        return callback(new Error('用户名必须是2-5位中文或6-16位英文和数字的组合!'));
    }
    callback();
    };
    var app = new Vue({
        el:"#app",
        data:{
            checkEmail,
            checkName,
            selectNameFlag:false,
            visible: false ,
            activeIndex:'1',
            emp: {
                empId:'',
                empName: '',
                empEmail:'',
                dId: "1",
                empGender: '男',
            },
            options:[{
                label:"开发部",
                value:"1",
            },{
                label:"市场部",
                value:"2",
            }],
            rules: {//校验规则
                empName: [{ required: true,  validator: checkName ,trigger: 'blur' }],
                empEmail: [{ required: true,  validator: checkEmail ,trigger: 'blur' }]
            }
        },
        created() {
            this.findDept();
        },
        mounted(){
            this.emp.empId = empId;
            axios.get("/emp/"+empId).then((data)=>{

                this.emp.empName = data.data.empName;
                this.emp.empEmail = data.data.empEmail;
                this.emp.dId = data.data.department.deptId;
                if (data.data.empGender=='m'){
                    this.emp.empGender = '男';
                }else {
                    this.emp.empGender = '女';
                }
            });

        },
        methods: {
            // 查询部门
            findDept(){
                axios.post("/input").then((res)=>{
                    this.options = res.data;
                });
            },
            //添加
            edit () {
                //进行表单校验
                this.$refs["form"].validate((valid)=>{
                    if (valid){
                        //表单校验通过，发生Ajax请求
                        axios.put("/emp",this.emp).then((data)=>{
                            if (data.data){// 执行成功
                                this.$message({
                                    message:"添加成功",
                                    type:'success',
                                });
                                window.location.href="list.jsp";
                            }else {// 执行失败
                                this.$message.error("添加失败");
                            }
                        });
                    }else {
                        //校验不通过
                        this.$message.error("数据校验失败，请检查你的输入");
                        return false;
                    }
                });
            },
        },
    });
</script>
</html>
