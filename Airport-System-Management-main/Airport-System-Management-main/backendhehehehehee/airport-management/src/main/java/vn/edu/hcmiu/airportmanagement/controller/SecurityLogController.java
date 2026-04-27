package vn.edu.hcmiu.airportmanagement.controller;

import vn.edu.hcmiu.airportmanagement.entity.SecurityLog;
import vn.edu.hcmiu.airportmanagement.service.SecurityLogService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/security-logs")
public class SecurityLogController {

    private final SecurityLogService securityLogService;

    public SecurityLogController(SecurityLogService securityLogService) {
        this.securityLogService = securityLogService;
    }

    @GetMapping
    public List<SecurityLog> getAll(@RequestParam(required = false) String search) {
        if (search != null) return securityLogService.search(search);
        return securityLogService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<SecurityLog> getById(@PathVariable Long id) {
        return securityLogService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public SecurityLog create(@RequestBody SecurityLog securityLog) {
        return securityLogService.create(securityLog);
    }

    @PutMapping("/{id}")
    public ResponseEntity<SecurityLog> update(@PathVariable Long id, @RequestBody SecurityLog securityLog) {
        try {
            return ResponseEntity.ok(securityLogService.update(id, securityLog));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        securityLogService.delete(id);
        return ResponseEntity.noContent().build();
    }
}