package vn.edu.hcmiu.airportmanagement.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "passengers")
public class Passenger {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "passenger_uid", unique = true)
    private String passengerUid;

    @Column(name = "full_name")
    private String fullName;

    @Column(name = "passport_number")
    private String passportNumber;

    @Column(name = "email")
    private String email;

    @Column(name = "phone")
    private String phone;

    @Column(name = "date_of_birth")
    private LocalDate dateOfBirth;

    private String nationality;

    public Passenger() {}

    public Passenger(Long id, String passengerUid, String fullName, String passportNumber,
                     String email, String phone, LocalDate dateOfBirth, String nationality) {
        this.id = id;
        this.passengerUid = passengerUid;
        this.fullName = fullName;
        this.passportNumber = passportNumber;
        this.email = email;
        this.phone = phone;
        this.dateOfBirth = dateOfBirth;
        this.nationality = nationality;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getPassengerUid() { return passengerUid; }
    public void setPassengerUid(String passengerUid) { this.passengerUid = passengerUid; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getPassportNumber() { return passportNumber; }
    public void setPassportNumber(String passportNumber) { this.passportNumber = passportNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public LocalDate getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(LocalDate dateOfBirth) { this.dateOfBirth = dateOfBirth; }
    public String getNationality() { return nationality; }
    public void setNationality(String nationality) { this.nationality = nationality; }
}
