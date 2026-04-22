# Airport Frontend (JavaFX)

Frontend mock cho hệ thống quản lý sân bay bằng JavaFX, bao gồm:

- Login + phân quyền role
- Main Shell + sidebar navigation
- Dashboard KPI + recent tables + flight status bar chart
- CRUD màn Flights / Passengers / Tickets / Boarding Pass / Luggage / Security Log
- Profile (edit thông tin cơ bản, đổi password giả lập)

## Demo Accounts

- `admin@airport.com` / `123456` / `Admin`
- `ops@airport.com` / `123456` / `Operations Staff`
- `security@airport.com` / `123456` / `Security Staff`

## Run

Yêu cầu Java 17+ và Maven.

```bash
mvn clean javafx:run
```

Main class: `com.airport.AirportManagementApp`
