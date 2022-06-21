package cn.edu.hzvtc.bean;

public class Employee {

    private Integer empId;

    private String empName;

    private String empGender;

    private String empEmail;
    private Department department;
    private Integer dId ;

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }

    public Integer getEmpId() {
        return empId;
    }


    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }


    public void setEmpName(String empName) {
        this.empName = empName == null ? null : empName.trim();
    }


    public String getEmpGender() {
        return empGender;
    }


    public void setEmpGender(String empGenden) {
        this.empGender = empGenden == null ? null : empGenden.trim();
    }

    public String getEmpEmail() {
        return empEmail;
    }


    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail == null ? null : empEmail.trim();
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;
    }

    public Employee() {
    }

    public Employee(Integer empId, String empName, String empGenden, String empEmail, Department department) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGenden;
        this.empEmail = empEmail;
        this.department = department;
    }

    public Employee(String empName, String empGender, String empEmail, Integer dId) {
        this.empName = empName;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.dId = dId;
    }

    public Employee(Integer empId, String empName, String empGender, String empEmail, Integer dId) {
        this.empId = empId;
        this.empName = empName;
        this.empGender = empGender;
        this.empEmail = empEmail;
        this.dId = dId;
    }

    @Override
    public String toString() {
        return "Employee{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empGender='" + empGender + '\'' +
                ", empEmail='" + empEmail + '\'' +
                ", department=" + department +
                '}';
    }
}