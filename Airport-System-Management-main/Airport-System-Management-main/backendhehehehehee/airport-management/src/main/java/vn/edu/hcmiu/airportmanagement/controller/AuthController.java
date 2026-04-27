package vn.edu.hcmiu.airportmanagement.controller;

import vn.edu.hcmiu.airportmanagement.dto.LoginRequest;
import vn.edu.hcmiu.airportmanagement.dto.JwtResponse;
import vn.edu.hcmiu.airportmanagement.service.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<JwtResponse> login(@RequestBody LoginRequest request) {
        return ResponseEntity.ok(authService.login(request));
    }
}