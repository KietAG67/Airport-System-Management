package vn.edu.hcmiu.airportmanagement.controller;

import vn.edu.hcmiu.airportmanagement.entity.BoardingPass;
import vn.edu.hcmiu.airportmanagement.service.BoardingPassService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/boarding-passes")
public class BoardingPassController {

    private final BoardingPassService boardingPassService;

    public BoardingPassController(BoardingPassService boardingPassService) {
        this.boardingPassService = boardingPassService;
    }

    @GetMapping
    public List<BoardingPass> getAll(@RequestParam(required = false) String search) {
        if (search != null) return boardingPassService.search(search);
        return boardingPassService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<BoardingPass> getById(@PathVariable Long id) {
        return boardingPassService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public BoardingPass create(@RequestBody BoardingPass boardingPass) {
        return boardingPassService.create(boardingPass);
    }

    @PutMapping("/{id}")
    public ResponseEntity<BoardingPass> update(@PathVariable Long id, @RequestBody BoardingPass boardingPass) {
        try {
            return ResponseEntity.ok(boardingPassService.update(id, boardingPass));
        } catch (RuntimeException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        boardingPassService.delete(id);
        return ResponseEntity.noContent().build();
    }
}