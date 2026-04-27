-- ============================================================
-- AIRPORT MANAGEMENT DATA - TÂN SƠN NHẤT INTERNATIONAL AIRPORT
-- ============================================================

USE AirportMaintenance;

-- ============================================================
-- 1. AIRCRAFT
-- ============================================================
INSERT INTO Aircraft VALUES
('AC001', 'Airbus A321', 'Airbus', 220, 2018, 'Active'),
('AC002', 'Airbus A321', 'Airbus', 220, 2019, 'Active'),
('AC003', 'Airbus A320', 'Airbus', 180, 2017, 'Active'),
('AC004', 'Airbus A320', 'Airbus', 180, 2020, 'Active'),
('AC005', 'Boeing 737-800', 'Boeing', 189, 2016, 'Active'),
('AC006', 'Boeing 737-800', 'Boeing', 189, 2018, 'Active'),
('AC007', 'Boeing 787-9', 'Boeing', 296, 2019, 'Active'),
('AC008', 'Boeing 787-9', 'Boeing', 296, 2021, 'Active'),
('AC009', 'Airbus A350-900', 'Airbus', 305, 2020, 'Active'),
('AC010', 'ATR 72-600', 'ATR', 70, 2017, 'Active'),
('AC011', 'Airbus A321', 'Airbus', 220, 2015, 'Maintenance'),
('AC012', 'Boeing 737-800', 'Boeing', 189, 2014, 'Maintenance'),
('AC013', 'Airbus A320', 'Airbus', 180, 2013, 'Inactive'),
('AC014', 'Boeing 787-9', 'Boeing', 296, 2022, 'Active'),
('AC015', 'Airbus A321neo', 'Airbus', 232, 2023, 'Active');

-- ============================================================
-- 2. EMPLOYEE
-- ============================================================
INSERT INTO Employee VALUES
-- Pilots
('EMP001', 'Nguyễn Văn Hùng', 'Pilot', 'Flight Operations', '2015-03-10', 'Active'),
('EMP002', 'Trần Minh Khoa', 'Pilot', 'Flight Operations', '2016-07-15', 'Active'),
('EMP003', 'Lê Thị Thu Hà', 'Pilot', 'Flight Operations', '2018-01-20', 'Active'),
('EMP004', 'Phạm Quốc Bảo', 'Pilot', 'Flight Operations', '2017-05-01', 'Active'),
('EMP005', 'Hoàng Đức Long', 'Co-Pilot', 'Flight Operations', '2019-08-12', 'Active'),
('EMP006', 'Vũ Thị Lan Anh', 'Co-Pilot', 'Flight Operations', '2020-02-28', 'Active'),
('EMP007', 'Đinh Văn Nam', 'Co-Pilot', 'Flight Operations', '2021-06-01', 'Active'),
-- Cabin Crew
('EMP008', 'Ngô Thị Hương', 'Flight Attendant', 'Cabin Services', '2018-04-10', 'Active'),
('EMP009', 'Bùi Thanh Tùng', 'Flight Attendant', 'Cabin Services', '2019-09-15', 'Active'),
('EMP010', 'Đỗ Thị Mai Ly', 'Flight Attendant', 'Cabin Services', '2020-03-01', 'Active'),
('EMP011', 'Trịnh Hoàng Phúc', 'Flight Attendant', 'Cabin Services', '2019-11-20', 'Active'),
('EMP012', 'Lý Thị Ngọc Hân', 'Flight Attendant', 'Cabin Services', '2021-07-05', 'Active'),
('EMP013', 'Cao Minh Trí', 'Flight Attendant', 'Cabin Services', '2022-01-15', 'Active'),
-- Ground Staff
('EMP014', 'Phan Thị Cẩm Tú', 'Ground Staff', 'Ground Operations', '2017-06-20', 'Active'),
('EMP015', 'Huỳnh Văn Tài', 'Ground Staff', 'Ground Operations', '2018-09-10', 'Active'),
('EMP016', 'Mai Thị Thu Thảo', 'Check-in Agent', 'Passenger Services', '2019-04-01', 'Active'),
('EMP017', 'Nguyễn Thanh Sơn', 'Check-in Agent', 'Passenger Services', '2020-08-15', 'Active'),
-- Security
('EMP018', 'Trần Văn Dũng', 'Security Officer', 'Security', '2016-02-01', 'Active'),
('EMP019', 'Lê Quốc Tuấn', 'Security Officer', 'Security', '2017-10-10', 'Active'),
('EMP020', 'Phạm Thị Bích Ngọc', 'Security Officer', 'Security', '2019-05-20', 'Active');

