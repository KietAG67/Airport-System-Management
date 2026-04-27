package vn.edu.hcmiu.airportmanagement.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "luggages")
public class Luggage {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "luggage_uid", unique = true)
    private String luggageUid;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "ticket_id")
    private Ticket ticket;

    private Double weight;

    private String status;

    @Column(name = "checked_in_time")
    private LocalDateTime checkedInTime;

    public Luggage() {}

    public Luggage(Long id, String luggageUid, Ticket ticket, Double weight,
                   String status, LocalDateTime checkedInTime) {
        this.id = id;
        this.luggageUid = luggageUid;
        this.ticket = ticket;
        this.weight = weight;
        this.status = status;
        this.checkedInTime = checkedInTime;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getLuggageUid() { return luggageUid; }
    public void setLuggageUid(String luggageUid) { this.luggageUid = luggageUid; }
    public Ticket getTicket() { return ticket; }
    public void setTicket(Ticket ticket) { this.ticket = ticket; }
    public Double getWeight() { return weight; }
    public void setWeight(Double weight) { this.weight = weight; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCheckedInTime() { return checkedInTime; }
    public void setCheckedInTime(LocalDateTime checkedInTime) { this.checkedInTime = checkedInTime; }
}