# Airport System Management

A JavaFX desktop frontend connected to a Spring Boot REST backend. The backend stores data in a local H2 file database by default so the system can run from `run-app.bat` without a separate MySQL setup.

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
- No global Maven install is required. The project uses the backend Maven Wrapper.

## Run

```bat
run-app.bat
```

`run-app.bat` starts the backend on port `8080`, waits for it to become available, then opens the JavaFX frontend.

To use MySQL instead of the default H2 file database, set these environment variables before running:

```bat
set AIRPORT_DB_URL=jdbc:mysql://localhost:3306/airport_management?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
set AIRPORT_DB_USERNAME=root
set AIRPORT_DB_PASSWORD=your_password
run-app.bat
```

## Project Structure

```text
run-app.bat
run-app.ps1
pom.xml
src/main/java/com/airport/AirportManagementApp.java
src/main/resources/styles/app.css
Airport-System-Management-main/Airport-System-Management-main/backendhehehehehee/airport-management/pom.xml
Airport-System-Management-main/Airport-System-Management-main/backendhehehehehee/airport-management/src/main/java/vn/edu/hcmiu/airportmanagement
Airport-System-Management-main/Airport-System-Management-main/backendhehehehehee/airport-management/src/main/resources/application.properties
```

## Notes

- Default database file: `Airport-System-Management-main/Airport-System-Management-main/backendhehehehehee/airport-management/target/data/airport-management.mv.db`
- Demo accounts are seeded by the backend on first startup.