-- ============================================================
-- 3. PASSENGER
-- ============================================================
INSERT INTO Passenger VALUES
('PAX001', 'Nguyễn', 'Văn', 'An', '1990-05-15', 'Vietnamese', 'Male'),
('PAX002', 'Trần', 'Thị', 'Bình', '1985-08-22', 'Vietnamese', 'Female'),
('PAX003', 'Lê', NULL, 'Cường', '1992-12-01', 'Vietnamese', 'Male'),
('PAX004', 'Phạm', 'Thị', 'Dung', '1995-03-18', 'Vietnamese', 'Female'),
('PAX005', 'John', NULL, 'Smith', '1988-07-30', 'American', 'Male'),
('PAX006', 'Emily', 'Rose', 'Johnson', '1993-11-25', 'British', 'Female'),
('PAX007', 'Tanaka', NULL, 'Hiroshi', '1980-02-14', 'Japanese', 'Male'),
('PAX008', 'Kim', NULL, 'Ji-yeon', '1997-06-09', 'Korean', 'Female'),
('PAX009', 'Hoàng', 'Minh', 'Đức', '1975-09-03', 'Vietnamese', 'Male'),
('PAX010', 'Vũ', 'Thị', 'Hoa', '1999-01-27', 'Vietnamese', 'Female'),
('PAX011', 'Wang', NULL, 'Wei', '1986-04-16', 'Chinese', 'Male'),
('PAX012', 'Sophie', NULL, 'Dubois', '1991-10-08', 'French', 'Female'),
('PAX013', 'Đinh', 'Quốc', 'Hùng', '1983-12-31', 'Vietnamese', 'Male'),
('PAX014', 'Ngô', 'Thị', 'Lan', '2000-07-20', 'Vietnamese', 'Female'),
('PAX015', 'Bùi', 'Văn', 'Minh', '1978-03-05', 'Vietnamese', 'Male'),
('PAX016', 'Ahmad', NULL, 'Reza', '1989-09-12', 'Malaysian', 'Male'),
('PAX017', 'Đỗ', 'Thị', 'Nhung', '1996-05-28', 'Vietnamese', 'Female'),
('PAX018', 'Trịnh', 'Văn', 'Phong', '1987-11-17', 'Vietnamese', 'Male'),
('PAX019', 'Lucas', NULL, 'Müller', '1994-08-04', 'German', 'Male'),
('PAX020', 'Cao', 'Thị', 'Quỳnh', '2001-02-22', 'Vietnamese', 'Female');

-- ============================================================
-- 4. PASSENGER EMAIL (Multivalued)
-- ============================================================
INSERT INTO Passenger_Email (Passenger_ID, Email) VALUES
('PAX001', 'nguyenvanan@gmail.com'),
('PAX002', 'tranthibinh@gmail.com'),
('PAX002', 'binh.tran@company.vn'),
('PAX003', 'lecuong92@gmail.com'),
('PAX004', 'phamthidung@yahoo.com'),
('PAX005', 'john.smith@gmail.com'),
('PAX006', 'emily.johnson@outlook.com'),
('PAX007', 'tanaka.h@jp.co'),
('PAX008', 'kimjiyeon97@naver.com'),
('PAX009', 'hoangminhduc@gmail.com'),
('PAX010', 'vuthihoa99@gmail.com'),
('PAX011', 'wangwei@163.com'),
('PAX012', 'sophie.dubois@gmail.com'),
('PAX013', 'dinhquochung@gmail.com'),
('PAX013', 'hung.dinh@biz.vn'),
('PAX014', 'ngothilan@gmail.com'),
('PAX015', 'buivanminh@gmail.com'),
('PAX016', 'ahmad.reza@gmail.com'),
('PAX017', 'dothinhung@gmail.com'),
('PAX018', 'trinhvanphong@gmail.com'),
('PAX019', 'lucas.muller@gmail.de'),
('PAX020', 'caothiquynh@gmail.com');

