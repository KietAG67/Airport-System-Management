package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.Flight;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface FlightRepository extends JpaRepository<Flight, Long> {
    // Tìm kiếm theo keyword (flight UID, số hiệu, sân bay đi, sân bay đến)
    @Query("SELECT f FROM Flight f WHERE " +
           "f.flightUid LIKE %:q% OR f.flightNumber LIKE %:q% OR " +
           "f.departureAirport LIKE %:q% OR f.arrivalAirport LIKE %:q%")
    List<Flight> search(@Param("q") String q);

    // Lọc theo trạng thái (On Time, Delayed, ...)
    List<Flight> findByStatus(String status);

    // Đếm số chuyến bay theo trạng thái (dùng cho Dashboard)
    long countByStatus(String status);

    // Lấy 5 chuyến bay gần nhất (theo thời gian khởi hành)
    List<Flight> findTop5ByOrderByDepartureTimeDesc();
}