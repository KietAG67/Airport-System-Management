# Airport System Management

Airport System Management is a desktop airport management application with a JavaFX frontend and a Spring Boot REST backend. The default configuration uses a local H2 file database, so MySQL is not required for local development.


## Features

- Role-based login flow
- Main application shell with sidebar navigation
- Dashboard with KPI cards, recent activity tables, and a flight status chart
- CRUD screens for flights, passengers, tickets, boarding passes, luggage, security logs, and employees
- Profile screen for basic account updates and password change simulation

## Demo Accounts

- `admin@airport.com` / `123456` / `Admin`
- `ops@airport.com` / `123456` / `Operations Staff`
- `security@airport.com` / `123456` / `Security Staff`

## Requirements

- Windows 10 or later
- JDK 17 or newer with `JAVA_HOME` configured
- PowerShell 5.1 or newer
- Internet access on the first build so Maven can download dependencies

Maven does not need to be installed globally. The project uses the Maven Wrapper in the backend module for both the backend and frontend commands.

Check the Java environment:

```powershell
java -version
javac -version
```

## Project Structure

```text
run-app.bat                 # Main Windows launcher
run-app.ps1                 # Starts the backend and frontend
import-tsn-data.ps1         # Imports data from the legacy SQL files
pom.xml                     # JavaFX frontend Maven project
src/main/java/com/airport   # Frontend source code
database/                   # Sample SQL datasets
Airport-System-Management-main/Airport-System-Management-main/
	backendhehehehehee/airport-management/
		mvnw.cmd                 # Backend Maven Wrapper
		pom.xml                  # Spring Boot Maven project
		src/main/java/            # Backend source code
		src/main/resources/       # Backend configuration
```

## Run the Application

Open PowerShell in the directory containing this README, then run:

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\run-app.ps1
```

Alternatively, run the batch file from Command Prompt:

```bat
run-app.bat
```

The launcher will:

1. Check port `8080` and stop an older backend process belonging to this project.
2. Start the Spring Boot backend at `http://localhost:8080`.
3. Wait until the backend is ready.
4. Start the JavaFX frontend.
5. Stop the backend when the frontend closes.

Sign in with one of the demo accounts above.

### Run the Backend Only

Use this mode to test the API or import data:

```powershell
Set-Location .\Airport-System-Management-main\Airport-System-Management-main\backendhehehehehee\airport-management
.\mvnw.cmd spring-boot:run
```

The backend listens on port `8080`. You can verify that it is running by opening `http://localhost:8080` or calling an API endpoint with a tool such as Postman.

### Run the Frontend Only

The backend must already be running on port `8080`:

```powershell
.\Airport-System-Management-main\Airport-System-Management-main\backendhehehehehee\airport-management\mvnw.cmd -f .\pom.xml clean javafx:run
```

If JavaFX modules cannot be found, use JDK 17 or JDK 21, open a new PowerShell window, and run the command again.

## Database

The default backend configuration is:

- Database: H2 file database
- JDBC URL: `jdbc:h2:file:./target/data/airport-management`
- Backend port: `8080`
- Hibernate schema mode: `ddl-auto=update`

The database file is created at:

```text
Airport-System-Management-main/Airport-System-Management-main/backendhehehehehee/airport-management/target/data/airport-management.mv.db
```

Do not delete this file if you want to keep existing data. Demo accounts are seeded during the first backend startup.

### Use MySQL

Set these environment variables before starting the application:

```powershell
$env:AIRPORT_DB_URL = "jdbc:mysql://localhost:3306/airport_management?createDatabaseIfNotExist=true&useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true"
$env:AIRPORT_DB_USERNAME = "root"
$env:AIRPORT_DB_PASSWORD = "your_password"
.\run-app.ps1
```

## Import TSN Data

The backend must be running before importing data. Run these commands from the project root.

Import the large dataset:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\import-tsn-data.ps1 -Dataset large
```

Import the small dataset:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\import-tsn-data.ps1 -Dataset small
```

Preview an import without writing data:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\import-tsn-data.ps1 -Dataset large -DryRun
```

The script converts the legacy SQL format to the current REST API format and imports employees, passengers, flights, tickets, boarding passes, luggage, and security logs. `Crew_Flight` and `Security_Restricted_Items` are skipped because the current application has no matching entities or screens.

## Troubleshooting

### Port 8080 Is Already in Use

Close the old backend or the application using this port, then run the launcher again. To find the process, run:

```powershell
Get-NetTCPConnection -LocalPort 8080 -State Listen
```

### The Backend Does Not Start

Check these log files:

```text
target/run-logs/backend.out.log
target/run-logs/backend.err.log
```

Also check the Java installation, write access to `target/data`, and the MySQL settings if any `AIRPORT_DB_*` variables are configured.

### The JavaFX Frontend Does Not Open

Use JDK 17 or JDK 21, close old JavaFX processes, and run `run-app.bat` again. If Maven dependency resolution failed, delete the frontend and backend `target` directories and rebuild.

## Data and Credentials

The sample data is stored in the `database/` directory. Do not commit real MySQL credentials or generated H2 database files to the repository.
