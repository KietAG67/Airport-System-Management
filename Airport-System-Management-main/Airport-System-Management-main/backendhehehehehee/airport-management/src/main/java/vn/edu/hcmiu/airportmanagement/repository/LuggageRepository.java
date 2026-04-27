package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.Luggage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface LuggageRepository extends JpaRepository<Luggage, Long> {
    @Query("SELECT l FROM Luggage l JOIN l.ticket t JOIN t.passenger p WHERE " +
           "l.luggageUid LIKE %:q% OR p.fullName LIKE %:q%")
    List<Luggage> search(@Param("q") String q);
}