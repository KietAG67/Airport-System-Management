package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Passenger;
import vn.edu.hcmiu.airportmanagement.repository.PassengerRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PassengerService {

    private final PassengerRepository passengerRepository;

    public PassengerService(PassengerRepository passengerRepository) {
        this.passengerRepository = passengerRepository;
    }

    public List<Passenger> getAllPassengers() {
        return passengerRepository.findAll();
    }

    public Optional<Passenger> getPassengerById(Long id) {
        return passengerRepository.findById(id);
    }

    public List<Passenger> searchPassengers(String keyword) {
        return passengerRepository.search(keyword);
    }

    public Passenger createPassenger(Passenger passenger) {
        if (passenger.getPassengerUid() == null || passenger.getPassengerUid().isBlank()) {
            passenger.setPassengerUid(generatePassengerUid());
        }
        return passengerRepository.save(passenger);
    }

    public Passenger updatePassenger(Long id, Passenger updated) {
        Passenger passenger = passengerRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Passenger not found"));
        passenger.setPassengerUid(updated.getPassengerUid());
        passenger.setFullName(updated.getFullName());
        passenger.setPassportNumber(updated.getPassportNumber());
        passenger.setEmail(updated.getEmail());
        passenger.setPhone(updated.getPhone());
        passenger.setNationality(updated.getNationality());
        return passengerRepository.save(passenger);
    }

    public void deletePassenger(Long id) {
        passengerRepository.deleteById(id);
    }

    private String generatePassengerUid() {
        long count = passengerRepository.count();
        return String.format("PAS-%04d", count + 1);
    }
}