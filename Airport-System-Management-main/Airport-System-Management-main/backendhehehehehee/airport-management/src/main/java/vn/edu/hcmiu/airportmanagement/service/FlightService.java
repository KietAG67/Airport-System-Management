package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Flight;
import vn.edu.hcmiu.airportmanagement.repository.FlightRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class FlightService {

    private final FlightRepository flightRepository;

    public FlightService(FlightRepository flightRepository) {
        this.flightRepository = flightRepository;
    }

    // Lấy tất cả chuyến bay
    public List<Flight> getAllFlights() {
        return flightRepository.findAll();
    }

    // Lấy theo ID
    public Optional<Flight> getFlightById(Long id) {
        return flightRepository.findById(id);
    }

    // Tìm kiếm theo từ khóa (UID, số hiệu, sân bay)
    public List<Flight> searchFlights(String keyword) {
        return flightRepository.search(keyword);
    }

    // Lọc theo trạng thái
    public List<Flight> filterByStatus(String status) {
        return flightRepository.findByStatus(status);
    }

    // Tạo mới chuyến bay
    public Flight createFlight(Flight flight) {
        if (flight.getFlightUid() == null || flight.getFlightUid().isBlank()) {
            flight.setFlightUid(generateFlightUid());
        }
        return flightRepository.save(flight);
    }

    // Cập nhật chuyến bay
    public Flight updateFlight(Long id, Flight updated) {
        Flight flight = flightRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Flight not found"));
        flight.setFlightUid(updated.getFlightUid());
        flight.setFlightNumber(updated.getFlightNumber());
        flight.setAircraft(updated.getAircraft());
        flight.setDepartureAirport(updated.getDepartureAirport());
        flight.setArrivalAirport(updated.getArrivalAirport());
        flight.setDepartureTime(updated.getDepartureTime());
        flight.setArrivalTime(updated.getArrivalTime());
        flight.setActualDeparture(updated.getActualDeparture());
        flight.setActualArrival(updated.getActualArrival());
        flight.setStatus(updated.getStatus());
        return flightRepository.save(flight);
    }

    // Xóa chuyến bay
    public void deleteFlight(Long id) {
        flightRepository.deleteById(id);
    }

    // Helper: sinh Flight UID
    private String generateFlightUid() {
        long count = flightRepository.count();
        return String.format("FLT-%04d", count + 1);
    }
}