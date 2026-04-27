package vn.edu.hcmiu.airportmanagement.repository;

import vn.edu.hcmiu.airportmanagement.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByUsername(String username);
}