-- ============================================================
-- 5. PASSENGER PHONE (Multivalued)
-- ============================================================
INSERT INTO Passenger_Phone (Passenger_ID, Phone_Number) VALUES
('PAX001', '0901234567'),
('PAX002', '0912345678'),
('PAX002', '0287654321'),
('PAX003', '0923456789'),
('PAX004', '0934567890'),
('PAX005', '+14155550101'),
('PAX006', '+447911123456'),
('PAX007', '+819012345678'),
('PAX008', '+821012345678'),
('PAX009', '0945678901'),
('PAX010', '0956789012'),
('PAX011', '+8613812345678'),
('PAX012', '+33612345678'),
('PAX013', '0967890123'),
('PAX014', '0978901234'),
('PAX015', '0989012345'),
('PAX016', '+60123456789'),
('PAX017', '0990123456'),
('PAX018', '0901234568'),
('PAX019', '+4915123456789'),
('PAX020', '0912345679');

-- ============================================================
-- 6. FLIGHT
-- ============================================================
INSERT INTO Flight VALUES
-- Nội địa T1 (cũ)
('FL001', 'VN123', 'Tan Son Nhat (SGN)', 'Noi Bai (HAN)', '2025-06-01 06:00:00', '2025-06-01 06:05:00', '2025-06-01 08:10:00', '2025-06-01 08:15:00', 'Completed', 'AC001'),
('FL002', 'VJ234', 'Tan Son Nhat (SGN)', 'Da Nang (DAD)', '2025-06-01 07:30:00', '2025-06-01 07:35:00', '2025-06-01 09:00:00', '2025-06-01 09:05:00', 'Completed', 'AC003'),
('FL003', 'QH345', 'Tan Son Nhat (SGN)', 'Phu Quoc (PQC)', '2025-06-01 09:00:00', '2025-06-01 09:10:00', '2025-06-01 10:05:00', '2025-06-01 10:20:00', 'Completed', 'AC010'),
('FL004', 'VN456', 'Tan Son Nhat (SGN)', 'Cam Ranh (CXR)', '2025-06-01 11:00:00', '2025-06-01 11:00:00', '2025-06-01 12:10:00', '2025-06-01 12:10:00', 'Completed', 'AC004'),
('FL005', 'VJ567', 'Noi Bai (HAN)', 'Tan Son Nhat (SGN)', '2025-06-01 14:00:00', '2025-06-01 14:15:00', '2025-06-01 16:10:00', '2025-06-01 16:30:00', 'Completed', 'AC002'),
-- Quốc tế T2
('FL006', 'VN001', 'Tan Son Nhat (SGN)', 'Narita (NRT)', '2025-06-01 08:00:00', '2025-06-01 08:05:00', '2025-06-01 15:30:00', '2025-06-01 15:35:00', 'Completed', 'AC007'),
('FL007', 'VN011', 'Tan Son Nhat (SGN)', 'Incheon (ICN)', '2025-06-01 10:30:00', '2025-06-01 10:30:00', '2025-06-01 17:45:00', '2025-06-01 17:45:00', 'Completed', 'AC009'),
('FL008', 'QR560', 'Tan Son Nhat (SGN)', 'Doha (DOH)', '2025-06-01 23:55:00', NULL, '2025-06-02 05:30:00', NULL, 'Scheduled', 'AC014'),
('FL009', 'SQ185', 'Tan Son Nhat (SGN)', 'Changi (SIN)', '2025-06-01 13:00:00', '2025-06-01 13:05:00', '2025-06-01 16:25:00', '2025-06-01 16:30:00', 'Completed', 'AC008'),
('FL010', 'CX761', 'Tan Son Nhat (SGN)', 'Hong Kong (HKG)', '2025-06-01 15:45:00', '2025-06-01 15:50:00', '2025-06-01 19:30:00', '2025-06-01 19:35:00', 'Completed', 'AC005'),
-- T3 Nội địa mới
('FL011', 'VN789', 'Tan Son Nhat (SGN)', 'Noi Bai (HAN)', '2025-06-01 06:30:00', '2025-06-01 06:30:00', '2025-06-01 08:40:00', '2025-06-01 08:40:00', 'Completed', 'AC015'),
('FL012', 'VJ890', 'Tan Son Nhat (SGN)', 'Da Nang (DAD)', '2025-06-01 08:00:00', '2025-06-01 08:10:00', '2025-06-01 09:30:00', '2025-06-01 09:45:00', 'Completed', 'AC006'),
('FL013', 'VN321', 'Tan Son Nhat (SGN)', 'Hue (HUI)', '2025-06-01 10:00:00', NULL, '2025-06-01 11:20:00', NULL, 'Cancelled', 'AC011'),
('FL014', 'VJ432', 'Tan Son Nhat (SGN)', 'Phu Quoc (PQC)', '2025-06-01 12:30:00', '2025-06-01 12:45:00', '2025-06-01 13:35:00', '2025-06-01 13:50:00', 'Completed', 'AC003'),
('FL015', 'QH543', 'Tan Son Nhat (SGN)', 'Can Tho (VCA)', '2025-06-01 16:00:00', '2025-06-01 16:00:00', '2025-06-01 16:50:00', '2025-06-01 16:50:00', 'Completed', 'AC010');

