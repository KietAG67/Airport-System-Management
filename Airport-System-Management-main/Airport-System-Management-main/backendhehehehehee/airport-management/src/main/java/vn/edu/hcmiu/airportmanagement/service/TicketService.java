package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Ticket;
import vn.edu.hcmiu.airportmanagement.entity.Passenger;
import vn.edu.hcmiu.airportmanagement.entity.Flight;
import vn.edu.hcmiu.airportmanagement.repository.PassengerRepository;
import vn.edu.hcmiu.airportmanagement.repository.FlightRepository;
import vn.edu.hcmiu.airportmanagement.repository.TicketRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TicketService {

    private final TicketRepository ticketRepository;
    private final PassengerRepository passengerRepository;
    private final FlightRepository flightRepository;

    public TicketService(TicketRepository ticketRepository,
                         PassengerRepository passengerRepository,
                         FlightRepository flightRepository) {
        this.ticketRepository = ticketRepository;
        this.passengerRepository = passengerRepository;
        this.flightRepository = flightRepository;
    }

    public List<Ticket> getAllTickets() {
        return ticketRepository.findAll();
    }

    public Optional<Ticket> getTicketById(Long id) {
        return ticketRepository.findById(id);
    }

    public List<Ticket> searchTickets(String keyword) {
        return ticketRepository.search(keyword);
    }

    public List<Ticket> filterByStatus(String status) {
        return ticketRepository.findByStatus(status);
    }

    public Ticket createTicket(Ticket ticket) {
        if (ticket.getTicketUid() == null || ticket.getTicketUid().isBlank()) {
            ticket.setTicketUid(generateTicketUid());
        }
        ticket.setPassenger(resolvePassenger(ticket.getPassenger()));
        ticket.setFlight(resolveFlight(ticket.getFlight()));
        return ticketRepository.save(ticket);
    }

    public Ticket updateTicket(Long id, Ticket updated) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        ticket.setTicketUid(updated.getTicketUid());
        ticket.setPassenger(resolvePassenger(updated.getPassenger()));
        ticket.setFlight(resolveFlight(updated.getFlight()));
        ticket.setSeatNumber(updated.getSeatNumber());
        ticket.setSeatClass(updated.getSeatClass());
        ticket.setPrice(updated.getPrice());
        ticket.setPurchaseDate(updated.getPurchaseDate());
        ticket.setStatus(updated.getStatus());
        ticket.setTerminal(updated.getTerminal());
        return ticketRepository.save(ticket);
    }

    public void deleteTicket(Long id) {
        ticketRepository.deleteById(id);
    }

    private String generateTicketUid() {
        long count = ticketRepository.count();
        return String.format("TCK-%04d", count + 1);
    }

    private Passenger resolvePassenger(Passenger passenger) {
        if (passenger == null || passenger.getId() == null) {
            throw new RuntimeException("Passenger is required");
        }
        return passengerRepository.findById(passenger.getId())
                .orElseThrow(() -> new RuntimeException("Passenger not found"));
    }

    private Flight resolveFlight(Flight flight) {
        if (flight == null || flight.getId() == null) {
            throw new RuntimeException("Flight is required");
        }
        return flightRepository.findById(flight.getId())
                .orElseThrow(() -> new RuntimeException("Flight not found"));
    }
}
