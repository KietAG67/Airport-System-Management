package vn.edu.hcmiu.airportmanagement.entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tickets")
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ticket_uid", unique = true)
    private String ticketUid;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "passenger_id")
    private Passenger passenger;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "flight_id")
    private Flight flight;

    @Column(name = "seat_number")
    private String seatNumber;

    @Column(name = "seat_class")
    private String seatClass;

    private BigDecimal price;

    @Column(name = "purchase_date")
    private LocalDateTime purchaseDate;

    private String status;

    public Ticket() {}

    public Ticket(Long id, String ticketUid, Passenger passenger, Flight flight,
                  String seatNumber, String seatClass, BigDecimal price,
                  LocalDateTime purchaseDate, String status) {
        this.id = id;
        this.ticketUid = ticketUid;
        this.passenger = passenger;
        this.flight = flight;
        this.seatNumber = seatNumber;
        this.seatClass = seatClass;
        this.price = price;
        this.purchaseDate = purchaseDate;
        this.status = status;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getTicketUid() { return ticketUid; }
    public void setTicketUid(String ticketUid) { this.ticketUid = ticketUid; }
    public Passenger getPassenger() { return passenger; }
    public void setPassenger(Passenger passenger) { this.passenger = passenger; }
    public Flight getFlight() { return flight; }
    public void setFlight(Flight flight) { this.flight = flight; }
    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }
    public String getSeatClass() { return seatClass; }
    public void setSeatClass(String seatClass) { this.seatClass = seatClass; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public LocalDateTime getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(LocalDateTime purchaseDate) { this.purchaseDate = purchaseDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