-- ============================================================
-- 7. CREW_FLIGHT
-- ============================================================
INSERT INTO Crew_Flight VALUES
('FL001', 'EMP001', 'Captain'),
('FL001', 'EMP005', 'First Officer'),
('FL001', 'EMP008', 'Lead Flight Attendant'),
('FL001', 'EMP009', 'Flight Attendant'),
('FL002', 'EMP002', 'Captain'),
('FL002', 'EMP006', 'First Officer'),
('FL002', 'EMP010', 'Lead Flight Attendant'),
('FL003', 'EMP003', 'Captain'),
('FL003', 'EMP007', 'First Officer'),
('FL003', 'EMP011', 'Flight Attendant'),
('FL004', 'EMP004', 'Captain'),
('FL004', 'EMP005', 'First Officer'),
('FL004', 'EMP012', 'Flight Attendant'),
('FL005', 'EMP001', 'Captain'),
('FL005', 'EMP006', 'First Officer'),
('FL005', 'EMP013', 'Flight Attendant'),
('FL006', 'EMP002', 'Captain'),
('FL006', 'EMP007', 'First Officer'),
('FL006', 'EMP008', 'Lead Flight Attendant'),
('FL006', 'EMP009', 'Flight Attendant'),
('FL006', 'EMP010', 'Flight Attendant'),
('FL007', 'EMP003', 'Captain'),
('FL007', 'EMP005', 'First Officer'),
('FL007', 'EMP011', 'Lead Flight Attendant'),
('FL007', 'EMP012', 'Flight Attendant'),
('FL008', 'EMP004', 'Captain'),
('FL008', 'EMP006', 'First Officer'),
('FL008', 'EMP013', 'Flight Attendant'),
('FL009', 'EMP001', 'Captain'),
('FL009', 'EMP007', 'First Officer'),
('FL009', 'EMP008', 'Lead Flight Attendant'),
('FL010', 'EMP002', 'Captain'),
('FL010', 'EMP005', 'First Officer'),
('FL010', 'EMP009', 'Flight Attendant'),
('FL011', 'EMP003', 'Captain'),
('FL011', 'EMP006', 'First Officer'),
('FL011', 'EMP010', 'Lead Flight Attendant'),
('FL012', 'EMP004', 'Captain'),
('FL012', 'EMP007', 'First Officer'),
('FL012', 'EMP011', 'Flight Attendant'),
('FL014', 'EMP001', 'Captain'),
('FL014', 'EMP005', 'First Officer'),
('FL014', 'EMP012', 'Flight Attendant'),
('FL015', 'EMP002', 'Captain'),
('FL015', 'EMP006', 'First Officer'),
('FL015', 'EMP013', 'Flight Attendant');

