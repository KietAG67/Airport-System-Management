package vn.edu.hcmiu.airportmanagement.controller;

import vn.edu.hcmiu.airportmanagement.entity.Luggage;
import vn.edu.hcmiu.airportmanagement.service.LuggageService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/luggages")
public class LuggageController {

    private final LuggageService luggageService;

    public LuggageController(LuggageService luggageService) {
        this.luggageService = luggageService;
    }

    @GetMapping
    public List<Luggage> getAll(@RequestParam(required = false) String search) {
        if (search != null) return luggageService.search(search);
        return luggageService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Luggage> getById(@PathVariable Long id) {
        return luggageService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Luggage create(@RequestBody Luggage luggage) {
        return luggageService.create(luggage);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Luggage> update(@PathVariable Long id, @RequestBody Luggage luggage) {
        try {
            return ResponseEntity.ok(luggageService.update(id, luggage));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        luggageService.delete(id);
        return ResponseEntity.noContent().build();
    }
}