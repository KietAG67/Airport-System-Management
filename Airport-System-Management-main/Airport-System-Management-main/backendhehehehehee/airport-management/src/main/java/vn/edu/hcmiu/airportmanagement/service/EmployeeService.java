package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Employee;
import vn.edu.hcmiu.airportmanagement.repository.EmployeeRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class EmployeeService {

    private final EmployeeRepository employeeRepository;

    public EmployeeService(EmployeeRepository employeeRepository) {
        this.employeeRepository = employeeRepository;
    }

    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    public Optional<Employee> getEmployeeById(Long id) {
        return employeeRepository.findById(id);
    }

    public List<Employee> searchEmployees(String keyword) {
        return employeeRepository.search(keyword);
    }

    public Employee createEmployee(Employee employee) {
        if (employee.getEmployeeUid() == null || employee.getEmployeeUid().isBlank()) {
            employee.setEmployeeUid(generateEmployeeUid());
        }
        return employeeRepository.save(employee);
    }

    public Employee updateEmployee(Long id, Employee updated) {
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Employee not found"));
        employee.setEmployeeUid(updated.getEmployeeUid());
        employee.setFullName(updated.getFullName());
        employee.setEmail(updated.getEmail());
        employee.setPhone(updated.getPhone());
        employee.setDepartment(updated.getDepartment());
        employee.setJobTitle(updated.getJobTitle());
        return employeeRepository.save(employee);
    }

    public void deleteEmployee(Long id) {
        employeeRepository.deleteById(id);
    }

    private String generateEmployeeUid() {
        long count = employeeRepository.count();
        return String.format("EMP-%04d", count + 1);
    }
}