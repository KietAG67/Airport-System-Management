package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.Ticket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface TicketRepository extends JpaRepository<Ticket, Long> {
    @Query("SELECT t FROM Ticket t JOIN t.passenger p JOIN t.flight f WHERE " +
           "t.ticketUid LIKE %:q% OR p.fullName LIKE %:q% OR f.flightNumber LIKE %:q%")
    List<Ticket> search(@Param("q") String q);

    List<Ticket> findByStatus(String status);
}