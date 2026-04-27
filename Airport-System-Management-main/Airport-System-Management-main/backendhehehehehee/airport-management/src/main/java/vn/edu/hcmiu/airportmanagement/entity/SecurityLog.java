package vn.edu.hcmiu.airportmanagement.entity;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "security_logs")
public class SecurityLog {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "log_uid", unique = true)
    private String logUid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "passenger_id")
    private Passenger passenger;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "employee_id")
    private Employee employee;

    @Column(name = "screening_date")
    private LocalDate screeningDate;

    @Column(name = "screening_time")
    private LocalTime screeningTime;

    private String result;

    @Column(columnDefinition = "TEXT")
    private String notes;

    public SecurityLog() {}

    public SecurityLog(Long id, String logUid, Passenger passenger, Employee employee,
                       LocalDate screeningDate, LocalTime screeningTime, String result, String notes) {
        this.id = id;
        this.logUid = logUid;
        this.passenger = passenger;
        this.employee = employee;
        this.screeningDate = screeningDate;
        this.screeningTime = screeningTime;
        this.result = result;
        this.notes = notes;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getLogUid() { return logUid; }
    public void setLogUid(String logUid) { this.logUid = logUid; }
    public Passenger getPassenger() { return passenger; }
    public void setPassenger(Passenger passenger) { this.passenger = passenger; }
    public Employee getEmployee() { return employee; }
    public void setEmployee(Employee employee) { this.employee = employee; }
    public LocalDate getScreeningDate() { return screeningDate; }
    public void setScreeningDate(LocalDate screeningDate) { this.screeningDate = screeningDate; }
    public LocalTime getScreeningTime() { return screeningTime; }
    public void setScreeningTime(LocalTime screeningTime) { this.screeningTime = screeningTime; }
    public String getResult() { return result; }
    public void setResult(String result) { this.result = result; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}