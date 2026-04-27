package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.BoardingPass;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface BoardingPassRepository extends JpaRepository<BoardingPass, Long> {
    @Query("SELECT b FROM BoardingPass b JOIN b.ticket t JOIN t.passenger p JOIN t.flight f WHERE " +
           "b.boardingPassUid LIKE %:q% OR p.fullName LIKE %:q% OR f.flightNumber LIKE %:q%")
    List<BoardingPass> search(@Param("q") String q);
}