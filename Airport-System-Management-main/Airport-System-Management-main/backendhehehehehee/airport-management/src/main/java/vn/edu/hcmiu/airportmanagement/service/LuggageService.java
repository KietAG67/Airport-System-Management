package vn.edu.hcmiu.airportmanagement.service;

import vn.edu.hcmiu.airportmanagement.entity.Luggage;
import vn.edu.hcmiu.airportmanagement.repository.LuggageRepository;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class LuggageService {

    private final LuggageRepository luggageRepository;

    public LuggageService(LuggageRepository luggageRepository) {
        this.luggageRepository = luggageRepository;
    }

    public List<Luggage> getAll() {
        return luggageRepository.findAll();
    }

    public Optional<Luggage> getById(Long id) {
        return luggageRepository.findById(id);
    }

    public List<Luggage> search(String keyword) {
        return luggageRepository.search(keyword);
    }

    public Luggage create(Luggage luggage) {
        if (luggage.getLuggageUid() == null || luggage.getLuggageUid().isBlank()) {
            luggage.setLuggageUid(generateUid());
        }
        return luggageRepository.save(luggage);
    }

    public Luggage update(Long id, Luggage updated) {
        Luggage luggage = luggageRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Not found"));
        luggage.setLuggageUid(updated.getLuggageUid());
        luggage.setTicket(updated.getTicket());
        luggage.setWeight(updated.getWeight());
        luggage.setStatus(updated.getStatus());
        luggage.setCheckedInTime(updated.getCheckedInTime());
        return luggageRepository.save(luggage);
    }

    public void delete(Long id) {
        luggageRepository.deleteById(id);
    }

    private String generateUid() {
        long count = luggageRepository.count();
        return String.format("LUG-%04d", count + 1);
    }
}