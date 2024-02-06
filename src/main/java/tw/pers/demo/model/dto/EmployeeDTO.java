package tw.pers.demo.model.dto;

public class EmployeeDTO {
	private String employeeName;
	private Integer employeeAge;

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public Integer getEmployeeAge() {
		return employeeAge;
	}

	public void setEmployeeAge(Integer employeeAge) {
		this.employeeAge = employeeAge;
	}

	@Override
	public String toString() {
		return "EmployeeDTO [employeeName=" + employeeName + ", employeeAge=" + employeeAge + "]";
	}

}
