# Airport System Management

A JavaFX mock frontend for airport operations management. The project focuses on a clean desktop UI for common airport workflows and uses in-memory data for demonstration purposes.

## Features

- Role-based login flow
- Main shell with sidebar navigation
- Dashboard with KPI cards, recent activity tables, and flight status chart
- CRUD screens for flights, passengers, tickets, boarding passes, luggage, security logs, and employees
- Profile screen for basic account updates and password change simulation

## Demo Accounts

- `admin@airport.com` / `123456` / `Admin`
- `ops@airport.com` / `123456` / `Operations Staff`
- `security@airport.com` / `123456` / `Security Staff`

## Requirements

- Java 17 or newer
- Maven 3.9 or newer

## Run

```bash
mvn clean javafx:run
```

Main class: `com.airport.AirportManagementApp`

## Project Structure

```text
src/main/java/com/airport/AirportManagementApp.java
src/main/resources/styles/app.css
pom.xml
```

## Notes

- This is a frontend mock application.
- Data is stored in memory and resets each time the application restarts.
