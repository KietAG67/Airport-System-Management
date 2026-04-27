package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    @Query("SELECT e FROM Employee e WHERE " +
           "e.employeeUid LIKE %:q% OR e.fullName LIKE %:q% OR " +
           "e.department LIKE %:q% OR e.jobTitle LIKE %:q%")
    List<Employee> search(@Param("q") String q);
}