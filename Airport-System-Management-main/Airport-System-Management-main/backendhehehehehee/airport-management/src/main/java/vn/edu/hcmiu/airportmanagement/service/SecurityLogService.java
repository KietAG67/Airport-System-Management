package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.SecurityLog;
import vn.edu.hcmiu.airportmanagement.entity.Passenger;
import vn.edu.hcmiu.airportmanagement.entity.Employee;
import vn.edu.hcmiu.airportmanagement.repository.PassengerRepository;
import vn.edu.hcmiu.airportmanagement.repository.EmployeeRepository;
import vn.edu.hcmiu.airportmanagement.repository.SecurityLogRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SecurityLogService {

    private final SecurityLogRepository securityLogRepository;
    private final PassengerRepository passengerRepository;
    private final EmployeeRepository employeeRepository;

    public SecurityLogService(SecurityLogRepository securityLogRepository,
                              PassengerRepository passengerRepository,
                              EmployeeRepository employeeRepository) {
        this.securityLogRepository = securityLogRepository;
        this.passengerRepository = passengerRepository;
        this.employeeRepository = employeeRepository;
    }

    public List<SecurityLog> getAll() {
        return securityLogRepository.findAll();
    }

    public Optional<SecurityLog> getById(Long id) {
        return securityLogRepository.findById(id);
    }

    public List<SecurityLog> search(String keyword) {
        return securityLogRepository.search(keyword);
    }

    public SecurityLog create(SecurityLog securityLog) {
        if (securityLog.getLogUid() == null || securityLog.getLogUid().isBlank()) {
            securityLog.setLogUid(generateUid());
        }
        securityLog.setPassenger(resolvePassenger(securityLog.getPassenger()));
        securityLog.setEmployee(resolveEmployee(securityLog.getEmployee()));
        return securityLogRepository.save(securityLog);
    }

    public SecurityLog update(Long id, SecurityLog updated) {
        SecurityLog log = securityLogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        log.setLogUid(updated.getLogUid());
        log.setPassenger(resolvePassenger(updated.getPassenger()));
        log.setEmployee(resolveEmployee(updated.getEmployee()));
        log.setScreeningDate(updated.getScreeningDate());
        log.setScreeningTime(updated.getScreeningTime());
        log.setResult(updated.getResult());
        log.setNotes(updated.getNotes());
        return securityLogRepository.save(log);
    }

    public void delete(Long id) {
        securityLogRepository.deleteById(id);
    }

    private String generateUid() {
        long count = securityLogRepository.count();
        return String.format("SEC-%04d", count + 1);
    }

    private Passenger resolvePassenger(Passenger passenger) {
        if (passenger == null || passenger.getId() == null) {
            throw new RuntimeException("Passenger is required");
        }
        return passengerRepository.findById(passenger.getId())
                .orElseThrow(() -> new RuntimeException("Passenger not found"));
    }

    private Employee resolveEmployee(Employee employee) {
        if (employee == null || employee.getId() == null) {
            return null;
        }
        return employeeRepository.findById(employee.getId())
                .orElseThrow(() -> new RuntimeException("Employee not found"));
    }
}
