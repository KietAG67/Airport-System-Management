package vn.edu.hcmiu.airportmanagement.service;

import org.springframework.stereotype.Service;
import vn.edu.hcmiu.airportmanagement.repository.*;
import java.util.*;

@Service
public class DashboardService {

    private final FlightRepository flightRepo;
    private final PassengerRepository passengerRepo;
    private final LuggageRepository luggageRepo;
    private final SecurityLogRepository securityLogRepo;

    public DashboardService(FlightRepository flightRepo,
                            PassengerRepository passengerRepo,
                            LuggageRepository luggageRepo,
                            SecurityLogRepository securityLogRepo) {
        this.flightRepo = flightRepo;
        this.passengerRepo = passengerRepo;
        this.luggageRepo = luggageRepo;
        this.securityLogRepo = securityLogRepo;
    }

    public Map<String, Object> getDashboard() {
        Map<String, Object> data = new HashMap<>();
        data.put("totalFlights", flightRepo.count());
        data.put("totalPassengers", passengerRepo.count());
        data.put("checkedInLuggages", luggageRepo.count());
        // Security alerts = FLAGGED + REJECTED
        long alerts = securityLogRepo.countByResultIn(List.of("FLAGGED", "REJECTED"));
        data.put("securityAlerts", alerts);
        long delayed = flightRepo.countByStatus("DELAYED");
        data.put("delayedFlights", delayed);

        // Flight status distribution
        Map<String, Long> statusCount = new LinkedHashMap<>();
        for (String s : List.of("ON_TIME", "DELAYED", "BOARDING", "DEPARTED", "ARRIVED", "CANCELLED")) {
            statusCount.put(s, flightRepo.countByStatus(s));
        }
        data.put("flightStatus", statusCount);

        // Recent flights
        data.put("recentFlights", flightRepo.findTop5ByOrderByDepartureTimeDesc());

        // Recent security logs
        data.put("recentSecurityLogs", securityLogRepo.findTop5ByOrderByScreeningDateDescScreeningTimeDesc());

        return data;
    }
}