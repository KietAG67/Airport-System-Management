package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.Passenger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface PassengerRepository extends JpaRepository<Passenger, Long> {
    @Query("SELECT p FROM Passenger p WHERE " +
           "p.passengerUid LIKE %:q% OR p.fullName LIKE %:q% OR " +
           "p.passportNumber LIKE %:q% OR p.email LIKE %:q% OR p.phone LIKE %:q%")
    List<Passenger> search(@Param("q") String q);
}