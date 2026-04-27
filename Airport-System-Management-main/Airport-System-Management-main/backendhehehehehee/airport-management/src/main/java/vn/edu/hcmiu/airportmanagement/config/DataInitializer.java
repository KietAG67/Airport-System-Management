package vn.edu.hcmiu.airportmanagement.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;
import vn.edu.hcmiu.airportmanagement.entity.*;
import vn.edu.hcmiu.airportmanagement.repository.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.List;

@Configuration
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepo;
    private final EmployeeRepository empRepo;
    private final PassengerRepository passRepo;
    private final FlightRepository flightRepo;
    private final TicketRepository ticketRepo;
    private final BoardingPassRepository bpRepo;
    private final LuggageRepository luggageRepo;
    private final SecurityLogRepository secLogRepo;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepo, EmployeeRepository empRepo,
                           PassengerRepository passRepo, FlightRepository flightRepo,
                           TicketRepository ticketRepo, BoardingPassRepository bpRepo,
                           LuggageRepository luggageRepo, SecurityLogRepository secLogRepo,
                           PasswordEncoder passwordEncoder) {
        this.userRepo = userRepo;
        this.empRepo = empRepo;
        this.passRepo = passRepo;
        this.flightRepo = flightRepo;
        this.ticketRepo = ticketRepo;
        this.bpRepo = bpRepo;
        this.luggageRepo = luggageRepo;
        this.secLogRepo = secLogRepo;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        if (userRepo.count() > 0) return;

        // Users
        User admin = new User(null, "admin@airport.com", passwordEncoder.encode("123456"), "Aria Nguyen", User.Role.ADMIN);
        User ops   = new User(null, "ops@airport.com", passwordEncoder.encode("123456"), "Minh Tran", User.Role.OPERATIONS_STAFF);
        User sec   = new User(null, "security@airport.com", passwordEncoder.encode("123456"), "Linh Pham", User.Role.SECURITY_STAFF);
        userRepo.saveAll(List.of(admin, ops, sec));

        // Employees
        Employee emp1 = new Employee(null, "EMP-5000", "Aria Nguyen", "admin@airport.com", "+84912111222", "Management", "Airport Manager");
        Employee emp2 = new Employee(null, "EMP-5001", "Minh Tran", "ops@airport.com", "+84987333444", "Operations", "Operations Coordinator");
        Employee emp3 = new Employee(null, "EMP-5002", "Linh Pham", "security@airport.com", "+84901555666", "Security", "Security Supervisor");
        Employee emp4 = new Employee(null, "EMP-5003", "Bao Nguyen", "bao.nguyen@airport.com", "+84933101202", "Security", "Screening Officer");
        Employee emp5 = new Employee(null, "EMP-5004", "Khanh Le", "khanh.le@airport.com", "+84934202303", "Security", "Screening Officer");
        Employee emp6 = new Employee(null, "EMP-5005", "Lan Vu", "lan.vu@airport.com", "+84935303404", "Customer Service", "Terminal Coordinator");
        empRepo.saveAll(List.of(emp1, emp2, emp3, emp4, emp5, emp6));

        // Passengers
        Passenger p1 = new Passenger(null, "PAS-2000", "Noah Bui", "P12345678", "noah.bui@email.com", "+84910222111", "Vietnam");
        Passenger p2 = new Passenger(null, "PAS-2001", "Emma Le", "M99881235", "emma.le@email.com", "+6581120022", "Singapore");
        Passenger p3 = new Passenger(null, "PAS-2002", "Lucas Vo", "N88332774", "lucas.vo@email.com", "+8210993322", "Korea");
        Passenger p4 = new Passenger(null, "PAS-2003", "Mia Dang", "T66221880", "mia.dang@email.com", "+6688992211", "Thailand");
        passRepo.saveAll(List.of(p1, p2, p3, p4));

        // Flights
        Flight f1 = new Flight(null, "FLT-1000", "VN235", "Airbus A321", "Hanoi", "Bangkok",
                LocalDateTime.of(2026,4,23,1,44), LocalDateTime.of(2026,4,23,3,44),
                null, null, "ON_TIME");
        Flight f2 = new Flight(null, "FLT-1001", "SQ184", "Boeing 787", "Singapore", "Ho Chi Minh City",
                LocalDateTime.of(2026,4,23,2,44), LocalDateTime.of(2026,4,23,4,44),
                null, null, "DELAYED");
        Flight f3 = new Flight(null, "FLT-1002", "QH311", "Airbus A320", "Da Nang", "Seoul",
                LocalDateTime.of(2026,4,23,0,29), LocalDateTime.of(2026,4,23,4,44),
                null, null, "BOARDING");
        Flight f4 = new Flight(null, "FLT-1003", "EK492", "Boeing 777", "Dubai", "Bangkok",
                LocalDateTime.of(2026,4,22,18,44), LocalDateTime.of(2026,4,22,22,44),
                LocalDateTime.of(2026,4,22,18,59), LocalDateTime.of(2026,4,22,22,54), "ARRIVED");
        flightRepo.saveAll(List.of(f1, f2, f3, f4));

        // Tickets
        Ticket t1 = new Ticket(null, "TCK-1000", p1, f1, "12A", "Economy", new BigDecimal("179.00"),
                LocalDateTime.of(2026,4,19,0,0), "BOOKED");
        Ticket t2 = new Ticket(null, "TCK-1001", p2, f2, "3C", "Business", new BigDecimal("420.00"),
                LocalDateTime.of(2026,4,20,0,0), "CHECKED_IN");
        Ticket t3 = new Ticket(null, "TCK-1002", p3, f3, "1A", "First", new BigDecimal("850.00"),
                LocalDateTime.of(2026,4,21,0,0), "BOARDED");
        Ticket t4 = new Ticket(null, "TCK-1003", p4, f1, "18F", "Economy", new BigDecimal("190.00"),
                LocalDateTime.of(2026,4,22,0,0), "CANCELLED");
        ticketRepo.saveAll(List.of(t1, t2, t3, t4));

        // Boarding Passes
        BoardingPass bp1 = new BoardingPass(null, "BDP-2000", t2, "B12", LocalDateTime.of(2026,4,23,2,9), "ISSUED");
        BoardingPass bp2 = new BoardingPass(null, "BDP-2001", t3, "A04", LocalDateTime.of(2026,4,22,23,49), "BOARDED");
        bpRepo.saveAll(List.of(bp1, bp2));

        // Luggage
        Luggage l1 = new Luggage(null, "LUG-3000", t1, 21.5, "CHECKED_IN", LocalDateTime.of(2026,4,22,21,44));
        Luggage l2 = new Luggage(null, "LUG-3001", t2, 16.2, "LOADED", LocalDateTime.of(2026,4,22,20,44));
        Luggage l3 = new Luggage(null, "LUG-3002", t3, 19.0, "IN_TRANSIT", LocalDateTime.of(2026,4,22,22,44));
        Luggage l4 = new Luggage(null, "LUG-3003", t2, 22.0, "DELIVERED", LocalDateTime.of(2026,4,21,23,44));
        luggageRepo.saveAll(List.of(l1, l2, l3, l4));

        // Security Logs
        SecurityLog s1 = new SecurityLog(null, "SEC-4000", p1, emp3, LocalDate.of(2026,4,22), LocalTime.of(21,44), "CLEARED", "Routine check complete");
        SecurityLog s2 = new SecurityLog(null, "SEC-4001", p2, emp4, LocalDate.of(2026,4,22), LocalTime.of(22,44), "FLAGGED", "Carry-on needs manual check");
        SecurityLog s3 = new SecurityLog(null, "SEC-4002", p3, emp5, LocalDate.of(2026,4,22), LocalTime.of(22,59), "CLEARED", "No issue found");
        SecurityLog s4 = new SecurityLog(null, "SEC-4003", p4, emp6, LocalDate.of(2026,4,22), LocalTime.of(23,29), "REJECTED", "Restricted item detected");
        secLogRepo.saveAll(List.of(s1, s2, s3, s4));
    }
}