-- ============================================================
-- 8. TICKET
-- ============================================================
INSERT INTO Ticket VALUES
-- FL001 – VN123 SGN→HAN (T1)
('TK001', 'T1', '12A', 'Business', 2500000.00, '2025-05-20 10:00:00', 'PAX001', 'FL001'),
('TK002', 'T1', '23B', 'Economy', 1200000.00, '2025-05-21 14:00:00', 'PAX002', 'FL001'),
('TK003', 'T1', '24C', 'Economy', 1200000.00, '2025-05-22 09:00:00', 'PAX003', 'FL001'),
-- FL002 – VJ234 SGN→DAD (T1)
('TK004', 'T1', '10D', 'Economy', 900000.00, '2025-05-18 08:00:00', 'PAX004', 'FL002'),
('TK005', 'T1', '11E', 'Economy', 900000.00, '2025-05-19 11:00:00', 'PAX009', 'FL002'),
-- FL003 – QH345 SGN→PQC (T1)
('TK006', 'T1', '5A', 'Economy', 1100000.00, '2025-05-25 07:30:00', 'PAX010', 'FL003'),
('TK007', 'T1', '5B', 'Economy', 1100000.00, '2025-05-26 10:00:00', 'PAX013', 'FL003'),
-- FL006 – VN001 SGN→NRT (T2)
('TK008', 'T2', '8A', 'Business', 12000000.00, '2025-05-10 09:00:00', 'PAX005', 'FL006'),
('TK009', 'T2', '9B', 'Business', 12000000.00, '2025-05-12 13:00:00', 'PAX007', 'FL006'),
('TK010', 'T2', '25C', 'Economy', 5500000.00, '2025-05-15 16:00:00', 'PAX011', 'FL006'),
-- FL007 – VN011 SGN→ICN (T2)
('TK011', 'T2', '7A', 'Business', 11000000.00, '2025-05-14 10:00:00', 'PAX008', 'FL007'),
('TK012', 'T2', '28D', 'Economy', 4800000.00, '2025-05-16 08:00:00', 'PAX012', 'FL007'),
-- FL009 – SQ185 SGN→SIN (T2)
('TK013', 'T2', '15C', 'Economy', 3200000.00, '2025-05-22 11:00:00', 'PAX015', 'FL009'),
('TK014', 'T2', '16D', 'Economy', 3200000.00, '2025-05-23 09:30:00', 'PAX016', 'FL009'),
-- FL010 – CX761 SGN→HKG (T2)
('TK015', 'T2', '6B', 'Business', 9500000.00, '2025-05-11 14:00:00', 'PAX019', 'FL010'),
-- FL011 – VN789 SGN→HAN (T3)
('TK016', 'T3', '14A', 'Economy', 1300000.00, '2025-05-23 10:00:00', 'PAX014', 'FL011'),
('TK017', 'T3', '15B', 'Economy', 1300000.00, '2025-05-24 12:00:00', 'PAX017', 'FL011'),
-- FL012 – VJ890 SGN→DAD (T3)
('TK018', 'T3', '20C', 'Economy', 850000.00, '2025-05-25 15:00:00', 'PAX018', 'FL012'),
('TK019', 'T3', '21D', 'Economy', 850000.00, '2025-05-26 09:00:00', 'PAX020', 'FL012'),
-- FL014 – VJ432 SGN→PQC (T3)
('TK020', 'T3', '9C', 'Economy', 1050000.00, '2025-05-27 08:00:00', 'PAX006', 'FL014');

-- ============================================================
-- 9. BOARDING PASS
-- ============================================================
INSERT INTO Boarding_Pass VALUES
('BP001', 'TK001', '2025-06-01 05:20:00', 'G12'),
('BP002', 'TK002', '2025-06-01 05:25:00', 'G12'),
('BP003', 'TK003', '2025-06-01 05:30:00', 'G12'),
('BP004', 'TK004', '2025-06-01 06:50:00', 'G08'),
('BP005', 'TK005', '2025-06-01 06:55:00', 'G08'),
('BP006', 'TK006', '2025-06-01 08:15:00', 'G05'),
('BP007', 'TK007', '2025-06-01 08:20:00', 'G05'),
('BP008', 'TK008', '2025-06-01 07:00:00', 'A01'),
('BP009', 'TK009', '2025-06-01 07:05:00', 'A01'),
('BP010', 'TK010', '2025-06-01 07:10:00', 'A01'),
('BP011', 'TK011', '2025-06-01 09:30:00', 'A03'),
('BP012', 'TK012', '2025-06-01 09:35:00', 'A03'),
('BP013', 'TK013', '2025-06-01 12:00:00', 'A07'),
('BP014', 'TK014', '2025-06-01 12:05:00', 'A07'),
('BP015', 'TK015', '2025-06-01 14:45:00', 'A05'),
('BP016', 'TK016', '2025-06-01 05:30:00', 'C02'),
('BP017', 'TK017', '2025-06-01 05:35:00', 'C02'),
('BP018', 'TK018', '2025-06-01 07:00:00', 'C04'),
('BP019', 'TK019', '2025-06-01 07:05:00', 'C04'),
('BP020', 'TK020', '2025-06-01 11:30:00', 'C06');

