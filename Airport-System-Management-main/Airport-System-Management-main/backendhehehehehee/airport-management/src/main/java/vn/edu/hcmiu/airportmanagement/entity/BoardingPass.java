package vn.edu.hcmiu.airportmanagement.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "boarding_passes")
public class BoardingPass {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "boarding_pass_uid", unique = true)
    private String boardingPassUid;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "ticket_id")
    private Ticket ticket;

    private String gate;

    @Column(name = "boarding_time")
    private LocalDateTime boardingTime;

    private String status;

    public BoardingPass() {}

    public BoardingPass(Long id, String boardingPassUid, Ticket ticket, String gate,
                        LocalDateTime boardingTime, String status) {
        this.id = id;
        this.boardingPassUid = boardingPassUid;
        this.ticket = ticket;
        this.gate = gate;
        this.boardingTime = boardingTime;
        this.status = status;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBoardingPassUid() { return boardingPassUid; }
    public void setBoardingPassUid(String boardingPassUid) { this.boardingPassUid = boardingPassUid; }
    public Ticket getTicket() { return ticket; }
    public void setTicket(Ticket ticket) { this.ticket = ticket; }
    public String getGate() { return gate; }
    public void setGate(String gate) { this.gate = gate; }
    public LocalDateTime getBoardingTime() { return boardingTime; }
    public void setBoardingTime(LocalDateTime boardingTime) { this.boardingTime = boardingTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
