package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.SecurityLog;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.util.List;

public interface SecurityLogRepository extends JpaRepository<SecurityLog, Long> {
    @Query("SELECT s FROM SecurityLog s JOIN s.passenger p JOIN s.employee e WHERE " +
           "s.logUid LIKE %:q% OR p.fullName LIKE %:q% OR e.fullName LIKE %:q% OR s.notes LIKE %:q%")
    List<SecurityLog> search(@Param("q") String q);

    // Đếm các log có kết quả FLAGGED hoặc REJECTED
    long countByResultIn(List<String> results);

    // Lấy 5 log gần nhất (theo ngày và giờ)
    List<SecurityLog> findTop5ByOrderByScreeningDateDescScreeningTimeDesc();
}