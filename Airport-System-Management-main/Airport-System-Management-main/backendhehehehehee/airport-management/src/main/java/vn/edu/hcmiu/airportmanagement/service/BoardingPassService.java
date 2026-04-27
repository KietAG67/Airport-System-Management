package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.BoardingPass;
import vn.edu.hcmiu.airportmanagement.repository.BoardingPassRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class BoardingPassService {

    private final BoardingPassRepository boardingPassRepository;

    public BoardingPassService(BoardingPassRepository boardingPassRepository) {
        this.boardingPassRepository = boardingPassRepository;
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
        return boardingPassRepository.save(boardingPass);
    }

    public BoardingPass update(Long id, BoardingPass updated) {
        BoardingPass bp = boardingPassRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        bp.setBoardingPassUid(updated.getBoardingPassUid());
        bp.setTicket(updated.getTicket());
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
}