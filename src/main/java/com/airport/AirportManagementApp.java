package com.airport;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import javafx.application.Application;
import javafx.beans.property.ReadOnlyStringWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.collections.transformation.SortedList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.chart.BarChart;
import javafx.scene.chart.CategoryAxis;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonBar;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Dialog;
import javafx.scene.control.Label;
import javafx.scene.control.PasswordField;
import javafx.scene.control.Separator;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableRow;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Priority;
import javafx.scene.layout.Region;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.TilePane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import javafx.util.StringConverter;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.ConnectException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;
import java.net.URL;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.Comparator;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class AirportManagementApp extends Application {
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("H:mm");
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    private final MockAirportService mockService = new MockAirportService();
    private Stage primaryStage;

    @Override
    public void start(Stage stage) {
        primaryStage = stage;
        primaryStage.setTitle("SkyBridge Airport Console");
        showLoginScreen();
        primaryStage.show();
    }

    private void showLoginScreen() {
        Label appTitle = new Label("SkyBridge");
        appTitle.getStyleClass().add("login-title");
        Label appSubtitle = new Label("Airport Operations System");
        appSubtitle.getStyleClass().add("login-subtitle");

        TextField emailField = new TextField();
        emailField.setPromptText("Email");

        PasswordField passwordField = new PasswordField();
        passwordField.setPromptText("Password");

        ComboBox<Role> roleCombo = new ComboBox<>();
        roleCombo.getItems().addAll(Role.values());
        roleCombo.setPromptText("Select role");
        roleCombo.setConverter(enumConverter(Role::getDisplayName, ""));

        Label errorLabel = new Label();
        errorLabel.getStyleClass().add("form-error");
        errorLabel.setWrapText(true);

        Button loginButton = new Button("Login");
        loginButton.getStyleClass().add("primary-button");
        loginButton.setMaxWidth(Double.MAX_VALUE);

        Runnable handleLogin = () -> {
            String email = trim(emailField.getText());
            String password = trim(passwordField.getText());
            Role role = roleCombo.getValue();

            if (isBlank(email) || isBlank(password) || role == null) {
                errorLabel.setText("Please enter email, password and role.");
                return;
            }

            UserAccount user = mockService.authenticate(email, password, role);
            if (user == null) {
                String errorMessage = mockService.getLastError();
                errorLabel.setText(isBlank(errorMessage) ? "Invalid credentials" : errorMessage);
                return;
            }

            errorLabel.setText("");
            showMainShell(user);
        };

        loginButton.setOnAction(event -> handleLogin.run());
        emailField.setOnAction(event -> handleLogin.run());
        passwordField.setOnAction(event -> handleLogin.run());

        VBox form = new VBox(12,
                appTitle,
                appSubtitle,
                emailField,
                passwordField,
                roleCombo,
                loginButton,
                errorLabel
        );
        form.getStyleClass().add("login-card");
        form.setMaxWidth(420);
        form.setPadding(new Insets(30));

        StackPane root = new StackPane(form);
        root.getStyleClass().add("login-root");

        Scene scene = buildScene(root, 1040, 720);
        primaryStage.setScene(scene);
    }

    private void showMainShell(UserAccount user) {
        MainShellView shellView = new MainShellView(user);
        Scene scene = buildScene(shellView, 1400, 860);
        primaryStage.setScene(scene);
    }

    private Scene buildScene(Parent root, double width, double height) {
        Scene scene = new Scene(root, width, height);
        URL cssUrl = getClass().getResource("/styles/app.css");
        if (cssUrl != null) {
            scene.getStylesheets().add(cssUrl.toExternalForm());
        }
        return scene;
    }

    private void styleDialog(Dialog<?> dialog) {
        URL cssUrl = getClass().getResource("/styles/app.css");
        if (cssUrl != null) {
            dialog.getDialogPane().getStylesheets().add(cssUrl.toExternalForm());
        }
        dialog.getDialogPane().getStyleClass().add("dialog-pane-custom");
    }

    private <T> void preserveTypedDialogResult(Dialog<T> dialog, ButtonType saveType) {
        dialog.setResultConverter(buttonType -> buttonType == saveType ? dialog.getResult() : null);
    }

    private void showInfo(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION, message, ButtonType.OK);
        alert.setHeaderText(null);
        alert.setTitle(title);
        styleAlert(alert);
        alert.showAndWait();
    }

    private void showError(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.ERROR, message, ButtonType.OK);
        alert.setHeaderText(null);
        alert.setTitle(title);
        styleAlert(alert);
        alert.showAndWait();
    }

    private boolean confirm(String title, String message) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION, message, ButtonType.YES, ButtonType.NO);
        alert.setHeaderText(null);
        alert.setTitle(title);
        styleAlert(alert);
        Optional<ButtonType> result = alert.showAndWait();
        return result.isPresent() && result.get() == ButtonType.YES;
    }

    private void styleAlert(Alert alert) {
        URL cssUrl = getClass().getResource("/styles/app.css");
        if (cssUrl != null) {
            alert.getDialogPane().getStylesheets().add(cssUrl.toExternalForm());
        }
        alert.getDialogPane().getStyleClass().add("dialog-pane-custom");
    }

    private <T> TableColumn<T, String> stringColumn(String name, java.util.function.Function<T, String> mapper, double width) {
        TableColumn<T, String> column = new TableColumn<>(name);
        column.setCellValueFactory(cell -> new ReadOnlyStringWrapper(mapper.apply(cell.getValue())));
        if (width > 0) {
            column.setPrefWidth(width);
        }
        return column;
    }

    private String formatDate(LocalDate date) {
        return date == null ? "" : DATE_FORMATTER.format(date);
    }

    private String formatDateTime(LocalDateTime dateTime) {
        return dateTime == null ? "" : DATE_TIME_FORMATTER.format(dateTime);
    }

    private String formatOptionalDateTime(LocalDateTime dateTime) {
        return dateTime == null ? "Pending" : formatDateTime(dateTime);
    }

    private LocalTime parseTime(String raw) {
        try {
            return LocalTime.parse(trim(raw), TIME_FORMATTER);
        } catch (DateTimeParseException exception) {
            throw new IllegalArgumentException("Time format must be HH:mm");
        }
    }

    private LocalDateTime parseRequiredDateTime(LocalDate date, String timeRaw, String label) {
        if (date == null || isBlank(timeRaw)) {
            throw new IllegalArgumentException(label + " is required.");
        }
        return LocalDateTime.of(date, parseTime(timeRaw));
    }

    private LocalDateTime parseOptionalDateTime(LocalDate date, String timeRaw, String label) {
        boolean hasDate = date != null;
        boolean hasTime = !isBlank(timeRaw);
        if (!hasDate && !hasTime) {
            return null;
        }
        if (hasDate != hasTime) {
            throw new IllegalArgumentException(label + " requires both date and time.");
        }
        return LocalDateTime.of(date, parseTime(timeRaw));
    }

    private LocalDateTime currentTimeRounded() {
        return LocalDateTime.now().withSecond(0).withNano(0);
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private boolean isBlank(String value) {
        return value == null || value.trim().isEmpty();
    }

    private boolean isValidEmail(String email) {
        return !isBlank(email) && EMAIL_PATTERN.matcher(email).matches();
    }

    private <T> StringConverter<T> enumConverter(java.util.function.Function<T, String> labelMapper, String nullLabel) {
        return new StringConverter<>() {
            @Override
            public String toString(T object) {
                if (object == null) {
                    return nullLabel;
                }
                return labelMapper.apply(object);
            }

            @Override
            public T fromString(String string) {
                return null;
            }
        };
    }

    private GridPane createFormGrid() {
        GridPane grid = new GridPane();
        grid.setHgap(10);
        grid.setVgap(10);
        return grid;
    }

    private TextField createReadOnlyField(String value) {
        TextField field = new TextField(value);
        field.setEditable(false);
        field.getStyleClass().add("readonly-field");
        return field;
    }

    private Button createActionButton(String text, String styleClass, Runnable action) {
        Button button = new Button(text);
        button.getStyleClass().add(styleClass);
        button.setMinWidth(92);
        button.setOnAction(event -> action.run());
        return button;
    }

    private HBox buildCrudToolbar(Button addButton, Button editButton, Button deleteButton, Node... leadingNodes) {
        HBox controls = new HBox(10);
        controls.setAlignment(Pos.CENTER_LEFT);
        controls.getChildren().addAll(leadingNodes);

        Region spacer = new Region();
        HBox.setHgrow(spacer, Priority.ALWAYS);
        controls.getChildren().add(spacer);
        controls.getChildren().addAll(addButton, editButton, deleteButton);
        return controls;
    }

    private String passengerDisplay(Passenger passenger) {
        return passenger.getFullName() + " (" + passenger.getPassengerId() + ")";
    }

    private String flightDisplay(Flight flight) {
        return flight.getFlightId() + " - " + flight.getFlightNumber() + " (" + flight.getOrigin() + " -> " + flight.getDestination() + ")";
    }

    private String ticketDisplay(Ticket ticket) {
        return ticket.getTicketId() + " - " + ticket.getPassenger().getFullName() + " / " + ticket.getFlight().getFlightNumber();
    }

    private String employeeDisplay(Employee employee) {
        return employee.getFullName() + " - " + employee.getDepartment();
    }

    private String securityLogEmployeeName(SecurityLog securityLog) {
        Employee employee = securityLog.getEmployee();
        return employee == null ? "Unassigned" : employee.getFullName();
    }

    private interface Refreshable {
        void refresh();
    }

    private final class MainShellView extends BorderPane {
        private static final String DASHBOARD = "Dashboard";
        private static final String FLIGHT_MANAGEMENT = "Flight Management";
        private static final String PASSENGER_MANAGEMENT = "Passenger Management";
        private static final String TICKET_MANAGEMENT = "Ticket Management";
        private static final String BOARDING_PASS = "Boarding Pass";
        private static final String LUGGAGE = "Luggage";
        private static final String SECURITY_LOG = "Security Log";
        private static final String EMPLOYEE = "Employee";
        private static final String PROFILE = "Profile";
        private static final String LOGOUT = "Logout";

        private final UserAccount user;
        private final Map<String, Button> menuButtons = new LinkedHashMap<>();
        private final Map<String, Node> cachedViews = new HashMap<>();
        private final StackPane contentHolder = new StackPane();
        private final Label userNameLabel = new Label();
        private final Label roleLabel = new Label();

        MainShellView(UserAccount user) {
            this.user = user;
            getStyleClass().add("shell-root");
            setLeft(createSidebar());
            setTop(createTopbar());

            contentHolder.getStyleClass().add("content-host");
            contentHolder.setPadding(new Insets(18));
            setCenter(contentHolder);

            setActiveMenu(DASHBOARD);
            openView(DASHBOARD);
        }

        private Node createSidebar() {
            VBox sidebar = new VBox(8);
            sidebar.getStyleClass().add("sidebar");
            sidebar.setPadding(new Insets(20));
            sidebar.setPrefWidth(240);

            Label appName = new Label("SkyBridge");
            appName.getStyleClass().add("sidebar-logo");
            Label appCaption = new Label("Airport Console");
            appCaption.getStyleClass().add("sidebar-caption");

            VBox header = new VBox(4, appName, appCaption);
            header.setPadding(new Insets(0, 0, 12, 0));

            List<String> menuItems = List.of(
                    DASHBOARD,
                    FLIGHT_MANAGEMENT,
                    PASSENGER_MANAGEMENT,
                    TICKET_MANAGEMENT,
                    BOARDING_PASS,
                    LUGGAGE,
                    SECURITY_LOG,
                    EMPLOYEE,
                    PROFILE,
                    LOGOUT
            );

            VBox menuBox = new VBox(6);
            for (String menuName : menuItems) {
                Button button = new Button(menuName);
                button.getStyleClass().add("menu-button");
                button.setMaxWidth(Double.MAX_VALUE);
                button.setOnAction(event -> handleMenuClick(menuName));
                menuButtons.put(menuName, button);
                menuBox.getChildren().add(button);
            }

            Region spacer = new Region();
            VBox.setVgrow(spacer, Priority.ALWAYS);

            Label footer = new Label("Backend API v1.0");
            footer.getStyleClass().add("sidebar-footer");

            sidebar.getChildren().addAll(header, new Separator(), menuBox, spacer, footer);
            return sidebar;
        }

        private Node createTopbar() {
            HBox topbar = new HBox(14);
            topbar.getStyleClass().add("topbar");
            topbar.setAlignment(Pos.CENTER_LEFT);
            topbar.setPadding(new Insets(14, 24, 14, 24));

            Label greeting = new Label("Airport Operations Management");
            greeting.getStyleClass().add("topbar-title");

            Region spacer = new Region();
            HBox.setHgrow(spacer, Priority.ALWAYS);

            userNameLabel.getStyleClass().add("topbar-user");
            roleLabel.getStyleClass().add("topbar-role");
            refreshTopbar();

            topbar.getChildren().addAll(greeting, spacer, userNameLabel, roleLabel);
            return topbar;
        }

        private void refreshTopbar() {
            userNameLabel.setText(user.getFullName());
            roleLabel.setText(user.getRole().getDisplayName());
        }

        private void handleMenuClick(String menuName) {
            if (LOGOUT.equals(menuName)) {
                showLoginScreen();
                return;
            }
            setActiveMenu(menuName);
            openView(menuName);
        }

        private void setActiveMenu(String activeName) {
            for (Map.Entry<String, Button> entry : menuButtons.entrySet()) {
                entry.getValue().getStyleClass().remove("menu-button-active");
                if (entry.getKey().equals(activeName)) {
                    entry.getValue().getStyleClass().add("menu-button-active");
                }
            }
        }

        private void openView(String menuName) {
            refreshTopbar();
            Node view = cachedViews.computeIfAbsent(menuName, this::createViewByMenu);
            if (view instanceof Refreshable refreshable) {
                refreshable.refresh();
            }
            contentHolder.getChildren().setAll(view);
        }

        private Node createViewByMenu(String menuName) {
            return switch (menuName) {
                case DASHBOARD -> new DashboardView();
                case FLIGHT_MANAGEMENT -> new FlightsView();
                case PASSENGER_MANAGEMENT -> new PassengersView();
                case TICKET_MANAGEMENT -> new TicketsView();
                case BOARDING_PASS -> new BoardingPassView();
                case LUGGAGE -> new LuggageView();
                case SECURITY_LOG -> new SecurityLogView(user);
                case EMPLOYEE -> new EmployeesView();
                case PROFILE -> new ProfileView(user, this::refreshTopbar);
                default -> new Label("View not found.");
            };
        }
    }

    private final class DashboardView extends VBox implements Refreshable {
        private final Label totalFlights = createKpiValueLabel();
        private final Label totalPassengers = createKpiValueLabel();
        private final Label checkedInLuggage = createKpiValueLabel();
        private final Label securityAlert = createKpiValueLabel();
        private final Label delayed = createKpiValueLabel();

        private final TableView<Flight> recentFlightsTable = new TableView<>();
        private final TableView<SecurityLog> recentSecurityTable = new TableView<>();
        private final BarChart<String, Number> statusChart;

        DashboardView() {
            getStyleClass().add("content-root");
            setSpacing(16);

            Label title = new Label("Dashboard");
            title.getStyleClass().add("section-title");

            TilePane cardPane = new TilePane();
            cardPane.setHgap(14);
            cardPane.setVgap(14);
            cardPane.setPrefColumns(5);
            cardPane.getStyleClass().add("card-grid");
            cardPane.getChildren().addAll(
                    buildKpiCard("Total Flights", totalFlights, "kpi-blue"),
                    buildKpiCard("Total Passengers", totalPassengers, "kpi-green"),
                    buildKpiCard("Checked-in Luggage", checkedInLuggage, "kpi-cyan"),
                    buildKpiCard("Security Alert", securityAlert, "kpi-red"),
                    buildKpiCard("Delayed", delayed, "kpi-orange")
            );

            CategoryAxis xAxis = new CategoryAxis();
            NumberAxis yAxis = new NumberAxis();
            statusChart = new BarChart<>(xAxis, yAxis);
            statusChart.setLegendVisible(false);
            statusChart.setAnimated(false);
            statusChart.setPrefHeight(250);
            statusChart.getStyleClass().add("status-chart");

            VBox chartContainer = buildTableCard("Flight Status", statusChart);

            configureRecentFlightsTable();
            configureRecentSecurityTable();

            VBox recentFlightsCard = buildTableCard("Recent Flights", recentFlightsTable);
            VBox recentSecurityCard = buildTableCard("Recent Security Logs", recentSecurityTable);

            HBox tableRow = new HBox(14, recentFlightsCard, recentSecurityCard);
            HBox.setHgrow(recentFlightsCard, Priority.ALWAYS);
            HBox.setHgrow(recentSecurityCard, Priority.ALWAYS);
            VBox.setVgrow(tableRow, Priority.ALWAYS);

            getChildren().addAll(title, cardPane, chartContainer, tableRow);
            refresh();
        }

        private Label createKpiValueLabel() {
            Label value = new Label("0");
            value.getStyleClass().add("kpi-value");
            return value;
        }

        private Node buildKpiCard(String title, Label valueLabel, String colorClass) {
            Label titleLabel = new Label(title);
            titleLabel.getStyleClass().add("kpi-title");
            VBox card = new VBox(8, titleLabel, valueLabel);
            card.getStyleClass().addAll("kpi-card", colorClass);
            card.setPrefHeight(110);
            card.setPadding(new Insets(16));
            return card;
        }

        private VBox buildTableCard(String title, Node content) {
            Label label = new Label(title);
            label.getStyleClass().add("card-title");
            VBox card = new VBox(10, label, content);
            card.getStyleClass().add("table-card");
            card.setPadding(new Insets(14));
            VBox.setVgrow(content, Priority.ALWAYS);
            return card;
        }

        private void configureRecentFlightsTable() {
            recentFlightsTable.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            recentFlightsTable.setPlaceholder(new Label("No flights"));
            recentFlightsTable.getColumns().addAll(
                    stringColumn("Flight Number", Flight::getFlightNumber, 120),
                    stringColumn("Origin", Flight::getOrigin, 100),
                    stringColumn("Destination", Flight::getDestination, 110),
                    stringColumn("Departure Time", flight -> formatDateTime(flight.getDepartureTime()), 150),
                    stringColumn("Status", flight -> flight.getStatus().getDisplayName(), 100)
            );
        }

        private void configureRecentSecurityTable() {
            recentSecurityTable.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            recentSecurityTable.setPlaceholder(new Label("No security logs"));
            recentSecurityTable.getColumns().addAll(
                    stringColumn("Log ID", SecurityLog::getLogId, 100),
                    stringColumn("Passenger", log -> log.getPassenger().getFullName(), 140),
                    stringColumn("Employee", AirportManagementApp.this::securityLogEmployeeName, 140),
                    stringColumn("Time", log -> formatDateTime(log.getScreeningTime()), 150),
                    stringColumn("Result", log -> log.getResult().getDisplayName(), 90)
            );
        }

        @Override
        public void refresh() {
            totalFlights.setText(String.valueOf(mockService.countTotalFlights()));
            totalPassengers.setText(String.valueOf(mockService.countTotalPassengers()));
            checkedInLuggage.setText(String.valueOf(mockService.countCheckedInLuggage()));
            securityAlert.setText(String.valueOf(mockService.countSecurityAlerts()));
            delayed.setText(String.valueOf(mockService.countDelayedFlights()));

            recentFlightsTable.setItems(FXCollections.observableArrayList(mockService.getRecentFlights(8)));
            recentSecurityTable.setItems(FXCollections.observableArrayList(mockService.getRecentSecurityLogs(8)));
            updateChart();
        }

        private void updateChart() {
            Map<FlightStatus, Long> statusCounts = mockService.getFlightStatusCounts();
            XYChart.Series<String, Number> series = new XYChart.Series<>();
            for (FlightStatus status : FlightStatus.values()) {
                series.getData().add(new XYChart.Data<>(status.getDisplayName(), statusCounts.getOrDefault(status, 0L)));
            }
            statusChart.getData().setAll(series);
        }
    }

    private final class FlightsView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final ComboBox<FlightStatus> statusFilter = new ComboBox<>();
        private final TableView<Flight> table = new TableView<>();
        private final FilteredList<Flight> filteredFlights = new FilteredList<>(mockService.getFlights(), flight -> true);

        FlightsView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Flight Management");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search flight ID, number, route");
            searchField.setPrefWidth(300);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            statusFilter.getItems().add(null);
            statusFilter.getItems().addAll(FlightStatus.values());
            statusFilter.setValue(null);
            statusFilter.setPrefWidth(160);
            statusFilter.setPromptText("All Status");
            statusFilter.setConverter(enumConverter(FlightStatus::getDisplayName, "All Status"));
            statusFilter.valueProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField, statusFilter);

            configureTable();
            SortedList<Flight> sortedFlights = new SortedList<>(filteredFlights);
            sortedFlights.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedFlights);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No flights"));
            table.getColumns().addAll(
                    stringColumn("Flight ID", Flight::getFlightId, 110),
                    stringColumn("Flight Number", Flight::getFlightNumber, 130),
                    stringColumn("Aircraft", Flight::getAircraft, 130),
                    stringColumn("Origin", Flight::getOrigin, 110),
                    stringColumn("Destination", Flight::getDestination, 120),
                    stringColumn("Actual Departure", flight -> formatOptionalDateTime(flight.getActualDeparture()), 160),
                    stringColumn("Actual Arrival", flight -> formatOptionalDateTime(flight.getActualArrival()), 160),
                    stringColumn("Departure Time", flight -> formatDateTime(flight.getDepartureTime()), 160),
                    stringColumn("Arrival Time", flight -> formatDateTime(flight.getArrivalTime()), 160),
                    stringColumn("Status", flight -> flight.getStatus().getDisplayName(), 110)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            FlightStatus selectedStatus = statusFilter.getValue();

            filteredFlights.setPredicate(flight -> {
                boolean matchesKeyword = keyword.isEmpty()
                        || flight.getFlightId().toLowerCase().contains(keyword)
                        || flight.getFlightNumber().toLowerCase().contains(keyword)
                        || flight.getAircraft().toLowerCase().contains(keyword)
                        || flight.getOrigin().toLowerCase().contains(keyword)
                        || flight.getDestination().toLowerCase().contains(keyword);
                boolean matchesStatus = selectedStatus == null || flight.getStatus() == selectedStatus;
                return matchesKeyword && matchesStatus;
            });
        }

        private void handleAdd() {
            Optional<FlightFormData> result = showFlightDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addFlight(new Flight(
                            mockService.nextFlightId(),
                            formData.flightNumber(),
                            formData.aircraft(),
                            formData.origin(),
                            formData.destination(),
                            formData.departureTime(),
                            formData.arrivalTime(),
                            formData.actualDeparture(),
                            formData.actualArrival(),
                            formData.status()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Flight", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            Flight selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Flight", "Please select a flight to edit.");
                return;
            }

            Optional<FlightFormData> result = showFlightDialog(selected);
            result.ifPresent(formData -> {
                selected.setFlightNumber(formData.flightNumber());
                selected.setAircraft(formData.aircraft());
                selected.setOrigin(formData.origin());
                selected.setDestination(formData.destination());
                selected.setDepartureTime(formData.departureTime());
                selected.setArrivalTime(formData.arrivalTime());
                selected.setActualDeparture(formData.actualDeparture());
                selected.setActualArrival(formData.actualArrival());
                selected.setStatus(formData.status());
                try {
                    mockService.updateFlight(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Flight", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            Flight selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Flight", "Please select a flight to delete.");
                return;
            }
            if (confirm("Delete Flight", "Delete selected flight " + selected.getFlightNumber() + "?")) {
                try {
                    mockService.removeFlight(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Flight", exception.getMessage());
                }
            }
        }

        private Optional<FlightFormData> showFlightDialog(Flight existing) {
            boolean editMode = existing != null;
            Dialog<FlightFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Flight" : "Add Flight");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(520);

            LocalDateTime defaultDeparture = editMode ? existing.getDepartureTime() : currentTimeRounded().plusHours(2);
            LocalDateTime defaultArrival = editMode ? existing.getArrivalTime() : defaultDeparture.plusHours(2);

            TextField idField = createReadOnlyField(editMode ? existing.getFlightId() : "Auto-generated on save");
            TextField flightNumberField = new TextField(editMode ? existing.getFlightNumber() : "");
            TextField aircraftField = new TextField(editMode ? existing.getAircraft() : "");
            TextField originField = new TextField(editMode ? existing.getOrigin() : "");
            TextField destinationField = new TextField(editMode ? existing.getDestination() : "");

            DatePicker departureDatePicker = new DatePicker(defaultDeparture.toLocalDate());
            TextField departureTimeField = new TextField(defaultDeparture.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));
            DatePicker arrivalDatePicker = new DatePicker(defaultArrival.toLocalDate());
            TextField arrivalTimeField = new TextField(defaultArrival.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            LocalDateTime existingActualDeparture = editMode ? existing.getActualDeparture() : null;
            LocalDateTime existingActualArrival = editMode ? existing.getActualArrival() : null;

            DatePicker actualDepartureDatePicker = new DatePicker(existingActualDeparture == null ? null : existingActualDeparture.toLocalDate());
            TextField actualDepartureTimeField = new TextField(existingActualDeparture == null ? "" : existingActualDeparture.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));
            DatePicker actualArrivalDatePicker = new DatePicker(existingActualArrival == null ? null : existingActualArrival.toLocalDate());
            TextField actualArrivalTimeField = new TextField(existingActualArrival == null ? "" : existingActualArrival.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            ComboBox<FlightStatus> statusBox = new ComboBox<>(FXCollections.observableArrayList(FlightStatus.values()));
            statusBox.setConverter(enumConverter(FlightStatus::getDisplayName, ""));
            statusBox.setValue(editMode ? existing.getStatus() : FlightStatus.ON_TIME);

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Flight ID"), idField);
            grid.addRow(1, new Label("Flight Number"), flightNumberField);
            grid.addRow(2, new Label("Aircraft"), aircraftField);
            grid.addRow(3, new Label("Origin"), originField);
            grid.addRow(4, new Label("Destination"), destinationField);
            grid.addRow(5, new Label("Departure Date"), departureDatePicker);
            grid.addRow(6, new Label("Departure Time"), departureTimeField);
            grid.addRow(7, new Label("Arrival Date"), arrivalDatePicker);
            grid.addRow(8, new Label("Arrival Time"), arrivalTimeField);
            grid.addRow(9, new Label("Actual Departure Date"), actualDepartureDatePicker);
            grid.addRow(10, new Label("Actual Departure Time"), actualDepartureTimeField);
            grid.addRow(11, new Label("Actual Arrival Date"), actualArrivalDatePicker);
            grid.addRow(12, new Label("Actual Arrival Time"), actualArrivalTimeField);
            grid.addRow(13, new Label("Status"), statusBox);
            grid.add(errorLabel, 0, 14, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                try {
                    String flightNumber = trim(flightNumberField.getText());
                    String aircraft = trim(aircraftField.getText());
                    String origin = trim(originField.getText());
                    String destination = trim(destinationField.getText());
                    FlightStatus status = statusBox.getValue();

                    if (isBlank(flightNumber) || isBlank(aircraft) || isBlank(origin) || isBlank(destination) || status == null) {
                        errorLabel.setText("All required fields must be completed.");
                        event.consume();
                        return;
                    }
                    if (origin.equalsIgnoreCase(destination)) {
                        errorLabel.setText("Origin must be different from destination.");
                        event.consume();
                        return;
                    }

                    LocalDateTime departureTime = parseRequiredDateTime(departureDatePicker.getValue(), departureTimeField.getText(), "Departure Time");
                    LocalDateTime arrivalTime = parseRequiredDateTime(arrivalDatePicker.getValue(), arrivalTimeField.getText(), "Arrival Time");
                    LocalDateTime actualDeparture = parseOptionalDateTime(actualDepartureDatePicker.getValue(), actualDepartureTimeField.getText(), "Actual Departure");
                    LocalDateTime actualArrival = parseOptionalDateTime(actualArrivalDatePicker.getValue(), actualArrivalTimeField.getText(), "Actual Arrival");

                    if (!departureTime.isBefore(arrivalTime)) {
                        errorLabel.setText("Departure Time must be before Arrival Time.");
                        event.consume();
                        return;
                    }
                    if (actualArrival != null && actualDeparture == null) {
                        errorLabel.setText("Actual Departure is required when Actual Arrival is set.");
                        event.consume();
                        return;
                    }
                    if (actualDeparture != null && actualArrival != null && !actualDeparture.isBefore(actualArrival)) {
                        errorLabel.setText("Actual Departure must be before Actual Arrival.");
                        event.consume();
                        return;
                    }

                    dialog.setResult(new FlightFormData(
                            flightNumber,
                            aircraft,
                            origin,
                            destination,
                            departureTime,
                            arrivalTime,
                            actualDeparture,
                            actualArrival,
                            status
                    ));
                } catch (IllegalArgumentException exception) {
                    errorLabel.setText(exception.getMessage());
                    event.consume();
                }
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class PassengersView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final TableView<Passenger> table = new TableView<>();
        private final FilteredList<Passenger> filteredPassengers = new FilteredList<>(mockService.getPassengers(), passenger -> true);

        PassengersView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Passenger Management");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search full name, passenger ID, passport ID");
            searchField.setPrefWidth(320);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField);

            configureTable();
            SortedList<Passenger> sortedPassengers = new SortedList<>(filteredPassengers);
            sortedPassengers.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedPassengers);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No passengers"));
            table.getColumns().addAll(
                    stringColumn("Full Name", Passenger::getFullName, 180),
                    stringColumn("Passenger ID", Passenger::getPassengerId, 130),
                    stringColumn("Passport ID", Passenger::getPassportId, 140),
                    stringColumn("Email", Passenger::getEmail, 220),
                    stringColumn("Phone", Passenger::getPhone, 140)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            filteredPassengers.setPredicate(passenger -> keyword.isEmpty()
                    || passenger.getFullName().toLowerCase().contains(keyword)
                    || passenger.getPassengerId().toLowerCase().contains(keyword)
                    || passenger.getPassportId().toLowerCase().contains(keyword));
        }

        private void handleAdd() {
            Optional<PassengerFormData> result = showPassengerDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addPassenger(new Passenger(
                            mockService.nextPassengerId(),
                            formData.passportId(),
                            formData.fullName(),
                            formData.dateOfBirth(),
                            formData.nationality(),
                            formData.email(),
                            formData.phone()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Passenger", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            Passenger selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Passenger", "Please select a passenger to edit.");
                return;
            }

            Optional<PassengerFormData> result = showPassengerDialog(selected);
            result.ifPresent(formData -> {
                selected.setPassportId(formData.passportId());
                selected.setFullName(formData.fullName());
                selected.setDateOfBirth(formData.dateOfBirth());
                selected.setNationality(formData.nationality());
                selected.setEmail(formData.email());
                selected.setPhone(formData.phone());
                try {
                    mockService.updatePassenger(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Passenger", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            Passenger selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Passenger", "Please select a passenger to delete.");
                return;
            }
            if (confirm("Delete Passenger", "Delete selected passenger " + selected.getFullName() + "?")) {
                try {
                    mockService.removePassenger(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Passenger", exception.getMessage());
                }
            }
        }

        private Optional<PassengerFormData> showPassengerDialog(Passenger existing) {
            boolean editMode = existing != null;
            Dialog<PassengerFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Passenger" : "Add Passenger");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(500);

            TextField idField = createReadOnlyField(editMode ? existing.getPassengerId() : "Auto-generated on save");
            TextField fullNameField = new TextField(editMode ? existing.getFullName() : "");
            TextField passportIdField = new TextField(editMode ? existing.getPassportId() : "");
            DatePicker dateOfBirthPicker = new DatePicker(editMode ? existing.getDateOfBirth() : LocalDate.of(1995, 1, 1));
            TextField nationalityField = new TextField(editMode ? existing.getNationality() : "");
            TextField emailField = new TextField(editMode ? existing.getEmail() : "");
            TextField phoneField = new TextField(editMode ? existing.getPhone() : "");

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Passenger ID"), idField);
            grid.addRow(1, new Label("Full Name"), fullNameField);
            grid.addRow(2, new Label("Passport ID"), passportIdField);
            grid.addRow(3, new Label("Email"), emailField);
            grid.addRow(4, new Label("Phone"), phoneField);
            grid.addRow(5, new Label("Date of Birth"), dateOfBirthPicker);
            grid.addRow(6, new Label("Nationality"), nationalityField);
            grid.add(errorLabel, 0, 7, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                String fullName = trim(fullNameField.getText());
                String passportId = trim(passportIdField.getText());
                String nationality = trim(nationalityField.getText());
                String email = trim(emailField.getText());
                String phone = trim(phoneField.getText());
                LocalDate dateOfBirth = dateOfBirthPicker.getValue();

                if (isBlank(fullName)) {
                    errorLabel.setText("Full Name is required.");
                    event.consume();
                    return;
                }
                if (isBlank(passportId)) {
                    errorLabel.setText("Passport ID is required.");
                    event.consume();
                    return;
                }
                if (!isValidEmail(email)) {
                    errorLabel.setText("Email format is invalid.");
                    event.consume();
                    return;
                }
                if (isBlank(phone)) {
                    errorLabel.setText("Phone is required.");
                    event.consume();
                    return;
                }
                if (dateOfBirth == null) {
                    errorLabel.setText("Date of Birth is required.");
                    event.consume();
                    return;
                }
                if (isBlank(nationality)) {
                    errorLabel.setText("Nationality is required.");
                    event.consume();
                    return;
                }

                dialog.setResult(new PassengerFormData(
                        passportId,
                        fullName,
                        dateOfBirth,
                        nationality,
                        email,
                        phone
                ));
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class TicketsView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final ComboBox<TicketStatus> statusFilter = new ComboBox<>();
        private final TableView<Ticket> table = new TableView<>();
        private final FilteredList<Ticket> filteredTickets = new FilteredList<>(mockService.getTickets(), ticket -> true);

        TicketsView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Ticket Management");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search ticket, passenger, flight");
            searchField.setPrefWidth(300);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            statusFilter.getItems().add(null);
            statusFilter.getItems().addAll(TicketStatus.values());
            statusFilter.setValue(null);
            statusFilter.setPrefWidth(160);
            statusFilter.setPromptText("All Status");
            statusFilter.setConverter(enumConverter(TicketStatus::getDisplayName, "All Status"));
            statusFilter.valueProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField, statusFilter);

            configureTable();
            SortedList<Ticket> sortedTickets = new SortedList<>(filteredTickets);
            sortedTickets.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedTickets);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No tickets"));
            table.getColumns().addAll(
                    stringColumn("Ticket ID", Ticket::getTicketId, 110),
                    stringColumn("Passenger", ticket -> ticket.getPassenger().getFullName(), 170),
                    stringColumn("Flight", ticket -> ticket.getFlight().getFlightNumber(), 120),
                    stringColumn("Seat Number", Ticket::getSeatNumber, 100),
                    stringColumn("Seat Class", ticket -> ticket.getSeatClass().getDisplayName(), 110),
                    stringColumn("Price", ticket -> String.format("$%.2f", ticket.getPrice()), 100),
                    stringColumn("Purchase Date", ticket -> formatDate(ticket.getPurchaseDate()), 130),
                    stringColumn("Status", ticket -> ticket.getStatus().getDisplayName(), 100)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            TicketStatus selectedStatus = statusFilter.getValue();

            filteredTickets.setPredicate(ticket -> {
                boolean matchesKeyword = keyword.isEmpty()
                        || ticket.getTicketId().toLowerCase().contains(keyword)
                        || ticket.getPassenger().getFullName().toLowerCase().contains(keyword)
                        || ticket.getPassenger().getPassengerId().toLowerCase().contains(keyword)
                        || ticket.getFlight().getFlightNumber().toLowerCase().contains(keyword)
                        || ticket.getFlight().getFlightId().toLowerCase().contains(keyword);
                boolean matchesStatus = selectedStatus == null || ticket.getStatus() == selectedStatus;
                return matchesKeyword && matchesStatus;
            });
        }

        private void handleAdd() {
            if (mockService.getPassengers().isEmpty() || mockService.getFlights().isEmpty()) {
                showError("Add Ticket", "Passengers and flights are required before creating a ticket.");
                return;
            }

            Optional<TicketFormData> result = showTicketDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addTicket(new Ticket(
                            mockService.nextTicketId(),
                            formData.passenger(),
                            formData.flight(),
                            formData.seatNumber(),
                            formData.seatClass(),
                            formData.price(),
                            formData.purchaseDate(),
                            formData.status()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Ticket", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            Ticket selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Ticket", "Please select a ticket to edit.");
                return;
            }

            Optional<TicketFormData> result = showTicketDialog(selected);
            result.ifPresent(formData -> {
                selected.setPassenger(formData.passenger());
                selected.setFlight(formData.flight());
                selected.setSeatNumber(formData.seatNumber());
                selected.setSeatClass(formData.seatClass());
                selected.setPrice(formData.price());
                selected.setPurchaseDate(formData.purchaseDate());
                selected.setStatus(formData.status());
                try {
                    mockService.updateTicket(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Ticket", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            Ticket selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Ticket", "Please select a ticket to delete.");
                return;
            }
            if (confirm("Delete Ticket", "Delete selected ticket " + selected.getTicketId() + "?")) {
                try {
                    mockService.removeTicket(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Ticket", exception.getMessage());
                }
            }
        }

        private Optional<TicketFormData> showTicketDialog(Ticket existing) {
            boolean editMode = existing != null;
            Dialog<TicketFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Ticket" : "Add Ticket");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(500);

            TextField idField = createReadOnlyField(editMode ? existing.getTicketId() : "Auto-generated on save");
            ComboBox<Passenger> passengerBox = new ComboBox<>(mockService.getPassengers());
            passengerBox.setConverter(enumConverter(AirportManagementApp.this::passengerDisplay, ""));
            passengerBox.setValue(editMode ? existing.getPassenger() : null);

            ComboBox<Flight> flightBox = new ComboBox<>(mockService.getFlights());
            flightBox.setConverter(enumConverter(AirportManagementApp.this::flightDisplay, ""));
            flightBox.setValue(editMode ? existing.getFlight() : null);

            TextField seatNumberField = new TextField(editMode ? existing.getSeatNumber() : "");

            ComboBox<SeatClass> seatClassBox = new ComboBox<>(FXCollections.observableArrayList(SeatClass.values()));
            seatClassBox.setConverter(enumConverter(SeatClass::getDisplayName, ""));
            seatClassBox.setValue(editMode ? existing.getSeatClass() : SeatClass.ECONOMY);

            TextField priceField = new TextField(editMode ? String.valueOf(existing.getPrice()) : "100");
            DatePicker purchaseDatePicker = new DatePicker(editMode ? existing.getPurchaseDate() : LocalDate.now());

            ComboBox<TicketStatus> statusBox = new ComboBox<>(FXCollections.observableArrayList(TicketStatus.values()));
            statusBox.setConverter(enumConverter(TicketStatus::getDisplayName, ""));
            statusBox.setValue(editMode ? existing.getStatus() : TicketStatus.BOOKED);

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Ticket ID"), idField);
            grid.addRow(1, new Label("Passenger"), passengerBox);
            grid.addRow(2, new Label("Flight"), flightBox);
            grid.addRow(3, new Label("Seat Number"), seatNumberField);
            grid.addRow(4, new Label("Seat Class"), seatClassBox);
            grid.addRow(5, new Label("Price"), priceField);
            grid.addRow(6, new Label("Purchase Date"), purchaseDatePicker);
            grid.addRow(7, new Label("Status"), statusBox);
            grid.add(errorLabel, 0, 8, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                Passenger passenger = passengerBox.getValue();
                Flight flight = flightBox.getValue();
                String seatNumber = trim(seatNumberField.getText());
                SeatClass seatClass = seatClassBox.getValue();
                String priceRaw = trim(priceField.getText());
                LocalDate purchaseDate = purchaseDatePicker.getValue();
                TicketStatus status = statusBox.getValue();

                if (passenger == null || flight == null || isBlank(seatNumber) || seatClass == null
                        || isBlank(priceRaw) || purchaseDate == null || status == null) {
                    errorLabel.setText("All fields are required.");
                    event.consume();
                    return;
                }

                double price;
                try {
                    price = Double.parseDouble(priceRaw);
                } catch (NumberFormatException exception) {
                    errorLabel.setText("Price must be a valid number.");
                    event.consume();
                    return;
                }
                if (price <= 0) {
                    errorLabel.setText("Price must be greater than 0.");
                    event.consume();
                    return;
                }

                dialog.setResult(new TicketFormData(
                        passenger,
                        flight,
                        seatNumber,
                        seatClass,
                        price,
                        purchaseDate,
                        status
                ));
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class BoardingPassView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final ComboBox<BoardingPassStatus> statusFilter = new ComboBox<>();
        private final TableView<BoardingPass> table = new TableView<>();
        private final FilteredList<BoardingPass> filteredPasses = new FilteredList<>(mockService.getBoardingPasses(), pass -> true);

        BoardingPassView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Boarding Pass");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search boarding pass, ticket, passenger, flight");
            searchField.setPrefWidth(320);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            statusFilter.getItems().add(null);
            statusFilter.getItems().addAll(BoardingPassStatus.values());
            statusFilter.setValue(null);
            statusFilter.setPrefWidth(160);
            statusFilter.setPromptText("All Status");
            statusFilter.setConverter(enumConverter(BoardingPassStatus::getDisplayName, "All Status"));
            statusFilter.valueProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField, statusFilter);

            configureTable();
            SortedList<BoardingPass> sortedPasses = new SortedList<>(filteredPasses);
            sortedPasses.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedPasses);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No boarding passes"));
            table.getColumns().addAll(
                    stringColumn("Boarding Pass ID", BoardingPass::getBoardingPassId, 130),
                    stringColumn("Ticket ID", pass -> pass.getTicket().getTicketId(), 120),
                    stringColumn("Passenger", pass -> pass.getTicket().getPassenger().getFullName(), 170),
                    stringColumn("Flight Number", pass -> pass.getTicket().getFlight().getFlightNumber(), 120),
                    stringColumn("Gate", BoardingPass::getGate, 90),
                    stringColumn("Boarding Time", pass -> formatDateTime(pass.getBoardingTime()), 160),
                    stringColumn("Status", pass -> pass.getStatus().getDisplayName(), 110)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            BoardingPassStatus selectedStatus = statusFilter.getValue();

            filteredPasses.setPredicate(pass -> {
                boolean matchesKeyword = keyword.isEmpty()
                        || pass.getBoardingPassId().toLowerCase().contains(keyword)
                        || pass.getTicket().getTicketId().toLowerCase().contains(keyword)
                        || pass.getTicket().getPassenger().getFullName().toLowerCase().contains(keyword)
                        || pass.getTicket().getFlight().getFlightNumber().toLowerCase().contains(keyword)
                        || pass.getGate().toLowerCase().contains(keyword);
                boolean matchesStatus = selectedStatus == null || pass.getStatus() == selectedStatus;
                return matchesKeyword && matchesStatus;
            });
        }

        private void handleAdd() {
            if (mockService.getEligibleTicketsForBoardingPass(null).isEmpty()) {
                showError("Add Boarding Pass", "No eligible ticket is available for a boarding pass.");
                return;
            }

            Optional<BoardingPassFormData> result = showBoardingPassDialog(null);
            result.ifPresent(formData -> {
                BoardingPass boardingPass = new BoardingPass(
                        mockService.nextBoardingId(),
                        formData.ticket(),
                        formData.gate(),
                        formData.boardingTime(),
                        formData.status()
                );
                try {
                    mockService.addBoardingPass(boardingPass);
                } catch (RuntimeException exception) {
                    showError("Add Boarding Pass", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            BoardingPass selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Boarding Pass", "Please select a boarding pass to edit.");
                return;
            }

            Optional<BoardingPassFormData> result = showBoardingPassDialog(selected);
            result.ifPresent(formData -> {
                selected.setTicket(formData.ticket());
                selected.setGate(formData.gate());
                selected.setBoardingTime(formData.boardingTime());
                selected.setStatus(formData.status());
                try {
                    mockService.updateBoardingPass(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Boarding Pass", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            BoardingPass selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Boarding Pass", "Please select a boarding pass to delete.");
                return;
            }
            if (confirm("Delete Boarding Pass", "Delete selected boarding pass " + selected.getBoardingPassId() + "?")) {
                try {
                    mockService.removeBoardingPass(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Boarding Pass", exception.getMessage());
                }
            }
        }

        private Optional<BoardingPassFormData> showBoardingPassDialog(BoardingPass existing) {
            boolean editMode = existing != null;
            Dialog<BoardingPassFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Boarding Pass" : "Add Boarding Pass");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(500);

            LocalDateTime defaultBoardingTime = editMode ? existing.getBoardingTime() : currentTimeRounded().plusMinutes(30);

            TextField idField = createReadOnlyField(editMode ? existing.getBoardingPassId() : "Auto-generated on save");
            ComboBox<Ticket> ticketBox = new ComboBox<>(FXCollections.observableArrayList(mockService.getEligibleTicketsForBoardingPass(existing)));
            ticketBox.setConverter(enumConverter(AirportManagementApp.this::ticketDisplay, ""));
            ticketBox.setValue(editMode ? existing.getTicket() : null);

            TextField gateField = new TextField(editMode ? existing.getGate() : "TBD");
            DatePicker boardingDatePicker = new DatePicker(defaultBoardingTime.toLocalDate());
            TextField boardingTimeField = new TextField(defaultBoardingTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            ComboBox<BoardingPassStatus> statusBox = new ComboBox<>(FXCollections.observableArrayList(BoardingPassStatus.values()));
            statusBox.setConverter(enumConverter(BoardingPassStatus::getDisplayName, ""));
            statusBox.setValue(editMode ? existing.getStatus() : BoardingPassStatus.ISSUED);

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Boarding Pass ID"), idField);
            grid.addRow(1, new Label("Ticket"), ticketBox);
            grid.addRow(2, new Label("Gate"), gateField);
            grid.addRow(3, new Label("Boarding Date"), boardingDatePicker);
            grid.addRow(4, new Label("Boarding Time"), boardingTimeField);
            grid.addRow(5, new Label("Status"), statusBox);
            grid.add(errorLabel, 0, 6, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                try {
                    Ticket ticket = ticketBox.getValue();
                    String gate = trim(gateField.getText());
                    BoardingPassStatus status = statusBox.getValue();

                    if (ticket == null || isBlank(gate) || status == null) {
                        errorLabel.setText("Ticket, gate, boarding time, and status are required.");
                        event.consume();
                        return;
                    }
                    if (!mockService.isBoardingPassTicketAvailable(ticket, existing)) {
                        errorLabel.setText("A boarding pass already exists for the selected ticket.");
                        event.consume();
                        return;
                    }

                    LocalDateTime boardingTime = parseRequiredDateTime(boardingDatePicker.getValue(), boardingTimeField.getText(), "Boarding Time");
                    dialog.setResult(new BoardingPassFormData(ticket, gate, boardingTime, status));
                } catch (IllegalArgumentException exception) {
                    errorLabel.setText(exception.getMessage());
                    event.consume();
                }
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class LuggageView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final ComboBox<LuggageStatus> statusFilter = new ComboBox<>();
        private final TableView<Luggage> table = new TableView<>();
        private final FilteredList<Luggage> filteredLuggage = new FilteredList<>(mockService.getLuggageItems(), luggage -> true);

        LuggageView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Luggage");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search luggage ID, ticket, passenger");
            searchField.setPrefWidth(300);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            statusFilter.getItems().add(null);
            statusFilter.getItems().addAll(LuggageStatus.values());
            statusFilter.setValue(null);
            statusFilter.setPrefWidth(160);
            statusFilter.setPromptText("All Status");
            statusFilter.setConverter(enumConverter(LuggageStatus::getDisplayName, "All Status"));
            statusFilter.valueProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField, statusFilter);

            configureTable();
            SortedList<Luggage> sortedLuggage = new SortedList<>(filteredLuggage);
            sortedLuggage.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedLuggage);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No luggage"));
            table.getColumns().addAll(
                    stringColumn("Luggage ID", Luggage::getLuggageId, 120),
                    stringColumn("Ticket ID", luggage -> luggage.getTicket().getTicketId(), 110),
                    stringColumn("Passenger", luggage -> luggage.getTicket().getPassenger().getFullName(), 170),
                    stringColumn("Weight", luggage -> String.format("%.2f kg", luggage.getWeight()), 110),
                    stringColumn("Status", luggage -> luggage.getStatus().getDisplayName(), 110),
                    stringColumn("Checked-in Time", luggage -> formatDateTime(luggage.getCheckedInAt()), 160)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            LuggageStatus selectedStatus = statusFilter.getValue();

            filteredLuggage.setPredicate(luggage -> {
                boolean matchesKeyword = keyword.isEmpty()
                        || luggage.getLuggageId().toLowerCase().contains(keyword)
                        || luggage.getTicket().getTicketId().toLowerCase().contains(keyword)
                        || luggage.getTicket().getPassenger().getFullName().toLowerCase().contains(keyword);
                boolean matchesStatus = selectedStatus == null || luggage.getStatus() == selectedStatus;
                return matchesKeyword && matchesStatus;
            });
        }

        private void handleAdd() {
            if (mockService.getSelectableTickets(null).isEmpty()) {
                showError("Add Luggage", "No eligible ticket is available for luggage.");
                return;
            }

            Optional<LuggageFormData> result = showLuggageDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addLuggage(new Luggage(
                            mockService.nextLuggageId(),
                            formData.ticket(),
                            formData.weight(),
                            formData.status(),
                            formData.checkedInAt()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Luggage", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            Luggage selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Luggage", "Please select a luggage record to edit.");
                return;
            }

            Optional<LuggageFormData> result = showLuggageDialog(selected);
            result.ifPresent(formData -> {
                selected.setTicket(formData.ticket());
                selected.setWeight(formData.weight());
                selected.setStatus(formData.status());
                selected.setCheckedInAt(formData.checkedInAt());
                try {
                    mockService.updateLuggage(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Luggage", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            Luggage selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Luggage", "Please select a luggage record to delete.");
                return;
            }
            if (confirm("Delete Luggage", "Delete selected luggage " + selected.getLuggageId() + "?")) {
                try {
                    mockService.removeLuggage(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Luggage", exception.getMessage());
                }
            }
        }

        private Optional<LuggageFormData> showLuggageDialog(Luggage existing) {
            boolean editMode = existing != null;
            Dialog<LuggageFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Luggage" : "Add Luggage");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(500);

            LocalDateTime defaultCheckedInAt = editMode ? existing.getCheckedInAt() : currentTimeRounded();

            TextField idField = createReadOnlyField(editMode ? existing.getLuggageId() : "Auto-generated on save");
            ComboBox<Ticket> ticketBox = new ComboBox<>(FXCollections.observableArrayList(mockService.getSelectableTickets(editMode ? existing.getTicket() : null)));
            ticketBox.setConverter(enumConverter(AirportManagementApp.this::ticketDisplay, ""));
            ticketBox.setValue(editMode ? existing.getTicket() : null);

            TextField weightField = new TextField(editMode ? String.valueOf(existing.getWeight()) : "20");
            ComboBox<LuggageStatus> statusBox = new ComboBox<>(FXCollections.observableArrayList(LuggageStatus.values()));
            statusBox.setConverter(enumConverter(LuggageStatus::getDisplayName, ""));
            statusBox.setValue(editMode ? existing.getStatus() : LuggageStatus.CHECKED_IN);

            DatePicker checkedInDatePicker = new DatePicker(defaultCheckedInAt.toLocalDate());
            TextField checkedInTimeField = new TextField(defaultCheckedInAt.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Luggage ID"), idField);
            grid.addRow(1, new Label("Ticket"), ticketBox);
            grid.addRow(2, new Label("Weight"), weightField);
            grid.addRow(3, new Label("Status"), statusBox);
            grid.addRow(4, new Label("Checked-in Date"), checkedInDatePicker);
            grid.addRow(5, new Label("Checked-in Time"), checkedInTimeField);
            grid.add(errorLabel, 0, 6, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                try {
                    Ticket ticket = ticketBox.getValue();
                    LuggageStatus status = statusBox.getValue();
                    String weightRaw = trim(weightField.getText());

                    if (ticket == null || status == null || isBlank(weightRaw)) {
                        errorLabel.setText("Ticket, weight, checked-in time, and status are required.");
                        event.consume();
                        return;
                    }

                    double weight;
                    try {
                        weight = Double.parseDouble(weightRaw);
                    } catch (NumberFormatException exception) {
                        errorLabel.setText("Weight must be a valid number.");
                        event.consume();
                        return;
                    }
                    if (weight <= 0) {
                        errorLabel.setText("Weight must be greater than 0.");
                        event.consume();
                        return;
                    }

                    LocalDateTime checkedInAt = parseRequiredDateTime(checkedInDatePicker.getValue(), checkedInTimeField.getText(), "Checked-in Time");
                    dialog.setResult(new LuggageFormData(ticket, weight, status, checkedInAt));
                } catch (IllegalArgumentException exception) {
                    errorLabel.setText(exception.getMessage());
                    event.consume();
                }
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class SecurityLogView extends VBox implements Refreshable {
        private final UserAccount currentUser;
        private final TextField searchField = new TextField();
        private final ComboBox<SecurityResult> resultFilter = new ComboBox<>();
        private final TableView<SecurityLog> table = new TableView<>();
        private final FilteredList<SecurityLog> filteredLogs = new FilteredList<>(mockService.getSecurityLogs(), log -> true);

        SecurityLogView(UserAccount currentUser) {
            this.currentUser = currentUser;
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Security Log");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search passenger, result, notes");
            searchField.setPrefWidth(320);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            resultFilter.getItems().add(null);
            resultFilter.getItems().addAll(SecurityResult.values());
            resultFilter.setValue(null);
            resultFilter.setPrefWidth(160);
            resultFilter.setPromptText("All Status");
            resultFilter.setConverter(enumConverter(SecurityResult::getDisplayName, "All Status"));
            resultFilter.valueProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField, resultFilter);

            configureTable();
            SortedList<SecurityLog> sortedLogs = new SortedList<>(filteredLogs);
            sortedLogs.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedLogs);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No security logs"));
            table.getColumns().addAll(
                    stringColumn("Log ID", SecurityLog::getLogId, 110),
                    stringColumn("Passenger", log -> log.getPassenger().getFullName(), 170),
                    stringColumn("Screening Date", log -> formatDate(log.getScreeningTime().toLocalDate()), 120),
                    stringColumn("Screening Time", log -> log.getScreeningTime().toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")), 120),
                    stringColumn("Result", log -> log.getResult().getDisplayName(), 110),
                    stringColumn("Notes", SecurityLog::getNotes, 220)
            );

            table.setRowFactory(tv -> new TableRow<>() {
                @Override
                protected void updateItem(SecurityLog item, boolean empty) {
                    super.updateItem(item, empty);
                    if (empty || item == null) {
                        setStyle("");
                        return;
                    }
                    if (item.getResult() == SecurityResult.FLAGGED) {
                        setStyle("-fx-background-color: rgba(244, 163, 0, 0.22);");
                    } else if (item.getResult() == SecurityResult.REJECTED) {
                        setStyle("-fx-background-color: rgba(204, 64, 86, 0.26);");
                    } else {
                        setStyle("");
                    }
                }
            });
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            SecurityResult selectedResult = resultFilter.getValue();

            filteredLogs.setPredicate(log -> {
                boolean matchesKeyword = keyword.isEmpty()
                        || log.getLogId().toLowerCase().contains(keyword)
                        || log.getPassenger().getFullName().toLowerCase().contains(keyword)
                        || log.getResult().getDisplayName().toLowerCase().contains(keyword)
                        || log.getNotes().toLowerCase().contains(keyword);
                boolean matchesResult = selectedResult == null || log.getResult() == selectedResult;
                return matchesKeyword && matchesResult;
            });
        }

        private void handleAdd() {
            if (mockService.getPassengers().isEmpty()) {
                showError("Add Security Log", "Passengers are required before creating a security log.");
                return;
            }

            Optional<SecurityLogFormData> result = showSecurityLogDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addSecurityLog(new SecurityLog(
                            mockService.nextSecurityLogId(),
                            formData.passenger(),
                            resolveCurrentEmployee(),
                            formData.screeningTime(),
                            formData.result(),
                            formData.notes()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Security Log", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            SecurityLog selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Security Log", "Please select a security log to edit.");
                return;
            }

            Optional<SecurityLogFormData> result = showSecurityLogDialog(selected);
            result.ifPresent(formData -> {
                selected.setPassenger(formData.passenger());
                selected.setScreeningTime(formData.screeningTime());
                selected.setResult(formData.result());
                selected.setNotes(formData.notes());
                try {
                    mockService.updateSecurityLog(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Security Log", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            SecurityLog selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Security Log", "Please select a security log to delete.");
                return;
            }
            if (confirm("Delete Security Log", "Delete selected security log " + selected.getLogId() + "?")) {
                try {
                    mockService.removeSecurityLog(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Security Log", exception.getMessage());
                }
            }
        }

        private Optional<SecurityLogFormData> showSecurityLogDialog(SecurityLog existing) {
            boolean editMode = existing != null;
            Dialog<SecurityLogFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Security Log" : "Add Security Log");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(540);

            LocalDateTime defaultScreeningTime = editMode ? existing.getScreeningTime() : currentTimeRounded();

            TextField idField = createReadOnlyField(editMode ? existing.getLogId() : "Auto-generated on save");
            ComboBox<Passenger> passengerBox = new ComboBox<>(mockService.getPassengers());
            passengerBox.setConverter(enumConverter(AirportManagementApp.this::passengerDisplay, ""));
            passengerBox.setValue(editMode ? existing.getPassenger() : null);

            DatePicker screeningDatePicker = new DatePicker(defaultScreeningTime.toLocalDate());
            TextField screeningTimeField = new TextField(defaultScreeningTime.toLocalTime().format(DateTimeFormatter.ofPattern("HH:mm")));

            ComboBox<SecurityResult> resultBox = new ComboBox<>(FXCollections.observableArrayList(SecurityResult.values()));
            resultBox.setConverter(enumConverter(SecurityResult::getDisplayName, ""));
            resultBox.setValue(editMode ? existing.getResult() : SecurityResult.CLEARED);

            TextArea notesArea = new TextArea(editMode ? existing.getNotes() : "");
            notesArea.setPrefRowCount(3);
            notesArea.setWrapText(true);

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Log ID"), idField);
            grid.addRow(1, new Label("Passenger"), passengerBox);
            grid.addRow(2, new Label("Screening Date"), screeningDatePicker);
            grid.addRow(3, new Label("Screening Time"), screeningTimeField);
            grid.addRow(4, new Label("Result"), resultBox);
            grid.addRow(5, new Label("Notes"), notesArea);
            grid.add(errorLabel, 0, 6, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                try {
                    Passenger passenger = passengerBox.getValue();
                    SecurityResult result = resultBox.getValue();

                    if (passenger == null || result == null) {
                        errorLabel.setText("Passenger, screening time, and result are required.");
                        event.consume();
                        return;
                    }

                    LocalDateTime screeningTime = parseRequiredDateTime(screeningDatePicker.getValue(), screeningTimeField.getText(), "Screening Time");
                    dialog.setResult(new SecurityLogFormData(
                            passenger,
                            screeningTime,
                            result,
                            trim(notesArea.getText())
                    ));
                } catch (IllegalArgumentException exception) {
                    errorLabel.setText(exception.getMessage());
                    event.consume();
                }
            });

            return dialog.showAndWait();
        }

        private Employee resolveCurrentEmployee() {
            String currentEmail = trim(currentUser.getEmail());
            if (isBlank(currentEmail)) {
                return null;
            }

            return mockService.getEmployees().stream()
                    .filter(employee -> employee.getEmail().equalsIgnoreCase(currentEmail))
                    .findFirst()
                    .orElse(null);
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class EmployeesView extends VBox implements Refreshable {
        private final TextField searchField = new TextField();
        private final TableView<Employee> table = new TableView<>();
        private final FilteredList<Employee> filteredEmployees = new FilteredList<>(mockService.getEmployees(), employee -> true);

        EmployeesView() {
            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Employee");
            title.getStyleClass().add("section-title");

            searchField.setPromptText("Search employee ID, name, email, department");
            searchField.setPrefWidth(320);
            searchField.textProperty().addListener((obs, oldVal, newVal) -> applyFilter());

            Button addButton = createActionButton("Add", "primary-button", this::handleAdd);
            Button editButton = createActionButton("Edit", "secondary-button", this::handleEdit);
            Button deleteButton = createActionButton("Delete", "danger-button", this::handleDelete);

            HBox controls = buildCrudToolbar(addButton, editButton, deleteButton, searchField);

            configureTable();
            SortedList<Employee> sortedEmployees = new SortedList<>(filteredEmployees);
            sortedEmployees.comparatorProperty().bind(table.comparatorProperty());
            table.setItems(sortedEmployees);

            VBox.setVgrow(table, Priority.ALWAYS);
            getChildren().addAll(title, controls, table);
        }

        private void configureTable() {
            table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
            table.setPlaceholder(new Label("No employees"));
            table.getColumns().addAll(
                    stringColumn("Employee ID", Employee::getEmployeeId, 120),
                    stringColumn("Full Name", Employee::getFullName, 180),
                    stringColumn("Email", Employee::getEmail, 220),
                    stringColumn("Phone", Employee::getPhone, 140),
                    stringColumn("Department", Employee::getDepartment, 140),
                    stringColumn("Job Title", Employee::getJobTitle, 160)
            );
        }

        private void applyFilter() {
            String keyword = trim(searchField.getText()).toLowerCase();
            filteredEmployees.setPredicate(employee -> keyword.isEmpty()
                    || employee.getEmployeeId().toLowerCase().contains(keyword)
                    || employee.getFullName().toLowerCase().contains(keyword)
                    || employee.getEmail().toLowerCase().contains(keyword)
                    || employee.getDepartment().toLowerCase().contains(keyword)
                    || employee.getJobTitle().toLowerCase().contains(keyword));
        }

        private void handleAdd() {
            Optional<EmployeeFormData> result = showEmployeeDialog(null);
            result.ifPresent(formData -> {
                try {
                    mockService.addEmployee(new Employee(
                            mockService.nextEmployeeId(),
                            formData.fullName(),
                            formData.email(),
                            formData.phone(),
                            formData.department(),
                            formData.jobTitle()
                    ));
                } catch (RuntimeException exception) {
                    showError("Add Employee", exception.getMessage());
                }
            });
        }

        private void handleEdit() {
            Employee selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Edit Employee", "Please select an employee to edit.");
                return;
            }

            Optional<EmployeeFormData> result = showEmployeeDialog(selected);
            result.ifPresent(formData -> {
                selected.setFullName(formData.fullName());
                selected.setEmail(formData.email());
                selected.setPhone(formData.phone());
                selected.setDepartment(formData.department());
                selected.setJobTitle(formData.jobTitle());
                try {
                    mockService.updateEmployee(selected);
                    table.refresh();
                } catch (RuntimeException exception) {
                    showError("Edit Employee", exception.getMessage());
                }
            });
        }

        private void handleDelete() {
            Employee selected = table.getSelectionModel().getSelectedItem();
            if (selected == null) {
                showError("Delete Employee", "Please select an employee to delete.");
                return;
            }
            if (confirm("Delete Employee", "Delete selected employee " + selected.getFullName() + "?")) {
                try {
                    mockService.removeEmployee(selected);
                } catch (RuntimeException exception) {
                    showError("Delete Employee", exception.getMessage());
                }
            }
        }

        private Optional<EmployeeFormData> showEmployeeDialog(Employee existing) {
            boolean editMode = existing != null;
            Dialog<EmployeeFormData> dialog = new Dialog<>();
            dialog.setTitle(editMode ? "Edit Employee" : "Add Employee");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType(editMode ? "Save" : "Add", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);
            dialog.getDialogPane().setPrefWidth(500);

            TextField idField = createReadOnlyField(editMode ? existing.getEmployeeId() : "Auto-generated on save");
            TextField fullNameField = new TextField(editMode ? existing.getFullName() : "");
            TextField emailField = new TextField(editMode ? existing.getEmail() : "");
            TextField phoneField = new TextField(editMode ? existing.getPhone() : "");
            TextField departmentField = new TextField(editMode ? existing.getDepartment() : "");
            TextField jobTitleField = new TextField(editMode ? existing.getJobTitle() : "");

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Employee ID"), idField);
            grid.addRow(1, new Label("Full Name"), fullNameField);
            grid.addRow(2, new Label("Email"), emailField);
            grid.addRow(3, new Label("Phone"), phoneField);
            grid.addRow(4, new Label("Department"), departmentField);
            grid.addRow(5, new Label("Job Title"), jobTitleField);
            grid.add(errorLabel, 0, 6, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                String fullName = trim(fullNameField.getText());
                String email = trim(emailField.getText());
                String phone = trim(phoneField.getText());
                String department = trim(departmentField.getText());
                String jobTitle = trim(jobTitleField.getText());

                if (isBlank(fullName) || isBlank(phone) || isBlank(department) || isBlank(jobTitle)) {
                    errorLabel.setText("Full Name, phone, department, and job title are required.");
                    event.consume();
                    return;
                }
                if (!isValidEmail(email)) {
                    errorLabel.setText("Email format is invalid.");
                    event.consume();
                    return;
                }

                dialog.setResult(new EmployeeFormData(fullName, email, phone, department, jobTitle));
            });

            return dialog.showAndWait();
        }

        @Override
        public void refresh() {
            applyFilter();
            table.refresh();
        }
    }

    private final class ProfileView extends VBox implements Refreshable {
        private final UserAccount user;
        private final Runnable onProfileUpdated;
        private final TextField fullNameField = new TextField();
        private final TextField roleField = new TextField();
        private final TextField departmentField = new TextField();
        private final TextField emailField = new TextField();
        private final TextField phoneField = new TextField();

        ProfileView(UserAccount user, Runnable onProfileUpdated) {
            this.user = user;
            this.onProfileUpdated = onProfileUpdated;

            getStyleClass().add("content-root");
            setSpacing(14);

            Label title = new Label("Profile");
            title.getStyleClass().add("section-title");

            fullNameField.setEditable(false);
            roleField.setEditable(false);
            departmentField.setEditable(false);
            emailField.setEditable(false);
            phoneField.setEditable(false);

            roleField.getStyleClass().add("readonly-field");
            departmentField.getStyleClass().add("readonly-field");

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Full Name"), fullNameField);
            grid.addRow(1, new Label("Role"), roleField);
            grid.addRow(2, new Label("Department"), departmentField);
            grid.addRow(3, new Label("Email"), emailField);
            grid.addRow(4, new Label("Phone"), phoneField);

            Button editButton = new Button("Edit Information");
            editButton.getStyleClass().add("primary-button");
            Button changePasswordButton = new Button("Change Password (Mock)");
            changePasswordButton.getStyleClass().add("secondary-button");

            editButton.setOnAction(event -> openEditProfileDialog());
            changePasswordButton.setOnAction(event -> openChangePasswordDialog());

            VBox card = new VBox(12, grid, new HBox(10, editButton, changePasswordButton));
            card.getStyleClass().add("table-card");
            card.setPadding(new Insets(16));

            getChildren().addAll(title, card);
            refresh();
        }

        private void openEditProfileDialog() {
            Dialog<UserProfileFormData> dialog = new Dialog<>();
            dialog.setTitle("Edit Profile");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType("Save", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);

            TextField fullNameInput = new TextField(user.getFullName());
            TextField emailInput = new TextField(user.getEmail());
            TextField phoneInput = new TextField(user.getPhone());
            TextField roleInput = createReadOnlyField(user.getRole().getDisplayName());
            TextField departmentInput = createReadOnlyField(user.getDepartment());

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Full Name"), fullNameInput);
            grid.addRow(1, new Label("Role"), roleInput);
            grid.addRow(2, new Label("Department"), departmentInput);
            grid.addRow(3, new Label("Email"), emailInput);
            grid.addRow(4, new Label("Phone"), phoneInput);
            grid.add(errorLabel, 0, 5, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                String fullName = trim(fullNameInput.getText());
                String email = trim(emailInput.getText());
                String phone = trim(phoneInput.getText());

                if (isBlank(fullName) || isBlank(phone)) {
                    errorLabel.setText("Full name and phone are required.");
                    event.consume();
                    return;
                }
                if (!isValidEmail(email)) {
                    errorLabel.setText("Email format is invalid.");
                    event.consume();
                    return;
                }

                dialog.setResult(new UserProfileFormData(fullName, email, phone));
            });

            Optional<UserProfileFormData> result = dialog.showAndWait();
            result.ifPresent(formData -> {
                mockService.updateAccountDetails(user, formData.fullName(), formData.email(), formData.phone());
                refresh();
                onProfileUpdated.run();
                showInfo("Profile", "Profile updated successfully.");
            });
        }

        private void openChangePasswordDialog() {
            Dialog<PasswordFormData> dialog = new Dialog<>();
            dialog.setTitle("Change Password");
            styleDialog(dialog);

            ButtonType saveType = new ButtonType("Change", ButtonBar.ButtonData.OK_DONE);
            dialog.getDialogPane().getButtonTypes().addAll(saveType, ButtonType.CANCEL);
            preserveTypedDialogResult(dialog, saveType);

            PasswordField currentPasswordField = new PasswordField();
            PasswordField newPasswordField = new PasswordField();
            PasswordField confirmPasswordField = new PasswordField();

            Label errorLabel = new Label();
            errorLabel.getStyleClass().add("form-error");
            errorLabel.setWrapText(true);

            GridPane grid = createFormGrid();
            grid.addRow(0, new Label("Current Password"), currentPasswordField);
            grid.addRow(1, new Label("New Password"), newPasswordField);
            grid.addRow(2, new Label("Confirm Password"), confirmPasswordField);
            grid.add(errorLabel, 0, 3, 2, 1);
            dialog.getDialogPane().setContent(grid);

            Node saveButton = dialog.getDialogPane().lookupButton(saveType);
            saveButton.addEventFilter(javafx.event.ActionEvent.ACTION, event -> {
                String currentPassword = trim(currentPasswordField.getText());
                String newPassword = trim(newPasswordField.getText());
                String confirmPassword = trim(confirmPasswordField.getText());

                if (isBlank(currentPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
                    errorLabel.setText("Please fill all password fields.");
                    event.consume();
                    return;
                }
                if (!user.getPassword().equals(currentPassword)) {
                    errorLabel.setText("Current password is incorrect.");
                    event.consume();
                    return;
                }
                if (!newPassword.equals(confirmPassword)) {
                    errorLabel.setText("New password confirmation does not match.");
                    event.consume();
                    return;
                }

                dialog.setResult(new PasswordFormData(currentPassword, newPassword));
            });

            Optional<PasswordFormData> result = dialog.showAndWait();
            result.ifPresent(formData -> {
                user.setPassword(formData.newPassword());
                showInfo("Change Password", "Password changed successfully (mock).");
            });
        }

        @Override
        public void refresh() {
            fullNameField.setText(user.getFullName());
            roleField.setText(user.getRole().getDisplayName());
            departmentField.setText(user.getDepartment());
            emailField.setText(user.getEmail());
            phoneField.setText(user.getPhone());
        }
    }

    private record FlightFormData(
            String flightNumber,
            String aircraft,
            String origin,
            String destination,
            LocalDateTime departureTime,
            LocalDateTime arrivalTime,
            LocalDateTime actualDeparture,
            LocalDateTime actualArrival,
            FlightStatus status
    ) {
    }

    private record PassengerFormData(
            String passportId,
            String fullName,
            LocalDate dateOfBirth,
            String nationality,
            String email,
            String phone
    ) {
    }

    private record TicketFormData(
            Passenger passenger,
            Flight flight,
            String seatNumber,
            SeatClass seatClass,
            double price,
            LocalDate purchaseDate,
            TicketStatus status
    ) {
    }

    private record BoardingPassFormData(
            Ticket ticket,
            String gate,
            LocalDateTime boardingTime,
            BoardingPassStatus status
    ) {
    }

    private record LuggageFormData(
            Ticket ticket,
            double weight,
            LuggageStatus status,
            LocalDateTime checkedInAt
    ) {
    }

    private record SecurityLogFormData(
            Passenger passenger,
            LocalDateTime screeningTime,
            SecurityResult result,
            String notes
    ) {
    }

    private record EmployeeFormData(
            String fullName,
            String email,
            String phone,
            String department,
            String jobTitle
    ) {
    }

    private record UserProfileFormData(
            String fullName,
            String email,
            String phone
    ) {
    }

    private record PasswordFormData(
            String currentPassword,
            String newPassword
    ) {
    }

    private static final class MockAirportService {
        private final ObservableList<Flight> flights = FXCollections.observableArrayList();
        private final ObservableList<Passenger> passengers = FXCollections.observableArrayList();
        private final ObservableList<Ticket> tickets = FXCollections.observableArrayList();
        private final ObservableList<BoardingPass> boardingPasses = FXCollections.observableArrayList();
        private final ObservableList<Luggage> luggageItems = FXCollections.observableArrayList();
        private final ObservableList<SecurityLog> securityLogs = FXCollections.observableArrayList();
        private final ObservableList<Employee> employees = FXCollections.observableArrayList();

        private final ApiClient apiClient = new ApiClient(System.getProperty("airport.api.baseUrl", "http://localhost:8080/api"));
        private final Map<String, Long> flightRemoteIds = new HashMap<>();
        private final Map<String, Long> passengerRemoteIds = new HashMap<>();
        private final Map<String, Long> ticketRemoteIds = new HashMap<>();
        private final Map<String, Long> boardingPassRemoteIds = new HashMap<>();
        private final Map<String, Long> luggageRemoteIds = new HashMap<>();
        private final Map<String, Long> securityLogRemoteIds = new HashMap<>();
        private final Map<String, Long> employeeRemoteIds = new HashMap<>();

        private int flightCounter = 1;
        private int passengerCounter = 1;
        private int ticketCounter = 1;
        private int boardingCounter = 1;
        private int luggageCounter = 1;
        private int securityCounter = 1;
        private int employeeCounter = 1;
        private String lastError = "";

        String getLastError() {
            return lastError;
        }

        UserAccount authenticate(String email, String password, Role role) {
            lastError = "";
            try {
                AuthResponse response = apiClient.login(email, password);
                Role backendRole = parseRole(response.role);
                if (backendRole != role) {
                    lastError = "Selected role does not match this account.";
                    return null;
                }
                apiClient.setToken(response.token);
                loadRemoteData();

                Employee matchedEmployee = employees.stream()
                        .filter(employee -> employee.getEmail().equalsIgnoreCase(email))
                        .findFirst()
                        .orElse(null);
                String fullName = isBlank(response.fullName) ? email : response.fullName;
                String department = matchedEmployee == null ? role.getDisplayName() : matchedEmployee.getDepartment();
                String phone = matchedEmployee == null ? "" : matchedEmployee.getPhone();
                return new UserAccount(email, password, role, fullName, department, phone);
            } catch (ApiException exception) {
                lastError = exception.getMessage();
                return null;
            }
        }

        void updateAccountDetails(UserAccount user, String fullName, String email, String phone) {
            user.setFullName(fullName);
            user.setEmail(email);
            user.setPhone(phone);
        }

        ObservableList<Flight> getFlights() {
            return flights;
        }

        ObservableList<Passenger> getPassengers() {
            return passengers;
        }

        ObservableList<Ticket> getTickets() {
            return tickets;
        }

        ObservableList<BoardingPass> getBoardingPasses() {
            return boardingPasses;
        }

        ObservableList<Luggage> getLuggageItems() {
            return luggageItems;
        }

        ObservableList<SecurityLog> getSecurityLogs() {
            return securityLogs;
        }

        ObservableList<Employee> getEmployees() {
            return employees;
        }

        String nextFlightId() {
            return nextId("FLT", flightCounter++);
        }

        String nextPassengerId() {
            return nextId("PAS", passengerCounter++);
        }

        String nextTicketId() {
            return nextId("TCK", ticketCounter++);
        }

        String nextBoardingId() {
            return nextId("BDP", boardingCounter++);
        }

        String nextLuggageId() {
            return nextId("LUG", luggageCounter++);
        }

        String nextSecurityLogId() {
            return nextId("SEC", securityCounter++);
        }

        String nextEmployeeId() {
            return nextId("EMP", employeeCounter++);
        }

        void addFlight(Flight flight) {
            apiClient.post("/flights", toRemoteFlight(flight), RemoteFlight.class);
            loadRemoteData();
        }

        void updateFlight(Flight flight) {
            apiClient.put("/flights/" + requireRemoteId(flightRemoteIds, flight.getFlightId(), "flight"), toRemoteFlight(flight), RemoteFlight.class);
            loadRemoteData();
        }

        void addPassenger(Passenger passenger) {
            apiClient.post("/passengers", toRemotePassenger(passenger), RemotePassenger.class);
            loadRemoteData();
        }

        void updatePassenger(Passenger passenger) {
            apiClient.put("/passengers/" + requireRemoteId(passengerRemoteIds, passenger.getPassengerId(), "passenger"), toRemotePassenger(passenger), RemotePassenger.class);
            loadRemoteData();
        }

        void addTicket(Ticket ticket) {
            apiClient.post("/tickets", toRemoteTicket(ticket), RemoteTicket.class);
            loadRemoteData();
        }

        void updateTicket(Ticket ticket) {
            if (ticket.getStatus() == TicketStatus.CANCELLED) {
                deleteBoardingPassesForTicketRemote(ticket);
            }
            apiClient.put("/tickets/" + requireRemoteId(ticketRemoteIds, ticket.getTicketId(), "ticket"), toRemoteTicket(ticket), RemoteTicket.class);
            loadRemoteData();
        }

        void addBoardingPass(BoardingPass boardingPass) {
            apiClient.post("/boarding-passes", toRemoteBoardingPass(boardingPass), RemoteBoardingPass.class);
            syncTicketStatusLocal(boardingPass);
            updateTicketRemote(boardingPass.getTicket());
            loadRemoteData();
        }

        void updateBoardingPass(BoardingPass boardingPass) {
            apiClient.put("/boarding-passes/" + requireRemoteId(boardingPassRemoteIds, boardingPass.getBoardingPassId(), "boarding pass"),
                    toRemoteBoardingPass(boardingPass), RemoteBoardingPass.class);
            syncTicketStatusLocal(boardingPass);
            updateTicketRemote(boardingPass.getTicket());
            loadRemoteData();
        }

        void addLuggage(Luggage luggage) {
            apiClient.post("/luggages", toRemoteLuggage(luggage), RemoteLuggage.class);
            loadRemoteData();
        }

        void updateLuggage(Luggage luggage) {
            apiClient.put("/luggages/" + requireRemoteId(luggageRemoteIds, luggage.getLuggageId(), "luggage"), toRemoteLuggage(luggage), RemoteLuggage.class);
            loadRemoteData();
        }

        void addSecurityLog(SecurityLog securityLog) {
            apiClient.post("/security-logs", toRemoteSecurityLog(securityLog), RemoteSecurityLog.class);
            loadRemoteData();
        }

        void updateSecurityLog(SecurityLog securityLog) {
            apiClient.put("/security-logs/" + requireRemoteId(securityLogRemoteIds, securityLog.getLogId(), "security log"),
                    toRemoteSecurityLog(securityLog), RemoteSecurityLog.class);
            loadRemoteData();
        }

        void addEmployee(Employee employee) {
            apiClient.post("/employees", toRemoteEmployee(employee), RemoteEmployee.class);
            loadRemoteData();
        }

        void updateEmployee(Employee employee) {
            apiClient.put("/employees/" + requireRemoteId(employeeRemoteIds, employee.getEmployeeId(), "employee"), toRemoteEmployee(employee), RemoteEmployee.class);
            loadRemoteData();
        }

        List<Ticket> getSelectableTickets(Ticket currentTicket) {
            return tickets.stream()
                    .filter(ticket -> ticket == currentTicket || ticket.getStatus() != TicketStatus.CANCELLED)
                    .collect(Collectors.toList());
        }

        List<Ticket> getEligibleTicketsForBoardingPass(BoardingPass currentPass) {
            Ticket currentTicket = currentPass == null ? null : currentPass.getTicket();
            return getSelectableTickets(currentTicket).stream()
                    .filter(ticket -> isBoardingPassTicketAvailable(ticket, currentPass))
                    .collect(Collectors.toList());
        }

        boolean isBoardingPassTicketAvailable(Ticket ticket, BoardingPass currentPass) {
            return boardingPasses.stream().noneMatch(pass -> pass != currentPass && pass.getTicket() == ticket);
        }

        void syncTicketStatusFromBoardingPass(BoardingPass boardingPass) {
            syncTicketStatusLocal(boardingPass);
            updateTicketRemote(boardingPass.getTicket());
            loadRemoteData();
        }

        void removeBoardingPassesForTicket(Ticket ticket) {
            deleteBoardingPassesForTicketRemote(ticket);
            loadRemoteData();
        }

        void removeFlight(Flight flight) {
            tickets.stream()
                    .filter(ticket -> ticket.getFlight() == flight)
                    .collect(Collectors.toList())
                    .forEach(this::deleteTicketTreeRemote);
            deleteRemote("/flights", flightRemoteIds, flight.getFlightId());
            loadRemoteData();
        }

        void removePassenger(Passenger passenger) {
            tickets.stream()
                    .filter(ticket -> ticket.getPassenger() == passenger)
                    .collect(Collectors.toList())
                    .forEach(this::deleteTicketTreeRemote);
            securityLogs.stream()
                    .filter(log -> log.getPassenger() == passenger)
                    .collect(Collectors.toList())
                    .forEach(log -> deleteRemote("/security-logs", securityLogRemoteIds, log.getLogId()));
            deleteRemote("/passengers", passengerRemoteIds, passenger.getPassengerId());
            loadRemoteData();
        }

        void removeTicket(Ticket ticket) {
            deleteTicketTreeRemote(ticket);
            loadRemoteData();
        }

        void removeBoardingPass(BoardingPass boardingPass) {
            deleteRemote("/boarding-passes", boardingPassRemoteIds, boardingPass.getBoardingPassId());
            loadRemoteData();
        }

        void removeLuggage(Luggage luggage) {
            deleteRemote("/luggages", luggageRemoteIds, luggage.getLuggageId());
            loadRemoteData();
        }

        void removeSecurityLog(SecurityLog securityLog) {
            deleteRemote("/security-logs", securityLogRemoteIds, securityLog.getLogId());
            loadRemoteData();
        }

        void removeEmployee(Employee employee) {
            securityLogs.stream()
                    .filter(log -> log.getEmployee() == employee)
                    .collect(Collectors.toList())
                    .forEach(log -> deleteRemote("/security-logs", securityLogRemoteIds, log.getLogId()));
            deleteRemote("/employees", employeeRemoteIds, employee.getEmployeeId());
            loadRemoteData();
        }

        long countTotalFlights() {
            return flights.size();
        }

        long countTotalPassengers() {
            return passengers.size();
        }

        long countDelayedFlights() {
            return flights.stream().filter(flight -> flight.getStatus() == FlightStatus.DELAYED).count();
        }

        long countCheckedInLuggage() {
            return luggageItems.stream().filter(luggage -> luggage.getStatus() != LuggageStatus.LOST).count();
        }

        long countSecurityAlerts() {
            return securityLogs.stream()
                    .filter(log -> log.getResult() == SecurityResult.FLAGGED || log.getResult() == SecurityResult.REJECTED)
                    .count();
        }

        List<Flight> getRecentFlights(int maxRows) {
            return flights.stream()
                    .sorted(Comparator.comparing(Flight::getDepartureTime).reversed())
                    .limit(maxRows)
                    .collect(Collectors.toList());
        }

        List<SecurityLog> getRecentSecurityLogs(int maxRows) {
            return securityLogs.stream()
                    .sorted(Comparator.comparing(SecurityLog::getScreeningTime).reversed())
                    .limit(maxRows)
                    .collect(Collectors.toList());
        }

        Map<FlightStatus, Long> getFlightStatusCounts() {
            Map<FlightStatus, Long> counts = new EnumMap<>(FlightStatus.class);
            for (FlightStatus status : FlightStatus.values()) {
                counts.put(status, 0L);
            }
            for (Flight flight : flights) {
                counts.put(flight.getStatus(), counts.getOrDefault(flight.getStatus(), 0L) + 1);
            }
            return counts;
        }

        private void loadRemoteData() {
            List<RemoteEmployee> remoteEmployees = apiClient.getList("/employees", RemoteEmployee.class);
            List<RemotePassenger> remotePassengers = apiClient.getList("/passengers", RemotePassenger.class);
            List<RemoteFlight> remoteFlights = apiClient.getList("/flights", RemoteFlight.class);
            List<RemoteTicket> remoteTickets = apiClient.getList("/tickets", RemoteTicket.class);
            List<RemoteBoardingPass> remoteBoardingPasses = apiClient.getList("/boarding-passes", RemoteBoardingPass.class);
            List<RemoteLuggage> remoteLuggage = apiClient.getList("/luggages", RemoteLuggage.class);
            List<RemoteSecurityLog> remoteSecurityLogs = apiClient.getList("/security-logs", RemoteSecurityLog.class);

            Map<Long, Employee> employeesById = new HashMap<>();
            Map<Long, Passenger> passengersById = new HashMap<>();
            Map<Long, Flight> flightsById = new HashMap<>();
            Map<Long, Ticket> ticketsById = new HashMap<>();

            List<Employee> loadedEmployees = remoteEmployees.stream()
                    .map(this::toEmployee)
                    .collect(Collectors.toList());
            employeeRemoteIds.clear();
            for (int i = 0; i < loadedEmployees.size(); i++) {
                RemoteEmployee remote = remoteEmployees.get(i);
                Employee employee = loadedEmployees.get(i);
                putRemoteId(employeeRemoteIds, employee.getEmployeeId(), remote.id);
                if (remote.id != null) {
                    employeesById.put(remote.id, employee);
                }
            }

            List<Passenger> loadedPassengers = remotePassengers.stream()
                    .map(this::toPassenger)
                    .collect(Collectors.toList());
            passengerRemoteIds.clear();
            for (int i = 0; i < loadedPassengers.size(); i++) {
                RemotePassenger remote = remotePassengers.get(i);
                Passenger passenger = loadedPassengers.get(i);
                putRemoteId(passengerRemoteIds, passenger.getPassengerId(), remote.id);
                if (remote.id != null) {
                    passengersById.put(remote.id, passenger);
                }
            }

            List<Flight> loadedFlights = remoteFlights.stream()
                    .map(this::toFlight)
                    .collect(Collectors.toList());
            flightRemoteIds.clear();
            for (int i = 0; i < loadedFlights.size(); i++) {
                RemoteFlight remote = remoteFlights.get(i);
                Flight flight = loadedFlights.get(i);
                putRemoteId(flightRemoteIds, flight.getFlightId(), remote.id);
                if (remote.id != null) {
                    flightsById.put(remote.id, flight);
                }
            }

            List<Ticket> loadedTickets = remoteTickets.stream()
                    .map(remote -> toTicket(remote, passengersById, flightsById))
                    .filter(ticket -> ticket != null)
                    .collect(Collectors.toList());
            ticketRemoteIds.clear();
            for (int i = 0; i < loadedTickets.size(); i++) {
                RemoteTicket remote = remoteTickets.get(i);
                Ticket ticket = loadedTickets.get(i);
                putRemoteId(ticketRemoteIds, ticket.getTicketId(), remote.id);
                if (remote.id != null) {
                    ticketsById.put(remote.id, ticket);
                }
            }

            List<BoardingPass> loadedBoardingPasses = remoteBoardingPasses.stream()
                    .map(remote -> toBoardingPass(remote, ticketsById))
                    .filter(boardingPass -> boardingPass != null)
                    .collect(Collectors.toList());
            boardingPassRemoteIds.clear();
            for (int i = 0; i < loadedBoardingPasses.size(); i++) {
                putRemoteId(boardingPassRemoteIds, loadedBoardingPasses.get(i).getBoardingPassId(), remoteBoardingPasses.get(i).id);
            }

            List<Luggage> loadedLuggage = remoteLuggage.stream()
                    .map(remote -> toLuggage(remote, ticketsById))
                    .filter(luggage -> luggage != null)
                    .collect(Collectors.toList());
            luggageRemoteIds.clear();
            for (int i = 0; i < loadedLuggage.size(); i++) {
                putRemoteId(luggageRemoteIds, loadedLuggage.get(i).getLuggageId(), remoteLuggage.get(i).id);
            }

            List<SecurityLog> loadedSecurityLogs = remoteSecurityLogs.stream()
                    .map(remote -> toSecurityLog(remote, passengersById, employeesById))
                    .filter(log -> log != null)
                    .collect(Collectors.toList());
            securityLogRemoteIds.clear();
            for (int i = 0; i < loadedSecurityLogs.size(); i++) {
                putRemoteId(securityLogRemoteIds, loadedSecurityLogs.get(i).getLogId(), remoteSecurityLogs.get(i).id);
            }

            employees.setAll(loadedEmployees);
            passengers.setAll(loadedPassengers);
            flights.setAll(loadedFlights);
            tickets.setAll(loadedTickets);
            boardingPasses.setAll(loadedBoardingPasses);
            luggageItems.setAll(loadedLuggage);
            securityLogs.setAll(loadedSecurityLogs);
            syncCounters();
        }

        private void deleteTicketTreeRemote(Ticket ticket) {
            deleteBoardingPassesForTicketRemote(ticket);
            luggageItems.stream()
                    .filter(luggage -> luggage.getTicket() == ticket)
                    .collect(Collectors.toList())
                    .forEach(luggage -> deleteRemote("/luggages", luggageRemoteIds, luggage.getLuggageId()));
            deleteRemote("/tickets", ticketRemoteIds, ticket.getTicketId());
        }

        private void deleteBoardingPassesForTicketRemote(Ticket ticket) {
            boardingPasses.stream()
                    .filter(pass -> pass.getTicket() == ticket)
                    .collect(Collectors.toList())
                    .forEach(pass -> deleteRemote("/boarding-passes", boardingPassRemoteIds, pass.getBoardingPassId()));
        }

        private void deleteRemote(String endpoint, Map<String, Long> remoteIds, String localId) {
            Long remoteId = remoteIds.get(localId);
            if (remoteId != null) {
                apiClient.delete(endpoint + "/" + remoteId);
            }
        }

        private void updateTicketRemote(Ticket ticket) {
            if (ticket == null) {
                return;
            }
            Long remoteId = ticketRemoteIds.get(ticket.getTicketId());
            if (remoteId != null) {
                apiClient.put("/tickets/" + remoteId, toRemoteTicket(ticket), RemoteTicket.class);
            }
        }

        private void syncTicketStatusLocal(BoardingPass boardingPass) {
            if (boardingPass == null || boardingPass.getTicket() == null) {
                return;
            }
            Ticket ticket = boardingPass.getTicket();
            if (ticket.getStatus() == TicketStatus.CANCELLED) {
                return;
            }
            ticket.setStatus(boardingPass.getStatus() == BoardingPassStatus.BOARDED ? TicketStatus.BOARDED : TicketStatus.CHECKED_IN);
        }

        private RemoteFlight toRemoteFlight(Flight flight) {
            RemoteFlight remote = new RemoteFlight();
            remote.id = flightRemoteIds.get(flight.getFlightId());
            remote.flightUid = flight.getFlightId();
            remote.flightNumber = flight.getFlightNumber();
            remote.aircraft = flight.getAircraft();
            remote.departureAirport = flight.getOrigin();
            remote.arrivalAirport = flight.getDestination();
            remote.departureTime = flight.getDepartureTime();
            remote.arrivalTime = flight.getArrivalTime();
            remote.actualDeparture = flight.getActualDeparture();
            remote.actualArrival = flight.getActualArrival();
            remote.status = flight.getStatus().name();
            return remote;
        }

        private RemotePassenger toRemotePassenger(Passenger passenger) {
            RemotePassenger remote = new RemotePassenger();
            remote.id = passengerRemoteIds.get(passenger.getPassengerId());
            remote.passengerUid = passenger.getPassengerId();
            remote.passportNumber = passenger.getPassportId();
            remote.fullName = passenger.getFullName();
            remote.dateOfBirth = passenger.getDateOfBirth();
            remote.nationality = passenger.getNationality();
            remote.email = passenger.getEmail();
            remote.phone = passenger.getPhone();
            return remote;
        }

        private RemoteTicket toRemoteTicket(Ticket ticket) {
            RemoteTicket remote = new RemoteTicket();
            remote.id = ticketRemoteIds.get(ticket.getTicketId());
            remote.ticketUid = ticket.getTicketId();
            remote.passenger = passengerRef(ticket.getPassenger());
            remote.flight = flightRef(ticket.getFlight());
            remote.seatNumber = ticket.getSeatNumber();
            remote.seatClass = ticket.getSeatClass().name();
            remote.price = BigDecimal.valueOf(ticket.getPrice());
            remote.purchaseDate = ticket.getPurchaseDate().atStartOfDay();
            remote.status = ticket.getStatus().name();
            return remote;
        }

        private RemoteBoardingPass toRemoteBoardingPass(BoardingPass boardingPass) {
            RemoteBoardingPass remote = new RemoteBoardingPass();
            remote.id = boardingPassRemoteIds.get(boardingPass.getBoardingPassId());
            remote.boardingPassUid = boardingPass.getBoardingPassId();
            remote.ticket = ticketRef(boardingPass.getTicket());
            remote.gate = boardingPass.getGate();
            remote.boardingTime = boardingPass.getBoardingTime();
            remote.status = boardingPass.getStatus().name();
            return remote;
        }

        private RemoteLuggage toRemoteLuggage(Luggage luggage) {
            RemoteLuggage remote = new RemoteLuggage();
            remote.id = luggageRemoteIds.get(luggage.getLuggageId());
            remote.luggageUid = luggage.getLuggageId();
            remote.ticket = ticketRef(luggage.getTicket());
            remote.weight = luggage.getWeight();
            remote.status = luggage.getStatus().name();
            remote.checkedInTime = luggage.getCheckedInAt();
            return remote;
        }

        private RemoteSecurityLog toRemoteSecurityLog(SecurityLog log) {
            RemoteSecurityLog remote = new RemoteSecurityLog();
            remote.id = securityLogRemoteIds.get(log.getLogId());
            remote.logUid = log.getLogId();
            remote.passenger = passengerRef(log.getPassenger());
            remote.employee = log.getEmployee() == null ? null : employeeRef(log.getEmployee());
            remote.screeningDate = log.getScreeningTime().toLocalDate();
            remote.screeningTime = log.getScreeningTime().toLocalTime();
            remote.result = log.getResult().name();
            remote.notes = log.getNotes();
            return remote;
        }

        private RemoteEmployee toRemoteEmployee(Employee employee) {
            RemoteEmployee remote = new RemoteEmployee();
            remote.id = employeeRemoteIds.get(employee.getEmployeeId());
            remote.employeeUid = employee.getEmployeeId();
            remote.fullName = employee.getFullName();
            remote.email = employee.getEmail();
            remote.phone = employee.getPhone();
            remote.department = employee.getDepartment();
            remote.jobTitle = employee.getJobTitle();
            return remote;
        }

        private RemotePassenger passengerRef(Passenger passenger) {
            RemotePassenger remote = new RemotePassenger();
            remote.id = requireRemoteId(passengerRemoteIds, passenger.getPassengerId(), "passenger");
            return remote;
        }

        private RemoteFlight flightRef(Flight flight) {
            RemoteFlight remote = new RemoteFlight();
            remote.id = requireRemoteId(flightRemoteIds, flight.getFlightId(), "flight");
            return remote;
        }

        private RemoteTicket ticketRef(Ticket ticket) {
            RemoteTicket remote = new RemoteTicket();
            remote.id = requireRemoteId(ticketRemoteIds, ticket.getTicketId(), "ticket");
            return remote;
        }

        private RemoteEmployee employeeRef(Employee employee) {
            RemoteEmployee remote = new RemoteEmployee();
            remote.id = requireRemoteId(employeeRemoteIds, employee.getEmployeeId(), "employee");
            return remote;
        }

        private Flight toFlight(RemoteFlight remote) {
            return new Flight(
                    fallback(remote.flightUid, "FLT-" + remote.id),
                    fallback(remote.flightNumber, ""),
                    fallback(remote.aircraft, ""),
                    fallback(remote.departureAirport, ""),
                    fallback(remote.arrivalAirport, ""),
                    fallback(remote.departureTime, currentTimeFallback()),
                    fallback(remote.arrivalTime, currentTimeFallback().plusHours(2)),
                    remote.actualDeparture,
                    remote.actualArrival,
                    enumValue(FlightStatus.class, remote.status, FlightStatus.ON_TIME)
            );
        }

        private Passenger toPassenger(RemotePassenger remote) {
            return new Passenger(
                    fallback(remote.passengerUid, "PAS-" + remote.id),
                    fallback(remote.passportNumber, ""),
                    fallback(remote.fullName, ""),
                    fallback(remote.dateOfBirth, LocalDate.of(1995, 1, 1)),
                    fallback(remote.nationality, ""),
                    fallback(remote.email, ""),
                    fallback(remote.phone, "")
            );
        }

        private Ticket toTicket(RemoteTicket remote, Map<Long, Passenger> passengersById, Map<Long, Flight> flightsById) {
            Passenger passenger = remote.passenger == null ? null : passengersById.get(remote.passenger.id);
            Flight flight = remote.flight == null ? null : flightsById.get(remote.flight.id);
            if (passenger == null || flight == null) {
                return null;
            }
            return new Ticket(
                    fallback(remote.ticketUid, "TCK-" + remote.id),
                    passenger,
                    flight,
                    fallback(remote.seatNumber, ""),
                    seatClassValue(remote.seatClass),
                    remote.price == null ? 0.0 : remote.price.doubleValue(),
                    remote.purchaseDate == null ? LocalDate.now() : remote.purchaseDate.toLocalDate(),
                    enumValue(TicketStatus.class, remote.status, TicketStatus.BOOKED)
            );
        }

        private BoardingPass toBoardingPass(RemoteBoardingPass remote, Map<Long, Ticket> ticketsById) {
            Ticket ticket = remote.ticket == null ? null : ticketsById.get(remote.ticket.id);
            if (ticket == null) {
                return null;
            }
            return new BoardingPass(
                    fallback(remote.boardingPassUid, "BDP-" + remote.id),
                    ticket,
                    fallback(remote.gate, ""),
                    fallback(remote.boardingTime, currentTimeFallback()),
                    enumValue(BoardingPassStatus.class, remote.status, BoardingPassStatus.ISSUED)
            );
        }

        private Luggage toLuggage(RemoteLuggage remote, Map<Long, Ticket> ticketsById) {
            Ticket ticket = remote.ticket == null ? null : ticketsById.get(remote.ticket.id);
            if (ticket == null) {
                return null;
            }
            return new Luggage(
                    fallback(remote.luggageUid, "LUG-" + remote.id),
                    ticket,
                    remote.weight == null ? 0.0 : remote.weight,
                    enumValue(LuggageStatus.class, remote.status, LuggageStatus.CHECKED_IN),
                    fallback(remote.checkedInTime, currentTimeFallback())
            );
        }

        private SecurityLog toSecurityLog(RemoteSecurityLog remote, Map<Long, Passenger> passengersById, Map<Long, Employee> employeesById) {
            Passenger passenger = remote.passenger == null ? null : passengersById.get(remote.passenger.id);
            if (passenger == null) {
                return null;
            }
            Employee employee = remote.employee == null ? null : employeesById.get(remote.employee.id);
            LocalDate screeningDate = fallback(remote.screeningDate, LocalDate.now());
            LocalTime screeningTime = fallback(remote.screeningTime, LocalTime.MIDNIGHT);
            return new SecurityLog(
                    fallback(remote.logUid, "SEC-" + remote.id),
                    passenger,
                    employee,
                    LocalDateTime.of(screeningDate, screeningTime),
                    enumValue(SecurityResult.class, remote.result, SecurityResult.CLEARED),
                    fallback(remote.notes, "")
            );
        }

        private Employee toEmployee(RemoteEmployee remote) {
            return new Employee(
                    fallback(remote.employeeUid, "EMP-" + remote.id),
                    fallback(remote.fullName, ""),
                    fallback(remote.email, ""),
                    fallback(remote.phone, ""),
                    fallback(remote.department, ""),
                    fallback(remote.jobTitle, "")
            );
        }

        private void syncCounters() {
            flightCounter = nextCounter(flights.stream().map(Flight::getFlightId).collect(Collectors.toList()));
            passengerCounter = nextCounter(passengers.stream().map(Passenger::getPassengerId).collect(Collectors.toList()));
            ticketCounter = nextCounter(tickets.stream().map(Ticket::getTicketId).collect(Collectors.toList()));
            boardingCounter = nextCounter(boardingPasses.stream().map(BoardingPass::getBoardingPassId).collect(Collectors.toList()));
            luggageCounter = nextCounter(luggageItems.stream().map(Luggage::getLuggageId).collect(Collectors.toList()));
            securityCounter = nextCounter(securityLogs.stream().map(SecurityLog::getLogId).collect(Collectors.toList()));
            employeeCounter = nextCounter(employees.stream().map(Employee::getEmployeeId).collect(Collectors.toList()));
        }

        private static int nextCounter(List<String> ids) {
            return ids.stream()
                    .map(MockAirportService::numericSuffix)
                    .max(Integer::compareTo)
                    .orElse(0) + 1;
        }

        private static Integer numericSuffix(String value) {
            if (value == null) {
                return 0;
            }
            String digits = value.replaceAll("\\D+", "");
            if (digits.isEmpty()) {
                return 0;
            }
            try {
                return Integer.parseInt(digits);
            } catch (NumberFormatException exception) {
                return 0;
            }
        }

        private static String nextId(String prefix, int value) {
            return "%s-%04d".formatted(prefix, value);
        }

        private static void putRemoteId(Map<String, Long> remoteIds, String localId, Long remoteId) {
            if (!isBlank(localId) && remoteId != null) {
                remoteIds.put(localId, remoteId);
            }
        }

        private static Long requireRemoteId(Map<String, Long> remoteIds, String localId, String label) {
            Long remoteId = remoteIds.get(localId);
            if (remoteId == null) {
                throw new ApiException("Cannot find backend id for " + label + " " + localId + ".");
            }
            return remoteId;
        }

        private static Role parseRole(String value) {
            return enumValue(Role.class, value, Role.OPERATIONS_STAFF);
        }

        private static SeatClass seatClassValue(String value) {
            if (!isBlank(value)) {
                for (SeatClass seatClass : SeatClass.values()) {
                    if (seatClass.name().equalsIgnoreCase(value) || seatClass.getDisplayName().equalsIgnoreCase(value)) {
                        return seatClass;
                    }
                }
            }
            return SeatClass.ECONOMY;
        }

        private static <E extends Enum<E>> E enumValue(Class<E> enumType, String value, E fallback) {
            if (!isBlank(value)) {
                String normalized = value.trim().toUpperCase().replace('-', '_').replace(' ', '_');
                try {
                    return Enum.valueOf(enumType, normalized);
                } catch (IllegalArgumentException ignored) {
                    return fallback;
                }
            }
            return fallback;
        }

        private static <T> T fallback(T value, T fallback) {
            return value == null ? fallback : value;
        }

        private static String fallback(String value, String fallback) {
            return isBlank(value) ? fallback : value;
        }

        private static boolean isBlank(String value) {
            return value == null || value.trim().isEmpty();
        }

        private static LocalDateTime currentTimeFallback() {
            return LocalDateTime.now().withSecond(0).withNano(0);
        }

        private static final class ApiClient {
            private final HttpClient httpClient = HttpClient.newBuilder()
                    .connectTimeout(Duration.ofSeconds(5))
                    .build();
            private final ObjectMapper mapper = new ObjectMapper()
                    .registerModule(new JavaTimeModule())
                    .disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS)
                    .disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
            private final String baseUrl;
            private String token;

            ApiClient(String baseUrl) {
                this.baseUrl = baseUrl.endsWith("/") ? baseUrl.substring(0, baseUrl.length() - 1) : baseUrl;
            }

            void setToken(String token) {
                this.token = token;
            }

            AuthResponse login(String email, String password) {
                LoginPayload payload = new LoginPayload();
                payload.username = email;
                payload.password = password;
                return post("/auth/login", payload, AuthResponse.class);
            }

            <T> List<T> getList(String path, Class<T> elementType) {
                JavaType listType = mapper.getTypeFactory().constructCollectionType(List.class, elementType);
                return send("GET", path, null, listType);
            }

            <T> T post(String path, Object payload, Class<T> responseType) {
                return send("POST", path, payload, mapper.constructType(responseType));
            }

            <T> T put(String path, Object payload, Class<T> responseType) {
                return send("PUT", path, payload, mapper.constructType(responseType));
            }

            void delete(String path) {
                send("DELETE", path, null, mapper.constructType(Void.class));
            }

            private <T> T send(String method, String path, Object payload, JavaType responseType) {
                try {
                    HttpRequest.Builder builder = HttpRequest.newBuilder(URI.create(baseUrl + path))
                            .timeout(Duration.ofSeconds(20))
                            .header("Accept", "application/json");
                    if (!isBlank(token)) {
                        builder.header("Authorization", "Bearer " + token);
                    }
                    if (payload == null) {
                        builder.method(method, HttpRequest.BodyPublishers.noBody());
                    } else {
                        builder.header("Content-Type", "application/json");
                        builder.method(method, HttpRequest.BodyPublishers.ofString(mapper.writeValueAsString(payload), StandardCharsets.UTF_8));
                    }

                    HttpResponse<String> response = httpClient.send(builder.build(), HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));
                    int status = response.statusCode();
                    if (status >= 200 && status < 300) {
                        if (responseType.getRawClass() == Void.class || response.body() == null || response.body().isBlank()) {
                            return null;
                        }
                        return mapper.readValue(response.body(), responseType);
                    }
                    if (status == 401 || status == 403) {
                        throw new ApiException("Invalid credentials or expired session.");
                    }
                    String responseBody = response.body() == null ? "" : response.body().trim();
                    if (responseBody.length() > 500) {
                        responseBody = responseBody.substring(0, 500) + "...";
                    }
                    String detail = responseBody.isBlank() ? "" : " Detail: " + responseBody;
                    throw new ApiException("Backend returned HTTP " + status + " for " + method + " " + path + "." + detail);
                } catch (ConnectException exception) {
                    throw new ApiException("Backend is not running on " + baseUrl + ".");
                } catch (IOException exception) {
                    throw new ApiException("Cannot connect to backend: " + exception.getMessage());
                } catch (InterruptedException exception) {
                    Thread.currentThread().interrupt();
                    throw new ApiException("Request was interrupted.");
                }
            }
        }

        private static final class ApiException extends RuntimeException {
            ApiException(String message) {
                super(message);
            }
        }

        private static final class LoginPayload {
            public String username;
            public String password;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class AuthResponse {
            public String token;
            public String fullName;
            public String role;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteFlight {
            public Long id;
            public String flightUid;
            public String flightNumber;
            public String aircraft;
            public String departureAirport;
            public String arrivalAirport;
            public LocalDateTime departureTime;
            public LocalDateTime arrivalTime;
            public LocalDateTime actualDeparture;
            public LocalDateTime actualArrival;
            public String status;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemotePassenger {
            public Long id;
            public String passengerUid;
            public String passportNumber;
            public String fullName;
            public LocalDate dateOfBirth;
            public String nationality;
            public String email;
            public String phone;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteTicket {
            public Long id;
            public String ticketUid;
            public RemotePassenger passenger;
            public RemoteFlight flight;
            public String seatNumber;
            public String seatClass;
            public BigDecimal price;
            public LocalDateTime purchaseDate;
            public String status;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteBoardingPass {
            public Long id;
            public String boardingPassUid;
            public RemoteTicket ticket;
            public String gate;
            public LocalDateTime boardingTime;
            public String status;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteLuggage {
            public Long id;
            public String luggageUid;
            public RemoteTicket ticket;
            public Double weight;
            public String status;
            public LocalDateTime checkedInTime;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteSecurityLog {
            public Long id;
            public String logUid;
            public RemotePassenger passenger;
            public RemoteEmployee employee;
            public LocalDate screeningDate;
            public LocalTime screeningTime;
            public String result;
            public String notes;
        }

        @JsonIgnoreProperties(ignoreUnknown = true)
        private static final class RemoteEmployee {
            public Long id;
            public String employeeUid;
            public String fullName;
            public String email;
            public String phone;
            public String department;
            public String jobTitle;
        }
    }

    private enum Role {
        ADMIN("Admin"),
        OPERATIONS_STAFF("Operations Staff"),
        SECURITY_STAFF("Security Staff");

        private final String displayName;

        Role(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum FlightStatus {
        ON_TIME("On Time"),
        DELAYED("Delayed"),
        BOARDING("Boarding"),
        DEPARTED("Departed"),
        ARRIVED("Arrived"),
        CANCELLED("Cancelled");

        private final String displayName;

        FlightStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum TicketStatus {
        BOOKED("Booked"),
        CHECKED_IN("Checked-in"),
        BOARDED("Boarded"),
        CANCELLED("Cancelled");

        private final String displayName;

        TicketStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum BoardingPassStatus {
        ISSUED("Issued"),
        BOARDING("Boarding"),
        BOARDED("Boarded");

        private final String displayName;

        BoardingPassStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum SeatClass {
        ECONOMY("Economy"),
        BUSINESS("Business"),
        FIRST("First");

        private final String displayName;

        SeatClass(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum LuggageStatus {
        CHECKED_IN("Checked-in"),
        LOADED("Loaded"),
        IN_TRANSIT("In Transit"),
        DELIVERED("Delivered"),
        LOST("Lost");

        private final String displayName;

        LuggageStatus(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private enum SecurityResult {
        CLEARED("Cleared"),
        FLAGGED("Flagged"),
        REJECTED("Rejected");

        private final String displayName;

        SecurityResult(String displayName) {
            this.displayName = displayName;
        }

        public String getDisplayName() {
            return displayName;
        }
    }

    private static final class UserAccount {
        private String email;
        private String password;
        private final Role role;
        private String fullName;
        private final String department;
        private String phone;

        UserAccount(String email, String password, Role role, String fullName, String department, String phone) {
            this.email = email;
            this.password = password;
            this.role = role;
            this.fullName = fullName;
            this.department = department;
            this.phone = phone;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }

        public Role getRole() {
            return role;
        }

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public String getDepartment() {
            return department;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }
    }

    private static final class Flight {
        private final String flightId;
        private String flightNumber;
        private String aircraft;
        private String origin;
        private String destination;
        private LocalDateTime departureTime;
        private LocalDateTime arrivalTime;
        private LocalDateTime actualDeparture;
        private LocalDateTime actualArrival;
        private FlightStatus status;

        Flight(String flightId, String flightNumber, String aircraft, String origin, String destination,
               LocalDateTime departureTime, LocalDateTime arrivalTime,
               LocalDateTime actualDeparture, LocalDateTime actualArrival, FlightStatus status) {
            this.flightId = flightId;
            this.flightNumber = flightNumber;
            this.aircraft = aircraft;
            this.origin = origin;
            this.destination = destination;
            this.departureTime = departureTime;
            this.arrivalTime = arrivalTime;
            this.actualDeparture = actualDeparture;
            this.actualArrival = actualArrival;
            this.status = status;
        }

        public String getFlightId() {
            return flightId;
        }

        public String getFlightNumber() {
            return flightNumber;
        }

        public void setFlightNumber(String flightNumber) {
            this.flightNumber = flightNumber;
        }

        public String getAircraft() {
            return aircraft;
        }

        public void setAircraft(String aircraft) {
            this.aircraft = aircraft;
        }

        public String getOrigin() {
            return origin;
        }

        public void setOrigin(String origin) {
            this.origin = origin;
        }

        public String getDestination() {
            return destination;
        }

        public void setDestination(String destination) {
            this.destination = destination;
        }

        public LocalDateTime getDepartureTime() {
            return departureTime;
        }

        public void setDepartureTime(LocalDateTime departureTime) {
            this.departureTime = departureTime;
        }

        public LocalDateTime getArrivalTime() {
            return arrivalTime;
        }

        public void setArrivalTime(LocalDateTime arrivalTime) {
            this.arrivalTime = arrivalTime;
        }

        public LocalDateTime getActualDeparture() {
            return actualDeparture;
        }

        public void setActualDeparture(LocalDateTime actualDeparture) {
            this.actualDeparture = actualDeparture;
        }

        public LocalDateTime getActualArrival() {
            return actualArrival;
        }

        public void setActualArrival(LocalDateTime actualArrival) {
            this.actualArrival = actualArrival;
        }

        public FlightStatus getStatus() {
            return status;
        }

        public void setStatus(FlightStatus status) {
            this.status = status;
        }
    }

    private static final class Passenger {
        private final String passengerId;
        private String passportId;
        private String fullName;
        private LocalDate dateOfBirth;
        private String nationality;
        private String email;
        private String phone;

        Passenger(String passengerId, String passportId, String fullName, LocalDate dateOfBirth,
                  String nationality, String email, String phone) {
            this.passengerId = passengerId;
            this.passportId = passportId;
            this.fullName = fullName;
            this.dateOfBirth = dateOfBirth;
            this.nationality = nationality;
            this.email = email;
            this.phone = phone;
        }

        public String getPassengerId() {
            return passengerId;
        }

        public String getPassportId() {
            return passportId;
        }

        public void setPassportId(String passportId) {
            this.passportId = passportId;
        }

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public LocalDate getDateOfBirth() {
            return dateOfBirth;
        }

        public void setDateOfBirth(LocalDate dateOfBirth) {
            this.dateOfBirth = dateOfBirth;
        }

        public String getNationality() {
            return nationality;
        }

        public void setNationality(String nationality) {
            this.nationality = nationality;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }
    }

    private static final class Ticket {
        private final String ticketId;
        private Passenger passenger;
        private Flight flight;
        private String seatNumber;
        private SeatClass seatClass;
        private double price;
        private LocalDate purchaseDate;
        private TicketStatus status;

        Ticket(String ticketId, Passenger passenger, Flight flight, String seatNumber,
               SeatClass seatClass, double price, LocalDate purchaseDate, TicketStatus status) {
            this.ticketId = ticketId;
            this.passenger = passenger;
            this.flight = flight;
            this.seatNumber = seatNumber;
            this.seatClass = seatClass;
            this.price = price;
            this.purchaseDate = purchaseDate;
            this.status = status;
        }

        public String getTicketId() {
            return ticketId;
        }

        public Passenger getPassenger() {
            return passenger;
        }

        public void setPassenger(Passenger passenger) {
            this.passenger = passenger;
        }

        public Flight getFlight() {
            return flight;
        }

        public void setFlight(Flight flight) {
            this.flight = flight;
        }

        public String getSeatNumber() {
            return seatNumber;
        }

        public void setSeatNumber(String seatNumber) {
            this.seatNumber = seatNumber;
        }

        public SeatClass getSeatClass() {
            return seatClass;
        }

        public void setSeatClass(SeatClass seatClass) {
            this.seatClass = seatClass;
        }

        public double getPrice() {
            return price;
        }

        public void setPrice(double price) {
            this.price = price;
        }

        public LocalDate getPurchaseDate() {
            return purchaseDate;
        }

        public void setPurchaseDate(LocalDate purchaseDate) {
            this.purchaseDate = purchaseDate;
        }

        public TicketStatus getStatus() {
            return status;
        }

        public void setStatus(TicketStatus status) {
            this.status = status;
        }
    }

    private static final class BoardingPass {
        private final String boardingPassId;
        private Ticket ticket;
        private String gate;
        private LocalDateTime boardingTime;
        private BoardingPassStatus status;

        BoardingPass(String boardingPassId, Ticket ticket, String gate, LocalDateTime boardingTime, BoardingPassStatus status) {
            this.boardingPassId = boardingPassId;
            this.ticket = ticket;
            this.gate = gate;
            this.boardingTime = boardingTime;
            this.status = status;
        }

        public String getBoardingPassId() {
            return boardingPassId;
        }

        public Ticket getTicket() {
            return ticket;
        }

        public void setTicket(Ticket ticket) {
            this.ticket = ticket;
        }

        public String getGate() {
            return gate;
        }

        public void setGate(String gate) {
            this.gate = gate;
        }

        public LocalDateTime getBoardingTime() {
            return boardingTime;
        }

        public void setBoardingTime(LocalDateTime boardingTime) {
            this.boardingTime = boardingTime;
        }

        public BoardingPassStatus getStatus() {
            return status;
        }

        public void setStatus(BoardingPassStatus status) {
            this.status = status;
        }
    }

    private static final class Luggage {
        private final String luggageId;
        private Ticket ticket;
        private double weight;
        private LuggageStatus status;
        private LocalDateTime checkedInAt;

        Luggage(String luggageId, Ticket ticket, double weight, LuggageStatus status, LocalDateTime checkedInAt) {
            this.luggageId = luggageId;
            this.ticket = ticket;
            this.weight = weight;
            this.status = status;
            this.checkedInAt = checkedInAt;
        }

        public String getLuggageId() {
            return luggageId;
        }

        public Ticket getTicket() {
            return ticket;
        }

        public void setTicket(Ticket ticket) {
            this.ticket = ticket;
        }

        public double getWeight() {
            return weight;
        }

        public void setWeight(double weight) {
            this.weight = weight;
        }

        public LuggageStatus getStatus() {
            return status;
        }

        public void setStatus(LuggageStatus status) {
            this.status = status;
        }

        public LocalDateTime getCheckedInAt() {
            return checkedInAt;
        }

        public void setCheckedInAt(LocalDateTime checkedInAt) {
            this.checkedInAt = checkedInAt;
        }
    }

    private static final class SecurityLog {
        private final String logId;
        private Passenger passenger;
        private Employee employee;
        private LocalDateTime screeningTime;
        private SecurityResult result;
        private String notes;

        SecurityLog(String logId, Passenger passenger, Employee employee, LocalDateTime screeningTime,
                    SecurityResult result, String notes) {
            this.logId = logId;
            this.passenger = passenger;
            this.employee = employee;
            this.screeningTime = screeningTime;
            this.result = result;
            this.notes = notes;
        }

        public String getLogId() {
            return logId;
        }

        public Passenger getPassenger() {
            return passenger;
        }

        public void setPassenger(Passenger passenger) {
            this.passenger = passenger;
        }

        public Employee getEmployee() {
            return employee;
        }

        public void setEmployee(Employee employee) {
            this.employee = employee;
        }

        public LocalDateTime getScreeningTime() {
            return screeningTime;
        }

        public void setScreeningTime(LocalDateTime screeningTime) {
            this.screeningTime = screeningTime;
        }

        public SecurityResult getResult() {
            return result;
        }

        public void setResult(SecurityResult result) {
            this.result = result;
        }

        public String getNotes() {
            return notes;
        }

        public void setNotes(String notes) {
            this.notes = notes;
        }
    }

    private static final class Employee {
        private final String employeeId;
        private String fullName;
        private String email;
        private String phone;
        private String department;
        private String jobTitle;

        Employee(String employeeId, String fullName, String email, String phone, String department, String jobTitle) {
            this.employeeId = employeeId;
            this.fullName = fullName;
            this.email = email;
            this.phone = phone;
            this.department = department;
            this.jobTitle = jobTitle;
        }

        public String getEmployeeId() {
            return employeeId;
        }

        public String getFullName() {
            return fullName;
        }

        public void setFullName(String fullName) {
            this.fullName = fullName;
        }

        public String getEmail() {
            return email;
        }

        public void setEmail(String email) {
            this.email = email;
        }

        public String getPhone() {
            return phone;
        }

        public void setPhone(String phone) {
            this.phone = phone;
        }

        public String getDepartment() {
            return department;
        }

        public void setDepartment(String department) {
            this.department = department;
        }

        public String getJobTitle() {
            return jobTitle;
        }

        public void setJobTitle(String jobTitle) {
            this.jobTitle = jobTitle;
        }
    }

    public static void main(String[] args) {
        launch(args);
    }
}