-- ============================================================
-- 10. LUGGAGE
-- ============================================================
INSERT INTO Luggage VALUES
('LG001', 22.50, '2025-06-01 05:00:00', 'Delivered', 'TK001'),
('LG002', 18.00, '2025-06-01 05:05:00', 'Delivered', 'TK002'),
('LG003', 15.30, '2025-06-01 05:08:00', 'Delivered', 'TK003'),
('LG004', 20.00, '2025-06-01 06:30:00', 'Delivered', 'TK004'),
('LG005', 12.50, '2025-06-01 06:35:00', 'Delivered', 'TK005'),
('LG006', 25.00, '2025-06-01 08:00:00', 'Delivered', 'TK006'),
('LG007', 10.00, '2025-06-01 08:05:00', 'Delivered', 'TK007'),
('LG008', 30.00, '2025-06-01 06:45:00', 'Delivered', 'TK008'),
('LG009', 28.00, '2025-06-01 06:50:00', 'Delivered', 'TK009'),
('LG010', 19.50, '2025-06-01 06:55:00', 'Delivered', 'TK010'),
('LG011', 23.00, '2025-06-01 09:20:00', 'Delivered', 'TK011'),
('LG012', 17.00, '2025-06-01 09:25:00', 'Delivered', 'TK012'),
('LG013', 21.00, '2025-06-01 11:50:00', 'Delivered', 'TK013'),
('LG014', 14.50, '2025-06-01 11:55:00', 'Delivered', 'TK014'),
('LG015', 32.00, '2025-06-01 14:30:00', 'Delivered', 'TK015'),
('LG016', 16.00, '2025-06-01 05:10:00', 'Delivered', 'TK016'),
('LG017', 11.00, '2025-06-01 05:15:00', 'Delivered', 'TK017'),
('LG018', 24.00, '2025-06-01 06:50:00', 'Delivered', 'TK018'),
('LG019', 9.50,  '2025-06-01 06:55:00', 'Delivered', 'TK019'),
('LG020', 13.00, '2025-06-01 11:15:00', 'Delivered', 'TK020'),
-- Một số hành lý bị thất lạc / delay
('LG021', 18.50, '2025-06-01 06:58:00', 'Lost', 'TK003'),
('LG022', 26.00, '2025-06-01 09:22:00', 'Delayed', 'TK012');

-- ============================================================
-- 11. SECURITY LOG
-- ============================================================
INSERT INTO Security_Log (Passenger_ID, Screen_DateTime, Result, Note) VALUES
('PAX001', '2025-06-01 04:45:00', 'Clear', NULL),
('PAX002', '2025-06-01 04:50:00', 'Clear', NULL),
('PAX003', '2025-06-01 04:52:00', 'Alert', 'Passenger flagged – secondary screening required'),
('PAX004', '2025-06-01 06:20:00', 'Clear', NULL),
('PAX005', '2025-06-01 06:30:00', 'Clear', NULL),
('PAX006', '2025-06-01 11:00:00', 'Clear', NULL),
('PAX007', '2025-06-01 06:35:00', 'Clear', NULL),
('PAX008', '2025-06-01 09:00:00', 'Clear', NULL),
('PAX009', '2025-06-01 06:25:00', 'Clear', NULL),
('PAX010', '2025-06-01 08:00:00', 'Clear', NULL),
('PAX011', '2025-06-01 06:40:00', 'Alert', 'Prohibited item detected'),
('PAX012', '2025-06-01 09:05:00', 'Clear', NULL),
('PAX013', '2025-06-01 08:05:00', 'Clear', NULL),
('PAX014', '2025-06-01 05:05:00', 'Clear', NULL),
('PAX015', '2025-06-01 11:40:00', 'Clear', NULL),
('PAX016', '2025-06-01 11:45:00', 'Clear', NULL),
('PAX017', '2025-06-01 05:10:00', 'Clear', NULL),
('PAX018', '2025-06-01 06:40:00', 'Clear', NULL),
('PAX019', '2025-06-01 14:30:00', 'Clear', NULL),
('PAX020', '2025-06-01 06:45:00', 'Alert', 'Oversized carry-on, required to check in bag');

-- ============================================================
-- 12. SECURITY RESTRICTED ITEMS
-- ============================================================
-- Log 3 (PAX003 – flagged, secondary screening)
INSERT INTO Security_Restricted_Items (Log_ID, Item_Name) VALUES
(3, 'Metal object (belt buckle)'),
-- Log 11 (PAX011 – prohibited item)
(11, 'Lighter fluid (flammable liquid)'),
(11, 'Pocket knife > 6cm'),
-- Log 20 (PAX020 – oversized carry-on)
(20, 'Oversized carry-on bag (62L)');

