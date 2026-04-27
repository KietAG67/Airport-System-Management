package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Ticket;
import vn.edu.hcmiu.airportmanagement.repository.TicketRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class TicketService {

    private final TicketRepository ticketRepository;

    public TicketService(TicketRepository ticketRepository) {
        this.ticketRepository = ticketRepository;
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
        return ticketRepository.save(ticket);
    }

    public Ticket updateTicket(Long id, Ticket updated) {
        Ticket ticket = ticketRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
        ticket.setTicketUid(updated.getTicketUid());
        ticket.setPassenger(updated.getPassenger());
        ticket.setFlight(updated.getFlight());
        ticket.setSeatNumber(updated.getSeatNumber());
        ticket.setSeatClass(updated.getSeatClass());
        ticket.setPrice(updated.getPrice());
        ticket.setPurchaseDate(updated.getPurchaseDate());
        ticket.setStatus(updated.getStatus());
        return ticketRepository.save(ticket);
    }

    public void deleteTicket(Long id) {
        ticketRepository.deleteById(id);
    }

    private String generateTicketUid() {
        long count = ticketRepository.count();
        return String.format("TCK-%04d", count + 1);
    }
}