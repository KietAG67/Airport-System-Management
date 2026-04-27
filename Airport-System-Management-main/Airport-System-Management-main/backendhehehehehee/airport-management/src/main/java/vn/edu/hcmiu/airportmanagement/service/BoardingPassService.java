package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.BoardingPass;
import vn.edu.hcmiu.airportmanagement.entity.Ticket;
import vn.edu.hcmiu.airportmanagement.repository.BoardingPassRepository;
import vn.edu.hcmiu.airportmanagement.repository.TicketRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BoardingPassService {

    private final BoardingPassRepository boardingPassRepository;
    private final TicketRepository ticketRepository;

    public BoardingPassService(BoardingPassRepository boardingPassRepository, TicketRepository ticketRepository) {
        this.boardingPassRepository = boardingPassRepository;
        this.ticketRepository = ticketRepository;
    }

    public List<BoardingPass> getAll() {
        return boardingPassRepository.findAll();
    }

    public Optional<BoardingPass> getById(Long id) {
        return boardingPassRepository.findById(id);
    }

    public List<BoardingPass> search(String keyword) {
        return boardingPassRepository.search(keyword);
    }

    public BoardingPass create(BoardingPass boardingPass) {
        if (boardingPass.getBoardingPassUid() == null || boardingPass.getBoardingPassUid().isBlank()) {
            boardingPass.setBoardingPassUid(generateUid());
        }
        boardingPass.setTicket(resolveTicket(boardingPass.getTicket()));
        return boardingPassRepository.save(boardingPass);
    }

    public BoardingPass update(Long id, BoardingPass updated) {
        BoardingPass bp = boardingPassRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        bp.setBoardingPassUid(updated.getBoardingPassUid());
        bp.setTicket(resolveTicket(updated.getTicket()));
        bp.setGate(updated.getGate());
        bp.setBoardingTime(updated.getBoardingTime());
        bp.setStatus(updated.getStatus());
        return boardingPassRepository.save(bp);
    }

    public void delete(Long id) {
        boardingPassRepository.deleteById(id);
    }

    private String generateUid() {
        long count = boardingPassRepository.count();
        return String.format("BDP-%04d", count + 1);
    }

    private Ticket resolveTicket(Ticket ticket) {
        if (ticket == null || ticket.getId() == null) {
            throw new RuntimeException("Ticket is required");
        }
        return ticketRepository.findById(ticket.getId())
                .orElseThrow(() -> new RuntimeException("Ticket not found"));
    }
}
