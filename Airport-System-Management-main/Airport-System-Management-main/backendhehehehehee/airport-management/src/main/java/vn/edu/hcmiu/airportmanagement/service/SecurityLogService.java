package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.SecurityLog;
import vn.edu.hcmiu.airportmanagement.repository.SecurityLogRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class SecurityLogService {

    private final SecurityLogRepository securityLogRepository;

    public SecurityLogService(SecurityLogRepository securityLogRepository) {
        this.securityLogRepository = securityLogRepository;
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
        return securityLogRepository.save(securityLog);
    }

    public SecurityLog update(Long id, SecurityLog updated) {
        SecurityLog log = securityLogRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        log.setLogUid(updated.getLogUid());
        log.setPassenger(updated.getPassenger());
        log.setEmployee(updated.getEmployee());
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
}