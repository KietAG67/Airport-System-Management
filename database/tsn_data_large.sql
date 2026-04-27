-- ============================================================
-- AIRPORT MANAGEMENT DATA (x4) - TÂN SƠN NHẤT INTERNATIONAL
-- ============================================================
USE AirportMaintenance;

-- ============================================================
-- 1. AIRCRAFT (60 records)
-- ============================================================
INSERT INTO Aircraft VALUES
('AC001','Airbus A321','Airbus',220,2018,'Active'),
('AC002','Airbus A321','Airbus',220,2019,'Active'),
('AC003','Airbus A320','Airbus',180,2017,'Active'),
('AC004','Airbus A320','Airbus',180,2020,'Active'),
('AC005','Boeing 737-800','Boeing',189,2016,'Active'),
('AC006','Boeing 737-800','Boeing',189,2018,'Active'),
('AC007','Boeing 787-9','Boeing',296,2019,'Active'),
('AC008','Boeing 787-9','Boeing',296,2021,'Active'),
('AC009','Airbus A350-900','Airbus',305,2020,'Active'),
('AC010','ATR 72-600','ATR',70,2017,'Active'),
('AC011','Airbus A321','Airbus',220,2015,'Maintenance'),
('AC012','Boeing 737-800','Boeing',189,2014,'Maintenance'),
('AC013','Airbus A320','Airbus',180,2013,'Inactive'),
('AC014','Boeing 787-9','Boeing',296,2022,'Active'),
('AC015','Airbus A321neo','Airbus',232,2023,'Active'),
('AC016','Airbus A321neo','Airbus',232,2022,'Active'),
('AC017','Boeing 737 MAX 8','Boeing',178,2021,'Active'),
('AC018','Boeing 737 MAX 8','Boeing',178,2022,'Active'),
('AC019','Airbus A320neo','Airbus',165,2021,'Active'),
('AC020','Airbus A320neo','Airbus',165,2022,'Active'),
('AC021','Boeing 787-10','Boeing',330,2020,'Active'),
('AC022','Boeing 787-10','Boeing',330,2021,'Active'),
('AC023','Airbus A350-900','Airbus',305,2021,'Active'),
('AC024','Airbus A350-900','Airbus',305,2022,'Active'),
('AC025','ATR 72-600','ATR',70,2019,'Active'),
('AC026','ATR 72-600','ATR',70,2020,'Active'),
('AC027','Airbus A321','Airbus',220,2016,'Active'),
('AC028','Airbus A321','Airbus',220,2017,'Active'),
('AC029','Boeing 737-800','Boeing',189,2015,'Active'),
('AC030','Boeing 737-800','Boeing',189,2016,'Active'),
('AC031','Airbus A320','Airbus',180,2018,'Active'),
('AC032','Airbus A320','Airbus',180,2019,'Active'),
('AC033','Boeing 787-9','Boeing',296,2020,'Active'),
('AC034','Boeing 787-9','Boeing',296,2022,'Active'),
('AC035','Airbus A321neo','Airbus',232,2023,'Active'),
('AC036','Airbus A321neo','Airbus',232,2024,'Active'),
('AC037','Boeing 737 MAX 8','Boeing',178,2023,'Active'),
('AC038','Boeing 737 MAX 8','Boeing',178,2024,'Active'),
('AC039','Airbus A320neo','Airbus',165,2023,'Active'),
('AC040','Airbus A320neo','Airbus',165,2024,'Active'),
('AC041','Boeing 787-10','Boeing',330,2022,'Active'),
('AC042','Boeing 787-10','Boeing',330,2023,'Active'),
('AC043','Airbus A350-900','Airbus',305,2023,'Active'),
('AC044','Airbus A350-900','Airbus',305,2024,'Active'),
('AC045','ATR 72-600','ATR',70,2021,'Active'),
('AC046','ATR 72-600','ATR',70,2022,'Active'),
('AC047','Airbus A321','Airbus',220,2014,'Maintenance'),
('AC048','Boeing 737-800','Boeing',189,2013,'Maintenance'),
('AC049','Airbus A320','Airbus',180,2012,'Inactive'),
('AC050','Boeing 787-9','Boeing',296,2011,'Inactive'),
('AC051','Airbus A321neo','Airbus',232,2024,'Active'),
('AC052','Boeing 737 MAX 8','Boeing',178,2024,'Active'),
('AC053','Airbus A320neo','Airbus',165,2024,'Active'),
('AC054','Boeing 787-10','Boeing',330,2024,'Active'),
('AC055','Airbus A350-900','Airbus',305,2024,'Active'),
('AC056','ATR 72-600','ATR',70,2023,'Active'),
('AC057','Airbus A321','Airbus',220,2023,'Active'),
('AC058','Boeing 737-800','Boeing',189,2023,'Active'),
('AC059','Airbus A320','Airbus',180,2024,'Active'),
('AC060','Boeing 787-9','Boeing',296,2024,'Active');

-- ============================================================
-- 2. EMPLOYEE (80 records)
-- ============================================================
INSERT INTO Employee VALUES
('EMP001','Nguyễn Văn Hùng','Pilot','Flight Operations','2015-03-10','Active'),
('EMP002','Trần Minh Khoa','Pilot','Flight Operations','2016-07-15','Active'),
('EMP003','Lê Thị Thu Hà','Pilot','Flight Operations','2018-01-20','Active'),
('EMP004','Phạm Quốc Bảo','Pilot','Flight Operations','2017-05-01','Active'),
('EMP005','Hoàng Đức Long','Co-Pilot','Flight Operations','2019-08-12','Active'),
('EMP006','Vũ Thị Lan Anh','Co-Pilot','Flight Operations','2020-02-28','Active'),
('EMP007','Đinh Văn Nam','Co-Pilot','Flight Operations','2021-06-01','Active'),
('EMP008','Ngô Thị Hương','Flight Attendant','Cabin Services','2018-04-10','Active'),
('EMP009','Bùi Thanh Tùng','Flight Attendant','Cabin Services','2019-09-15','Active'),
('EMP010','Đỗ Thị Mai Ly','Flight Attendant','Cabin Services','2020-03-01','Active'),
('EMP011','Trịnh Hoàng Phúc','Flight Attendant','Cabin Services','2019-11-20','Active'),
('EMP012','Lý Thị Ngọc Hân','Flight Attendant','Cabin Services','2021-07-05','Active'),
('EMP013','Cao Minh Trí','Flight Attendant','Cabin Services','2022-01-15','Active'),
('EMP014','Phan Thị Cẩm Tú','Ground Staff','Ground Operations','2017-06-20','Active'),
('EMP015','Huỳnh Văn Tài','Ground Staff','Ground Operations','2018-09-10','Active'),
('EMP016','Mai Thị Thu Thảo','Check-in Agent','Passenger Services','2019-04-01','Active'),
('EMP017','Nguyễn Thanh Sơn','Check-in Agent','Passenger Services','2020-08-15','Active'),
('EMP018','Trần Văn Dũng','Security Officer','Security','2016-02-01','Active'),
('EMP019','Lê Quốc Tuấn','Security Officer','Security','2017-10-10','Active'),
('EMP020','Phạm Thị Bích Ngọc','Security Officer','Security','2019-05-20','Active'),
('EMP021','Võ Minh Tuấn','Pilot','Flight Operations','2014-11-15','Active'),
('EMP022','Đặng Thị Lan','Pilot','Flight Operations','2015-08-20','Active'),
('EMP023','Nguyễn Hoàng Phát','Pilot','Flight Operations','2016-03-05','Active'),
('EMP024','Trần Đức Thịnh','Pilot','Flight Operations','2017-09-18','Active'),
('EMP025','Lê Văn Toàn','Co-Pilot','Flight Operations','2018-12-01','Active'),
('EMP026','Phạm Thị Yến','Co-Pilot','Flight Operations','2019-06-15','Active'),
('EMP027','Hoàng Văn Khánh','Co-Pilot','Flight Operations','2020-10-20','Active'),
('EMP028','Vũ Quốc Thắng','Co-Pilot','Flight Operations','2021-04-10','Active'),
('EMP029','Đinh Thị Thu Nga','Flight Attendant','Cabin Services','2018-07-01','Active'),
('EMP030','Ngô Văn Hải','Flight Attendant','Cabin Services','2019-02-14','Active'),
('EMP031','Bùi Thị Phương','Flight Attendant','Cabin Services','2020-05-20','Active'),
('EMP032','Đỗ Minh Quân','Flight Attendant','Cabin Services','2021-08-15','Active'),
('EMP033','Trịnh Thị Như Ý','Flight Attendant','Cabin Services','2022-03-01','Active'),
('EMP034','Lý Văn Đạt','Flight Attendant','Cabin Services','2022-09-10','Active'),
('EMP035','Cao Thị Mỹ Duyên','Flight Attendant','Cabin Services','2023-01-05','Active'),
('EMP036','Phan Văn Nghĩa','Flight Attendant','Cabin Services','2023-06-20','Active'),
('EMP037','Huỳnh Thị Kim Loan','Ground Staff','Ground Operations','2016-04-15','Active'),
('EMP038','Mai Văn Linh','Ground Staff','Ground Operations','2017-11-30','Active'),
('EMP039','Nguyễn Thị Thanh Hằng','Ground Staff','Ground Operations','2018-06-25','Active'),
('EMP040','Trần Văn Phúc','Ground Staff','Ground Operations','2019-09-01','Active'),
('EMP041','Lê Thị Mỹ Hạnh','Check-in Agent','Passenger Services','2017-03-10','Active'),
('EMP042','Phạm Văn Lộc','Check-in Agent','Passenger Services','2018-07-22','Active'),
('EMP043','Hoàng Thị Diệu Linh','Check-in Agent','Passenger Services','2019-12-15','Active'),
('EMP044','Vũ Văn Cảnh','Check-in Agent','Passenger Services','2020-06-01','Active'),
('EMP045','Đinh Thị Thanh Thúy','Security Officer','Security','2015-05-10','Active'),
('EMP046','Ngô Văn Hậu','Security Officer','Security','2016-09-20','Active'),
('EMP047','Bùi Thị Ngọc Lan','Security Officer','Security','2017-12-05','Active'),
('EMP048','Đỗ Văn Khải','Security Officer','Security','2018-04-18','Active'),
('EMP049','Trịnh Văn Sỹ','Security Officer','Security','2019-08-30','Active'),
('EMP050','Lý Thị Thu Huyền','Security Officer','Security','2020-11-15','Active'),
('EMP051','Cao Văn Lâm','Pilot','Flight Operations','2013-07-20','Active'),
('EMP052','Phan Thị Hoa','Pilot','Flight Operations','2014-02-14','Active'),
('EMP053','Huỳnh Văn Sáng','Pilot','Flight Operations','2015-10-01','Active'),
('EMP054','Mai Thị Kiều Oanh','Co-Pilot','Flight Operations','2016-05-25','Active'),
('EMP055','Nguyễn Đức Huy','Co-Pilot','Flight Operations','2017-08-10','Active'),
('EMP056','Trần Thị Bảo Châu','Co-Pilot','Flight Operations','2018-11-20','Active'),
('EMP057','Lê Văn Dương','Flight Attendant','Cabin Services','2019-04-05','Active'),
('EMP058','Phạm Thị Hồng Nhung','Flight Attendant','Cabin Services','2020-07-18','Active'),
('EMP059','Hoàng Văn Bình','Flight Attendant','Cabin Services','2021-01-10','Active'),
('EMP060','Vũ Thị Xuân Mai','Flight Attendant','Cabin Services','2021-09-25','Active'),
('EMP061','Đinh Văn Thiện','Ground Staff','Ground Operations','2015-06-15','Active'),
('EMP062','Ngô Thị Hoa Đào','Ground Staff','Ground Operations','2016-12-01','Active'),
('EMP063','Bùi Văn Quý','Baggage Handler','Ground Operations','2017-04-20','Active'),
('EMP064','Đỗ Thị Thu Trang','Baggage Handler','Ground Operations','2018-08-05','Active'),
('EMP065','Trịnh Văn Lực','Baggage Handler','Ground Operations','2019-01-15','Active'),
('EMP066','Lý Thị Cẩm Nhung','Baggage Handler','Ground Operations','2019-10-30','Active'),
('EMP067','Cao Văn Dũng','Baggage Handler','Ground Operations','2020-04-15','Active'),
('EMP068','Phan Thị Thanh Tâm','Check-in Agent','Passenger Services','2021-02-01','Active'),
('EMP069','Huỳnh Văn Thành','Check-in Agent','Passenger Services','2021-08-20','Active'),
('EMP070','Mai Thị Bích Trâm','Check-in Agent','Passenger Services','2022-03-10','Active'),
('EMP071','Nguyễn Văn Tâm','Security Officer','Security','2014-09-05','Active'),
('EMP072','Trần Thị Mỹ Linh','Security Officer','Security','2015-04-18','Active'),
('EMP073','Lê Văn Đông','Security Officer','Security','2016-07-30','Active'),
('EMP074','Phạm Thị Hồng Hạnh','Security Officer','Security','2017-11-12','Inactive'),
('EMP075','Hoàng Văn Tùng','Pilot','Flight Operations','2012-05-01','Active'),
('EMP076','Vũ Thị Phương Linh','Pilot','Flight Operations','2013-09-15','Active'),
('EMP077','Đinh Văn Mạnh','Co-Pilot','Flight Operations','2015-02-28','Active'),
('EMP078','Ngô Thị Diễm Quỳnh','Flight Attendant','Cabin Services','2018-06-10','Active'),
('EMP079','Bùi Văn Hiếu','Flight Attendant','Cabin Services','2019-12-01','Active'),
('EMP080','Đỗ Thị Khánh Linh','Flight Attendant','Cabin Services','2020-09-15','Active');

-- ============================================================
-- 3. PASSENGER (80 records)
-- ============================================================
INSERT INTO Passenger VALUES
('PAX001','Nguyễn','Văn','An','1990-05-15','Vietnamese','Male'),
('PAX002','Trần','Thị','Bình','1985-08-22','Vietnamese','Female'),
('PAX003','Lê',NULL,'Cường','1992-12-01','Vietnamese','Male'),
('PAX004','Phạm','Thị','Dung','1995-03-18','Vietnamese','Female'),
('PAX005','John',NULL,'Smith','1988-07-30','American','Male'),
('PAX006','Emily','Rose','Johnson','1993-11-25','British','Female'),
('PAX007','Tanaka',NULL,'Hiroshi','1980-02-14','Japanese','Male'),
('PAX008','Kim',NULL,'Ji-yeon','1997-06-09','Korean','Female'),
('PAX009','Hoàng','Minh','Đức','1975-09-03','Vietnamese','Male'),
('PAX010','Vũ','Thị','Hoa','1999-01-27','Vietnamese','Female'),
('PAX011','Wang',NULL,'Wei','1986-04-16','Chinese','Male'),
('PAX012','Sophie',NULL,'Dubois','1991-10-08','French','Female'),
('PAX013','Đinh','Quốc','Hùng','1983-12-31','Vietnamese','Male'),
('PAX014','Ngô','Thị','Lan','2000-07-20','Vietnamese','Female'),
('PAX015','Bùi','Văn','Minh','1978-03-05','Vietnamese','Male'),
('PAX016','Ahmad',NULL,'Reza','1989-09-12','Malaysian','Male'),
('PAX017','Đỗ','Thị','Nhung','1996-05-28','Vietnamese','Female'),
('PAX018','Trịnh','Văn','Phong','1987-11-17','Vietnamese','Male'),
('PAX019','Lucas',NULL,'Müller','1994-08-04','German','Male'),
('PAX020','Cao','Thị','Quỳnh','2001-02-22','Vietnamese','Female'),
('PAX021','Võ','Văn','Tân','1982-06-10','Vietnamese','Male'),
('PAX022','Đặng','Thị','Uyên','1990-09-30','Vietnamese','Female'),
('PAX023','Nguyễn','Hoàng','Việt','1977-04-20','Vietnamese','Male'),
('PAX024','Trần','Thị','Xuân','1993-07-15','Vietnamese','Female'),
('PAX025','Michael',NULL,'Brown','1985-01-12','American','Male'),
('PAX026','Sarah','Jane','Wilson','1990-03-28','Australian','Female'),
('PAX027','Park',NULL,'Sung-jin','1988-11-05','Korean','Male'),
('PAX028','Yamamoto',NULL,'Yuki','1995-08-17','Japanese','Female'),
('PAX029','Li',NULL,'Jing','1983-05-22','Chinese','Female'),
('PAX030','Marco',NULL,'Rossi','1979-10-14','Italian','Male'),
('PAX031','Lê','Thị','Yến','1998-02-08','Vietnamese','Female'),
('PAX032','Phạm','Đức','Anh','1986-06-25','Vietnamese','Male'),
('PAX033','Hoàng','Thị','Bảo','1991-12-12','Vietnamese','Female'),
('PAX034','Vũ','Minh','Châu','1984-07-07','Vietnamese','Male'),
('PAX035','James',NULL,'Taylor','1987-04-03','British','Male'),
('PAX036','Anna','Marie','Schmidt','1992-09-19','German','Female'),
('PAX037','Chen',NULL,'Xiao','1981-01-30','Chinese','Male'),
('PAX038','Nguyen','Thi','Dao','1996-05-05','Vietnamese','Female'),
('PAX039','Đinh','Văn','Em','1973-11-28','Vietnamese','Male'),
('PAX040','Ngô','Thị','Phượng','2002-03-16','Vietnamese','Female'),
('PAX041','Ali',NULL,'Hassan','1988-08-08','Singaporean','Male'),
('PAX042','Maria','Clara','Santos','1994-06-14','Filipino','Female'),
('PAX043','Raj',NULL,'Patel','1980-10-25','Indian','Male'),
('PAX044','Nadia',NULL,'Ivanova','1992-02-18','Russian','Female'),
('PAX045','Bùi','Thị','Giang','1987-07-22','Vietnamese','Female'),
('PAX046','Đỗ','Văn','Hiếu','1995-04-11','Vietnamese','Male'),
('PAX047','Trịnh','Thị','Ích','1983-09-03','Vietnamese','Female'),
('PAX048','Lý','Văn','Kiên','1990-12-27','Vietnamese','Male'),
('PAX049','Cao','Thị','Liễu','1997-06-06','Vietnamese','Female'),
('PAX050','Phan','Văn','Mạnh','1985-01-19','Vietnamese','Male'),
('PAX051','David',NULL,'Lee','1979-05-31','American','Male'),
('PAX052','Yuna',NULL,'Cho','1998-08-14','Korean','Female'),
('PAX053','Sato',NULL,'Kenji','1975-12-09','Japanese','Male'),
('PAX054','Fatima',NULL,'Al-Rashid','1989-03-23','Emirati','Female'),
('PAX055','Huỳnh','Thị','Ngân','1993-10-17','Vietnamese','Female'),
('PAX056','Mai','Văn','Oanh','1988-04-04','Vietnamese','Male'),
('PAX057','Nguyễn','Thị','Phúc','2001-07-29','Vietnamese','Female'),
('PAX058','Trần','Đức','Quang','1980-02-13','Vietnamese','Male'),
('PAX059','Oliver',NULL,'Williams','1991-06-06','British','Male'),
('PAX060','Isabelle',NULL,'Laurent','1986-11-21','French','Female'),
('PAX061','Lê','Thị','Rạng','1994-08-08','Vietnamese','Female'),
('PAX062','Phạm','Văn','Sơn','1977-03-15','Vietnamese','Male'),
('PAX063','Zhang',NULL,'Fang','1984-01-01','Chinese','Female'),
('PAX064','Aarav',NULL,'Sharma','1999-09-09','Indian','Male'),
('PAX065','Vũ','Thị','Triều','1996-05-20','Vietnamese','Female'),
('PAX066','Đinh','Văn','Uy','1982-12-12','Vietnamese','Male'),
('PAX067','Thomas',NULL,'Nguyen','1990-07-04','American','Male'),
('PAX068','Yui',NULL,'Tanaka','1995-02-28','Japanese','Female'),
('PAX069','Ngô','Thị','Vân','1978-10-10','Vietnamese','Female'),
('PAX070','Bùi','Văn','Xuyên','1987-06-16','Vietnamese','Male'),
('PAX071','Carlos',NULL,'Mendez','1983-04-07','Mexican','Male'),
('PAX072','Hyun',NULL,'Ji-ho','1993-11-30','Korean','Male'),
('PAX073','Đỗ','Thị','Ý','1989-08-25','Vietnamese','Female'),
('PAX074','Trịnh','Minh','Tuấn','1984-03-18','Vietnamese','Male'),
('PAX075','Natasha',NULL,'Petrova','1991-07-07','Russian','Female'),
('PAX076','Lý','Văn','Phát','1986-09-22','Vietnamese','Male'),
('PAX077','Mohamed',NULL,'Al-Farsi','1978-05-15','Omani','Male'),
('PAX078','Cao','Thị','Diệu','1997-01-14','Vietnamese','Female'),
('PAX079','Phan','Văn','Quyết','1974-11-08','Vietnamese','Male'),
('PAX080','Huỳnh','Thị','Thiên','2002-06-30','Vietnamese','Female');

-- ============================================================
-- 4. PASSENGER EMAIL
-- ============================================================
INSERT INTO Passenger_Email (Passenger_ID, Email) VALUES
('PAX001','nguyenvanan@gmail.com'),
('PAX002','tranthibinh@gmail.com'),('PAX002','binh.tran@company.vn'),
('PAX003','lecuong92@gmail.com'),
('PAX004','phamthidung@yahoo.com'),
('PAX005','john.smith@gmail.com'),('PAX005','jsmith@corp.us'),
('PAX006','emily.johnson@outlook.com'),
('PAX007','tanaka.h@jp.co'),
('PAX008','kimjiyeon97@naver.com'),
('PAX009','hoangminhduc@gmail.com'),
('PAX010','vuthihoa99@gmail.com'),
('PAX011','wangwei@163.com'),
('PAX012','sophie.dubois@gmail.com'),
('PAX013','dinhquochung@gmail.com'),('PAX013','hung.dinh@biz.vn'),
('PAX014','ngothilan@gmail.com'),
('PAX015','buivanminh@gmail.com'),
('PAX016','ahmad.reza@gmail.com'),
('PAX017','dothinhung@gmail.com'),
('PAX018','trinhvanphong@gmail.com'),
('PAX019','lucas.muller@gmail.de'),
('PAX020','caothiquynh@gmail.com'),
('PAX021','vovatran@gmail.com'),
('PAX022','dangthiuyen@gmail.com'),
('PAX023','nguyenhoangviet@gmail.com'),('PAX023','viet.nguyen@work.vn'),
('PAX024','tranthixuan@gmail.com'),
('PAX025','michael.brown@gmail.com'),
('PAX026','sarah.wilson@gmail.com'),('PAX026','swilson@au.net'),
('PAX027','park.sungjin@daum.net'),
('PAX028','yamamoto.yuki@yahoo.co.jp'),
('PAX029','lijing83@qq.com'),
('PAX030','marco.rossi@gmail.it'),
('PAX031','lethiyen98@gmail.com'),
('PAX032','phamducanh@gmail.com'),
('PAX033','hoangbao@gmail.com'),
('PAX034','vuminhchau@gmail.com'),
('PAX035','james.taylor@gmail.co.uk'),
('PAX036','anna.schmidt@gmail.de'),
('PAX037','chenxiao81@163.com'),
('PAX038','nguyenthidao@gmail.com'),
('PAX039','dinhvanem@gmail.com'),
('PAX040','ngothiphuong@gmail.com'),
('PAX041','ali.hassan@gmail.sg'),
('PAX042','maria.santos@gmail.ph'),
('PAX043','raj.patel@gmail.in'),
('PAX044','nadia.ivanova@mail.ru'),
('PAX045','buithigiang@gmail.com'),
('PAX046','dovanhieu@gmail.com'),
('PAX047','trinhthi-ich@gmail.com'),
('PAX048','lyvankien@gmail.com'),
('PAX049','caothilieu@gmail.com'),
('PAX050','phanvanmanh@gmail.com'),
('PAX051','david.lee@gmail.com'),('PAX051','dlee@corp.us'),
('PAX052','yunach@naver.com'),
('PAX053','sato.kenji@yahoo.co.jp'),
('PAX054','fatima.alrashid@gmail.ae'),
('PAX055','huynhthingan@gmail.com'),
('PAX056','maivanoanh@gmail.com'),
('PAX057','nguyenthiphuc@gmail.com'),
('PAX058','tranducquang@gmail.com'),
('PAX059','oliver.williams@gmail.co.uk'),
('PAX060','isabelle.laurent@gmail.fr'),
('PAX061','lethirang@gmail.com'),
('PAX062','phamvanson@gmail.com'),
('PAX063','zhangfang@163.com'),
('PAX064','aarav.sharma@gmail.in'),
('PAX065','vuthitrieu@gmail.com'),
('PAX066','dinhvanuy@gmail.com'),
('PAX067','thomas.nguyen@gmail.com'),
('PAX068','yui.tanaka@yahoo.co.jp'),
('PAX069','ngothivan@gmail.com'),
('PAX070','buivanxuyen@gmail.com'),
('PAX071','carlos.mendez@gmail.mx'),
('PAX072','hyun.jiho@daum.net'),
('PAX073','dothiy@gmail.com'),
('PAX074','trinhminhtuan@gmail.com'),
('PAX075','natasha.petrova@mail.ru'),
('PAX076','lyvanphat@gmail.com'),
('PAX077','mohamed.alfarsi@gmail.om'),
('PAX078','caothidieu@gmail.com'),
('PAX079','phanvanquyet@gmail.com'),
('PAX080','huynhthithien@gmail.com');

-- ============================================================
-- 5. PASSENGER PHONE
-- ============================================================
INSERT INTO Passenger_Phone (Passenger_ID, Phone_Number) VALUES
('PAX001','0901234567'),
('PAX002','0912345678'),('PAX002','0287654321'),
('PAX003','0923456789'),
('PAX004','0934567890'),
('PAX005','+14155550101'),
('PAX006','+447911123456'),
('PAX007','+819012345678'),
('PAX008','+821012345678'),
('PAX009','0945678901'),
('PAX010','0956789012'),
('PAX011','+8613812345678'),
('PAX012','+33612345678'),
('PAX013','0967890123'),
('PAX014','0978901234'),
('PAX015','0989012345'),
('PAX016','+60123456789'),
('PAX017','0990123456'),
('PAX018','0901234568'),
('PAX019','+4915123456789'),
('PAX020','0912345679'),
('PAX021','0913456780'),
('PAX022','0924567891'),
('PAX023','0935678902'),('PAX023','0286543210'),
('PAX024','0946789013'),
('PAX025','+12125550102'),
('PAX026','+61412345678'),
('PAX027','+821198765432'),
('PAX028','+819087654321'),
('PAX029','+8613987654321'),
('PAX030','+393331234567'),
('PAX031','0957890124'),
('PAX032','0968901235'),
('PAX033','0979012346'),
('PAX034','0980123457'),
('PAX035','+447700900001'),
('PAX036','+4915209876543'),
('PAX037','+8613700000001'),
('PAX038','0901111222'),
('PAX039','0912222333'),
('PAX040','0923333444'),
('PAX041','+6591234567'),
('PAX042','+639171234567'),
('PAX043','+919876543210'),
('PAX044','+79161234567'),
('PAX045','0934444555'),
('PAX046','0945555666'),
('PAX047','0956666777'),
('PAX048','0967777888'),
('PAX049','0978888999'),
('PAX050','0989999000'),
('PAX051','+13235550103'),
('PAX052','+82109876543'),
('PAX053','+819011111111'),
('PAX054','+971501234567'),
('PAX055','0901122334'),
('PAX056','0912233445'),
('PAX057','0923344556'),
('PAX058','0934455667'),
('PAX059','+447911000001'),
('PAX060','+33698765432'),
('PAX061','0945566778'),
('PAX062','0956677889'),
('PAX063','+8618800000001'),
('PAX064','+919000000001'),
('PAX065','0967788990'),
('PAX066','0978899001'),
('PAX067','+14085550104'),
('PAX068','+819022222222'),
('PAX069','0989900112'),
('PAX070','0900011223'),
('PAX071','+5215512345678'),
('PAX072','+821034567890'),
('PAX073','0911122334'),
('PAX074','0922233445'),
('PAX075','+79261234567'),
('PAX076','0933344556'),
('PAX077','+96891234567'),
('PAX078','0944455667'),
('PAX079','0955566778'),
('PAX080','0966677889');

-- ============================================================
-- 6. FLIGHT (60 records) — 3 ngày: 01, 02, 03 June 2025
-- ============================================================
INSERT INTO Flight VALUES
-- ==== NGÀY 01/06/2025 ====
-- T1 Nội địa
('FL001','VN123','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-01 06:00:00','2025-06-01 06:05:00','2025-06-01 08:10:00','2025-06-01 08:15:00','Completed','AC001'),
('FL002','VJ234','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-01 07:30:00','2025-06-01 07:35:00','2025-06-01 09:00:00','2025-06-01 09:05:00','Completed','AC003'),
('FL003','QH345','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-01 09:00:00','2025-06-01 09:10:00','2025-06-01 10:05:00','2025-06-01 10:20:00','Completed','AC010'),
('FL004','VN456','Tan Son Nhat (SGN)','Cam Ranh (CXR)','2025-06-01 11:00:00','2025-06-01 11:00:00','2025-06-01 12:10:00','2025-06-01 12:10:00','Completed','AC004'),
('FL005','VJ567','Noi Bai (HAN)','Tan Son Nhat (SGN)','2025-06-01 14:00:00','2025-06-01 14:15:00','2025-06-01 16:10:00','2025-06-01 16:30:00','Completed','AC002'),
-- T2 Quốc tế
('FL006','VN001','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-01 08:00:00','2025-06-01 08:05:00','2025-06-01 15:30:00','2025-06-01 15:35:00','Completed','AC007'),
('FL007','VN011','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-01 10:30:00','2025-06-01 10:30:00','2025-06-01 17:45:00','2025-06-01 17:45:00','Completed','AC009'),
('FL008','QR560','Tan Son Nhat (SGN)','Doha (DOH)','2025-06-01 23:55:00',NULL,'2025-06-02 05:30:00',NULL,'Scheduled','AC014'),
('FL009','SQ185','Tan Son Nhat (SGN)','Changi (SIN)','2025-06-01 13:00:00','2025-06-01 13:05:00','2025-06-01 16:25:00','2025-06-01 16:30:00','Completed','AC008'),
('FL010','CX761','Tan Son Nhat (SGN)','Hong Kong (HKG)','2025-06-01 15:45:00','2025-06-01 15:50:00','2025-06-01 19:30:00','2025-06-01 19:35:00','Completed','AC005'),
-- T3 Nội địa mới
('FL011','VN789','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-01 06:30:00','2025-06-01 06:30:00','2025-06-01 08:40:00','2025-06-01 08:40:00','Completed','AC015'),
('FL012','VJ890','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-01 08:00:00','2025-06-01 08:10:00','2025-06-01 09:30:00','2025-06-01 09:45:00','Completed','AC006'),
('FL013','VN321','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-01 10:00:00',NULL,'2025-06-01 11:20:00',NULL,'Cancelled','AC011'),
('FL014','VJ432','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-01 12:30:00','2025-06-01 12:45:00','2025-06-01 13:35:00','2025-06-01 13:50:00','Completed','AC003'),
('FL015','QH543','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-01 16:00:00','2025-06-01 16:00:00','2025-06-01 16:50:00','2025-06-01 16:50:00','Completed','AC010'),
-- ==== NGÀY 02/06/2025 ====
-- T1 Nội địa
('FL016','VN124','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-02 06:00:00','2025-06-02 06:08:00','2025-06-02 08:10:00','2025-06-02 08:20:00','Completed','AC027'),
('FL017','VJ235','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-02 07:30:00','2025-06-02 07:30:00','2025-06-02 09:00:00','2025-06-02 09:00:00','Completed','AC028'),
('FL018','QH346','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-02 09:00:00','2025-06-02 09:05:00','2025-06-02 10:05:00','2025-06-02 10:10:00','Completed','AC025'),
('FL019','VN457','Tan Son Nhat (SGN)','Buon Ma Thuot (BMV)','2025-06-02 11:00:00','2025-06-02 11:15:00','2025-06-02 12:10:00','2025-06-02 12:25:00','Completed','AC031'),
('FL020','VJ568','Da Nang (DAD)','Tan Son Nhat (SGN)','2025-06-02 14:00:00','2025-06-02 14:00:00','2025-06-02 15:30:00','2025-06-02 15:30:00','Completed','AC029'),
-- T2 Quốc tế
('FL021','VN002','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-02 08:00:00','2025-06-02 08:00:00','2025-06-02 15:30:00','2025-06-02 15:30:00','Completed','AC021'),
('FL022','KE684','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-02 10:30:00','2025-06-02 10:45:00','2025-06-02 17:45:00','2025-06-02 18:00:00','Completed','AC023'),
('FL023','EK393','Tan Son Nhat (SGN)','Dubai (DXB)','2025-06-02 01:00:00','2025-06-02 01:00:00','2025-06-02 07:00:00','2025-06-02 07:00:00','Completed','AC033'),
('FL024','TG556','Tan Son Nhat (SGN)','Bangkok (BKK)','2025-06-02 12:30:00','2025-06-02 12:35:00','2025-06-02 14:00:00','2025-06-02 14:05:00','Completed','AC008'),
('FL025','MH751','Tan Son Nhat (SGN)','Kuala Lumpur (KUL)','2025-06-02 16:00:00','2025-06-02 16:00:00','2025-06-02 18:30:00','2025-06-02 18:30:00','Completed','AC005'),
-- T3 Nội địa mới
('FL026','VN790','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-02 06:30:00','2025-06-02 06:40:00','2025-06-02 08:40:00','2025-06-02 08:50:00','Completed','AC035'),
('FL027','VJ891','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-02 08:00:00','2025-06-02 08:00:00','2025-06-02 09:30:00','2025-06-02 09:30:00','Completed','AC036'),
('FL028','VN322','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-02 10:00:00','2025-06-02 10:00:00','2025-06-02 11:20:00','2025-06-02 11:20:00','Completed','AC039'),
('FL029','VJ433','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-02 12:30:00','2025-06-02 12:30:00','2025-06-02 13:35:00','2025-06-02 13:35:00','Completed','AC032'),
('FL030','QH544','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-02 17:00:00',NULL,'2025-06-02 17:50:00',NULL,'Cancelled','AC047'),
-- ==== NGÀY 03/06/2025 ====
-- T1 Nội địa
('FL031','VN125','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-03 06:00:00','2025-06-03 06:00:00','2025-06-03 08:10:00','2025-06-03 08:10:00','Completed','AC057'),
('FL032','VJ236','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-03 07:30:00','2025-06-03 07:45:00','2025-06-03 09:00:00','2025-06-03 09:15:00','Completed','AC058'),
('FL033','QH347','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-03 09:00:00','2025-06-03 09:00:00','2025-06-03 10:05:00','2025-06-03 10:05:00','Completed','AC056'),
('FL034','VN458','Tan Son Nhat (SGN)','Cam Ranh (CXR)','2025-06-03 11:00:00','2025-06-03 11:20:00','2025-06-03 12:10:00','2025-06-03 12:30:00','Completed','AC031'),
('FL035','VJ569','Noi Bai (HAN)','Tan Son Nhat (SGN)','2025-06-03 15:00:00','2025-06-03 15:00:00','2025-06-03 17:10:00','2025-06-03 17:10:00','Completed','AC030'),
-- T2 Quốc tế
('FL036','VN003','Tan Son Nhat (SGN)','Narita (NRT)','2025-06-03 08:00:00','2025-06-03 08:10:00','2025-06-03 15:30:00','2025-06-03 15:40:00','Completed','AC041'),
('FL037','OZ733','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-03 10:30:00','2025-06-03 10:30:00','2025-06-03 17:45:00','2025-06-03 17:45:00','Completed','AC043'),
('FL038','GA867','Tan Son Nhat (SGN)','Bali (DPS)','2025-06-03 09:30:00','2025-06-03 09:45:00','2025-06-03 13:00:00','2025-06-03 13:15:00','Completed','AC009'),
('FL039','AF257','Tan Son Nhat (SGN)','Paris (CDG)','2025-06-03 22:30:00',NULL,'2025-06-04 06:30:00',NULL,'Scheduled','AC044'),
('FL040','LH770','Tan Son Nhat (SGN)','Frankfurt (FRA)','2025-06-03 20:00:00','2025-06-03 20:00:00','2025-06-04 03:00:00','2025-06-04 03:00:00','Completed','AC054'),
-- T3 Nội địa mới
('FL041','VN791','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-03 06:30:00','2025-06-03 06:30:00','2025-06-03 08:40:00','2025-06-03 08:40:00','Completed','AC059'),
('FL042','VJ892','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-03 08:00:00','2025-06-03 08:05:00','2025-06-03 09:30:00','2025-06-03 09:35:00','Completed','AC060'),
('FL043','VN323','Tan Son Nhat (SGN)','Hue (HUI)','2025-06-03 10:00:00','2025-06-03 10:15:00','2025-06-03 11:20:00','2025-06-03 11:35:00','Completed','AC051'),
('FL044','VJ434','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-03 12:30:00','2025-06-03 12:30:00','2025-06-03 13:35:00','2025-06-03 13:35:00','Completed','AC052'),
('FL045','QH545','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-03 16:00:00','2025-06-03 16:10:00','2025-06-03 16:50:00','2025-06-03 17:00:00','Completed','AC053'),
-- ==== NGÀY 04/06/2025 ====
-- T1
('FL046','VN126','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-04 06:00:00','2025-06-04 06:00:00','2025-06-04 08:10:00','2025-06-04 08:10:00','Completed','AC001'),
('FL047','VJ237','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-04 08:00:00','2025-06-04 08:00:00','2025-06-04 09:30:00','2025-06-04 09:30:00','Completed','AC004'),
('FL048','QH348','Tan Son Nhat (SGN)','Buon Ma Thuot (BMV)','2025-06-04 10:00:00','2025-06-04 10:05:00','2025-06-04 11:10:00','2025-06-04 11:15:00','Completed','AC025'),
-- T2
('FL049','VN012','Tan Son Nhat (SGN)','Beijing (PEK)','2025-06-04 09:00:00','2025-06-04 09:00:00','2025-06-04 14:30:00','2025-06-04 14:30:00','Completed','AC022'),
('FL050','TG557','Tan Son Nhat (SGN)','Bangkok (BKK)','2025-06-04 14:00:00','2025-06-04 14:20:00','2025-06-04 15:30:00','2025-06-04 15:50:00','Completed','AC006'),
-- T3
('FL051','VN792','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-04 06:30:00','2025-06-04 06:30:00','2025-06-04 08:40:00','2025-06-04 08:40:00','Completed','AC035'),
('FL052','VJ893','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-04 09:00:00','2025-06-04 09:10:00','2025-06-04 10:30:00','2025-06-04 10:45:00','Completed','AC053'),
('FL053','VN324','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-04 13:00:00','2025-06-04 13:00:00','2025-06-04 13:50:00','2025-06-04 13:50:00','Completed','AC045'),
-- ==== NGÀY 05/06/2025 ====
-- T1
('FL054','VN127','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-05 06:00:00','2025-06-05 06:10:00','2025-06-05 08:10:00','2025-06-05 08:25:00','Completed','AC002'),
('FL055','VJ238','Tan Son Nhat (SGN)','Da Nang (DAD)','2025-06-05 08:00:00','2025-06-05 08:00:00','2025-06-05 09:30:00','2025-06-05 09:30:00','Completed','AC003'),
-- T2
('FL056','VN013','Tan Son Nhat (SGN)','Incheon (ICN)','2025-06-05 11:00:00','2025-06-05 11:00:00','2025-06-05 18:15:00','2025-06-05 18:15:00','Completed','AC024'),
('FL057','MH752','Tan Son Nhat (SGN)','Kuala Lumpur (KUL)','2025-06-05 16:30:00','2025-06-05 16:30:00','2025-06-05 19:00:00','2025-06-05 19:00:00','Completed','AC007'),
-- T3
('FL058','VN793','Tan Son Nhat (SGN)','Noi Bai (HAN)','2025-06-05 07:00:00','2025-06-05 07:00:00','2025-06-05 09:10:00','2025-06-05 09:10:00','Completed','AC051'),
('FL059','VJ894','Tan Son Nhat (SGN)','Phu Quoc (PQC)','2025-06-05 10:00:00','2025-06-05 10:10:00','2025-06-05 11:05:00','2025-06-05 11:20:00','Completed','AC052'),
('FL060','QH549','Tan Son Nhat (SGN)','Can Tho (VCA)','2025-06-05 15:00:00',NULL,'2025-06-05 15:50:00',NULL,'Cancelled','AC048');

-- ============================================================
-- 7. CREW_FLIGHT
-- ============================================================
INSERT INTO Crew_Flight VALUES
-- FL001
('FL001','EMP001','Captain'),('FL001','EMP005','First Officer'),('FL001','EMP008','Lead Flight Attendant'),('FL001','EMP009','Flight Attendant'),
-- FL002
('FL002','EMP002','Captain'),('FL002','EMP006','First Officer'),('FL002','EMP010','Lead Flight Attendant'),
-- FL003
('FL003','EMP003','Captain'),('FL003','EMP007','First Officer'),('FL003','EMP011','Flight Attendant'),
-- FL004
('FL004','EMP004','Captain'),('FL004','EMP025','First Officer'),('FL004','EMP012','Flight Attendant'),
-- FL005
('FL005','EMP021','Captain'),('FL005','EMP026','First Officer'),('FL005','EMP013','Flight Attendant'),
-- FL006 (quốc tế, thêm FA)
('FL006','EMP022','Captain'),('FL006','EMP027','First Officer'),('FL006','EMP029','Lead Flight Attendant'),('FL006','EMP030','Flight Attendant'),('FL006','EMP031','Flight Attendant'),
-- FL007
('FL007','EMP023','Captain'),('FL007','EMP028','First Officer'),('FL007','EMP032','Lead Flight Attendant'),('FL007','EMP033','Flight Attendant'),
-- FL008
('FL008','EMP024','Captain'),('FL008','EMP054','First Officer'),('FL008','EMP057','Lead Flight Attendant'),('FL008','EMP058','Flight Attendant'),('FL008','EMP059','Flight Attendant'),
-- FL009
('FL009','EMP051','Captain'),('FL009','EMP055','First Officer'),('FL009','EMP034','Lead Flight Attendant'),('FL009','EMP035','Flight Attendant'),
-- FL010
('FL010','EMP052','Captain'),('FL010','EMP056','First Officer'),('FL010','EMP036','Flight Attendant'),
-- FL011
('FL011','EMP053','Captain'),('FL011','EMP077','First Officer'),('FL011','EMP078','Lead Flight Attendant'),('FL011','EMP079','Flight Attendant'),
-- FL012
('FL012','EMP075','Captain'),('FL012','EMP025','First Officer'),('FL012','EMP080','Flight Attendant'),
-- FL013 (cancelled)
('FL013','EMP076','Captain'),('FL013','EMP026','First Officer'),
-- FL014
('FL014','EMP001','Captain'),('FL014','EMP027','First Officer'),('FL014','EMP060','Flight Attendant'),
-- FL015
('FL015','EMP002','Captain'),('FL015','EMP028','First Officer'),('FL015','EMP008','Flight Attendant'),
-- FL016
('FL016','EMP003','Captain'),('FL016','EMP005','First Officer'),('FL016','EMP009','Lead Flight Attendant'),('FL016','EMP010','Flight Attendant'),
-- FL017
('FL017','EMP004','Captain'),('FL017','EMP006','First Officer'),('FL017','EMP011','Flight Attendant'),
-- FL018
('FL018','EMP021','Captain'),('FL018','EMP007','First Officer'),('FL018','EMP012','Flight Attendant'),
-- FL019
('FL019','EMP022','Captain'),('FL019','EMP025','First Officer'),('FL019','EMP013','Flight Attendant'),
-- FL020
('FL020','EMP023','Captain'),('FL020','EMP026','First Officer'),('FL020','EMP029','Flight Attendant'),
-- FL021 (quốc tế)
('FL021','EMP024','Captain'),('FL021','EMP027','First Officer'),('FL021','EMP030','Lead Flight Attendant'),('FL021','EMP031','Flight Attendant'),('FL021','EMP032','Flight Attendant'),
-- FL022
('FL022','EMP051','Captain'),('FL022','EMP028','First Officer'),('FL022','EMP033','Lead Flight Attendant'),('FL022','EMP034','Flight Attendant'),
-- FL023
('FL023','EMP052','Captain'),('FL023','EMP054','First Officer'),('FL023','EMP057','Lead Flight Attendant'),('FL023','EMP058','Flight Attendant'),('FL023','EMP059','Flight Attendant'),
-- FL024
('FL024','EMP053','Captain'),('FL024','EMP055','First Officer'),('FL024','EMP035','Flight Attendant'),
-- FL025
('FL025','EMP075','Captain'),('FL025','EMP056','First Officer'),('FL025','EMP036','Flight Attendant'),
-- FL026
('FL026','EMP076','Captain'),('FL026','EMP077','First Officer'),('FL026','EMP060','Lead Flight Attendant'),('FL026','EMP078','Flight Attendant'),
-- FL027
('FL027','EMP001','Captain'),('FL027','EMP005','First Officer'),('FL027','EMP079','Flight Attendant'),
-- FL028
('FL028','EMP002','Captain'),('FL028','EMP006','First Officer'),('FL028','EMP080','Flight Attendant'),
-- FL029
('FL029','EMP003','Captain'),('FL029','EMP007','First Officer'),('FL029','EMP008','Flight Attendant'),
-- FL030 (cancelled)
('FL030','EMP004','Captain'),('FL030','EMP025','First Officer'),
-- FL031
('FL031','EMP021','Captain'),('FL031','EMP026','First Officer'),('FL031','EMP009','Lead Flight Attendant'),('FL031','EMP010','Flight Attendant'),
-- FL032
('FL032','EMP022','Captain'),('FL032','EMP027','First Officer'),('FL032','EMP011','Flight Attendant'),
-- FL033
('FL033','EMP023','Captain'),('FL033','EMP028','First Officer'),('FL033','EMP012','Flight Attendant'),
-- FL034
('FL034','EMP024','Captain'),('FL034','EMP054','First Officer'),('FL034','EMP013','Flight Attendant'),
-- FL035
('FL035','EMP051','Captain'),('FL035','EMP055','First Officer'),('FL035','EMP029','Flight Attendant'),
-- FL036 (quốc tế)
('FL036','EMP052','Captain'),('FL036','EMP056','First Officer'),('FL036','EMP030','Lead Flight Attendant'),('FL036','EMP031','Flight Attendant'),('FL036','EMP032','Flight Attendant'),
-- FL037
('FL037','EMP053','Captain'),('FL037','EMP077','First Officer'),('FL037','EMP033','Lead Flight Attendant'),('FL037','EMP034','Flight Attendant'),
-- FL038
('FL038','EMP075','Captain'),('FL038','EMP025','First Officer'),('FL038','EMP035','Lead Flight Attendant'),('FL038','EMP036','Flight Attendant'),
-- FL039 (scheduled)
('FL039','EMP076','Captain'),('FL039','EMP026','First Officer'),('FL039','EMP057','Lead Flight Attendant'),('FL039','EMP058','Flight Attendant'),('FL039','EMP059','Flight Attendant'),
-- FL040
('FL040','EMP001','Captain'),('FL040','EMP027','First Officer'),('FL040','EMP060','Lead Flight Attendant'),('FL040','EMP078','Flight Attendant'),
-- FL041
('FL041','EMP002','Captain'),('FL041','EMP028','First Officer'),('FL041','EMP079','Lead Flight Attendant'),('FL041','EMP080','Flight Attendant'),
-- FL042
('FL042','EMP003','Captain'),('FL042','EMP005','First Officer'),('FL042','EMP008','Flight Attendant'),
-- FL043
('FL043','EMP004','Captain'),('FL043','EMP006','First Officer'),('FL043','EMP009','Flight Attendant'),
-- FL044
('FL044','EMP021','Captain'),('FL044','EMP007','First Officer'),('FL044','EMP010','Flight Attendant'),
-- FL045
('FL045','EMP022','Captain'),('FL045','EMP025','First Officer'),('FL045','EMP011','Flight Attendant'),
-- FL046
('FL046','EMP023','Captain'),('FL046','EMP026','First Officer'),('FL046','EMP012','Lead Flight Attendant'),('FL046','EMP013','Flight Attendant'),
-- FL047
('FL047','EMP024','Captain'),('FL047','EMP027','First Officer'),('FL047','EMP029','Flight Attendant'),
-- FL048
('FL048','EMP051','Captain'),('FL048','EMP028','First Officer'),('FL048','EMP030','Flight Attendant'),
-- FL049 (quốc tế)
('FL049','EMP052','Captain'),('FL049','EMP054','First Officer'),('FL049','EMP031','Lead Flight Attendant'),('FL049','EMP032','Flight Attendant'),('FL049','EMP033','Flight Attendant'),
-- FL050
('FL050','EMP053','Captain'),('FL050','EMP055','First Officer'),('FL050','EMP034','Flight Attendant'),
-- FL051
('FL051','EMP075','Captain'),('FL051','EMP056','First Officer'),('FL051','EMP035','Lead Flight Attendant'),('FL051','EMP036','Flight Attendant'),
-- FL052
('FL052','EMP076','Captain'),('FL052','EMP077','First Officer'),('FL052','EMP060','Flight Attendant'),
-- FL053
('FL053','EMP001','Captain'),('FL053','EMP005','First Officer'),('FL053','EMP057','Flight Attendant'),
-- FL054
('FL054','EMP002','Captain'),('FL054','EMP006','First Officer'),('FL054','EMP058','Lead Flight Attendant'),('FL054','EMP059','Flight Attendant'),
-- FL055
('FL055','EMP003','Captain'),('FL055','EMP007','First Officer'),('FL055','EMP078','Flight Attendant'),
-- FL056 (quốc tế)
('FL056','EMP004','Captain'),('FL056','EMP025','First Officer'),('FL056','EMP079','Lead Flight Attendant'),('FL056','EMP080','Flight Attendant'),('FL056','EMP008','Flight Attendant'),
-- FL057
('FL057','EMP021','Captain'),('FL057','EMP026','First Officer'),('FL057','EMP009','Lead Flight Attendant'),('FL057','EMP010','Flight Attendant'),
-- FL058
('FL058','EMP022','Captain'),('FL058','EMP027','First Officer'),('FL058','EMP011','Lead Flight Attendant'),('FL058','EMP013','Flight Attendant'),
-- FL059
('FL059','EMP023','Captain'),('FL059','EMP028','First Officer'),('FL059','EMP012','Flight Attendant'),
-- FL060 (cancelled)
('FL060','EMP024','Captain'),('FL060','EMP054','First Officer');

-- ============================================================
-- 8. TICKET (80 records)
-- ============================================================
INSERT INTO Ticket VALUES
-- FL001 VN123 SGN→HAN T1
('TK001','T1','12A','Business',2500000.00,'2025-05-20 10:00:00','PAX001','FL001'),
('TK002','T1','23B','Economy',1200000.00,'2025-05-21 14:00:00','PAX002','FL001'),
('TK003','T1','24C','Economy',1200000.00,'2025-05-22 09:00:00','PAX003','FL001'),
-- FL002 VJ234 SGN→DAD T1
('TK004','T1','10D','Economy',900000.00,'2025-05-18 08:00:00','PAX004','FL002'),
('TK005','T1','11E','Economy',900000.00,'2025-05-19 11:00:00','PAX009','FL002'),
-- FL003 QH345 SGN→PQC T1
('TK006','T1','5A','Economy',1100000.00,'2025-05-25 07:30:00','PAX010','FL003'),
('TK007','T1','5B','Economy',1100000.00,'2025-05-26 10:00:00','PAX013','FL003'),
-- FL006 VN001 SGN→NRT T2
('TK008','T2','8A','Business',12000000.00,'2025-05-10 09:00:00','PAX005','FL006'),
('TK009','T2','9B','Business',12000000.00,'2025-05-12 13:00:00','PAX007','FL006'),
('TK010','T2','25C','Economy',5500000.00,'2025-05-15 16:00:00','PAX011','FL006'),
-- FL007 VN011 SGN→ICN T2
('TK011','T2','7A','Business',11000000.00,'2025-05-14 10:00:00','PAX008','FL007'),
('TK012','T2','28D','Economy',4800000.00,'2025-05-16 08:00:00','PAX012','FL007'),
-- FL009 SQ185 SGN→SIN T2
('TK013','T2','15C','Economy',3200000.00,'2025-05-22 11:00:00','PAX015','FL009'),
('TK014','T2','16D','Economy',3200000.00,'2025-05-23 09:30:00','PAX016','FL009'),
-- FL010 CX761 SGN→HKG T2
('TK015','T2','6B','Business',9500000.00,'2025-05-11 14:00:00','PAX019','FL010'),
-- FL011 VN789 SGN→HAN T3
('TK016','T3','14A','Economy',1300000.00,'2025-05-23 10:00:00','PAX014','FL011'),
('TK017','T3','15B','Economy',1300000.00,'2025-05-24 12:00:00','PAX017','FL011'),
-- FL012 VJ890 SGN→DAD T3
('TK018','T3','20C','Economy',850000.00,'2025-05-25 15:00:00','PAX018','FL012'),
('TK019','T3','21D','Economy',850000.00,'2025-05-26 09:00:00','PAX020','FL012'),
-- FL014 VJ432 SGN→PQC T3
('TK020','T3','9C','Economy',1050000.00,'2025-05-27 08:00:00','PAX006','FL014'),
-- FL016 VN124 SGN→HAN T1
('TK021','T1','13A','Business',2500000.00,'2025-05-25 10:00:00','PAX021','FL016'),
('TK022','T1','25B','Economy',1200000.00,'2025-05-26 14:00:00','PAX022','FL016'),
-- FL017 VJ235 SGN→DAD T1
('TK023','T1','10A','Economy',900000.00,'2025-05-23 08:00:00','PAX023','FL017'),
('TK024','T1','11B','Economy',900000.00,'2025-05-24 11:00:00','PAX024','FL017'),
-- FL018 QH346 SGN→PQC T1
('TK025','T1','6A','Economy',1100000.00,'2025-05-28 07:30:00','PAX031','FL018'),
-- FL021 VN002 SGN→NRT T2
('TK026','T2','8A','Business',12000000.00,'2025-05-15 09:00:00','PAX025','FL021'),
('TK027','T2','9B','Business',12000000.00,'2025-05-17 13:00:00','PAX027','FL021'),
('TK028','T2','26C','Economy',5500000.00,'2025-05-20 16:00:00','PAX029','FL021'),
-- FL022 KE684 SGN→ICN T2
('TK029','T2','7A','Business',11000000.00,'2025-05-18 10:00:00','PAX028','FL022'),
('TK030','T2','29D','Economy',4800000.00,'2025-05-20 08:00:00','PAX032','FL022'),
-- FL023 EK393 SGN→DXB T2
('TK031','T2','5C','Business',15000000.00,'2025-05-10 10:00:00','PAX035','FL023'),
('TK032','T2','30E','Economy',7000000.00,'2025-05-12 15:00:00','PAX036','FL023'),
-- FL024 TG556 SGN→BKK T2
('TK033','T2','12A','Economy',2500000.00,'2025-05-24 09:00:00','PAX037','FL024'),
('TK034','T2','13B','Economy',2500000.00,'2025-05-25 11:00:00','PAX040','FL024'),
-- FL025 MH751 SGN→KUL T2
('TK035','T2','14C','Economy',3000000.00,'2025-05-26 14:00:00','PAX041','FL025'),
-- FL026 VN790 SGN→HAN T3
('TK036','T3','15A','Economy',1300000.00,'2025-05-27 10:00:00','PAX033','FL026'),
('TK037','T3','16B','Economy',1300000.00,'2025-05-28 12:00:00','PAX034','FL026'),
-- FL027 VJ891 SGN→DAD T3
('TK038','T3','22C','Economy',850000.00,'2025-05-29 15:00:00','PAX038','FL027'),
('TK039','T3','23D','Economy',850000.00,'2025-05-30 09:00:00','PAX039','FL027'),
-- FL028 VN322 SGN→HUI T3
('TK040','T3','10A','Economy',950000.00,'2025-05-29 08:00:00','PAX043','FL028'),
-- FL031 VN125 SGN→HAN T1
('TK041','T1','14A','Business',2600000.00,'2025-05-28 10:00:00','PAX044','FL031'),
('TK042','T1','26B','Economy',1250000.00,'2025-05-29 14:00:00','PAX045','FL031'),
-- FL032 VJ236 SGN→DAD T1
('TK043','T1','11A','Economy',920000.00,'2025-05-27 08:00:00','PAX046','FL032'),
('TK044','T1','12B','Economy',920000.00,'2025-05-28 11:00:00','PAX047','FL032'),
-- FL033 QH347 SGN→PQC T1
('TK045','T1','7A','Economy',1100000.00,'2025-05-30 07:30:00','PAX048','FL033'),
-- FL036 VN003 SGN→NRT T2
('TK046','T2','9A','Business',12000000.00,'2025-05-18 09:00:00','PAX049','FL036'),
('TK047','T2','10B','Business',12000000.00,'2025-05-20 13:00:00','PAX051','FL036'),
('TK048','T2','27C','Economy',5500000.00,'2025-05-22 16:00:00','PAX053','FL036'),
-- FL037 OZ733 SGN→ICN T2
('TK049','T2','8A','Business',11000000.00,'2025-05-20 10:00:00','PAX052','FL037'),
('TK050','T2','30D','Economy',4800000.00,'2025-05-22 08:00:00','PAX054','FL037'),
-- FL038 GA867 SGN→DPS T2
('TK051','T2','15A','Economy',4000000.00,'2025-05-25 09:00:00','PAX055','FL038'),
('TK052','T2','16B','Economy',4000000.00,'2025-05-26 11:00:00','PAX056','FL038'),
-- FL040 LH770 SGN→FRA T2
('TK053','T2','6C','Business',18000000.00,'2025-05-12 14:00:00','PAX059','FL040'),
('TK054','T2','31D','Economy',8500000.00,'2025-05-14 16:00:00','PAX060','FL040'),
-- FL041 VN791 SGN→HAN T3
('TK055','T3','16A','Economy',1300000.00,'2025-05-29 10:00:00','PAX061','FL041'),
('TK056','T3','17B','Economy',1300000.00,'2025-05-30 12:00:00','PAX062','FL041'),
-- FL042 VJ892 SGN→DAD T3
('TK057','T3','24C','Economy',870000.00,'2025-05-31 15:00:00','PAX063','FL042'),
('TK058','T3','25D','Economy',870000.00,'2025-06-01 09:00:00','PAX064','FL042'),
-- FL043 VN323 SGN→HUI T3
('TK059','T3','11A','Economy',960000.00,'2025-05-31 08:00:00','PAX065','FL043'),
-- FL046 VN126 SGN→HAN T1
('TK060','T1','15A','Business',2500000.00,'2025-06-01 10:00:00','PAX066','FL046'),
('TK061','T1','27B','Economy',1200000.00,'2025-06-02 14:00:00','PAX067','FL046'),
-- FL047 VJ237 SGN→DAD T1
('TK062','T1','12A','Economy',900000.00,'2025-06-02 08:00:00','PAX068','FL047'),
-- FL049 VN012 SGN→PEK T2
('TK063','T2','10A','Business',13000000.00,'2025-05-20 09:00:00','PAX069','FL049'),
('TK064','T2','11B','Business',13000000.00,'2025-05-22 13:00:00','PAX070','FL049'),
('TK065','T2','28C','Economy',6000000.00,'2025-05-25 16:00:00','PAX071','FL049'),
-- FL050 TG557 SGN→BKK T2
('TK066','T2','13A','Economy',2600000.00,'2025-06-01 09:00:00','PAX072','FL050'),
-- FL051 VN792 SGN→HAN T3
('TK067','T3','17A','Economy',1300000.00,'2025-06-02 10:00:00','PAX073','FL051'),
('TK068','T3','18B','Economy',1300000.00,'2025-06-03 12:00:00','PAX074','FL051'),
-- FL054 VN127 SGN→HAN T1
('TK069','T1','16A','Business',2550000.00,'2025-06-03 10:00:00','PAX075','FL054'),
('TK070','T1','28B','Economy',1220000.00,'2025-06-04 14:00:00','PAX076','FL054'),
-- FL056 VN013 SGN→ICN T2
('TK071','T2','11A','Business',11500000.00,'2025-05-22 10:00:00','PAX077','FL056'),
('TK072','T2','31D','Economy',5000000.00,'2025-05-24 08:00:00','PAX078','FL056'),
-- FL057 MH752 SGN→KUL T2
('TK073','T2','15B','Economy',3000000.00,'2025-06-04 09:00:00','PAX079','FL057'),
-- FL058 VN793 SGN→HAN T3
('TK074','T3','18A','Economy',1300000.00,'2025-06-04 10:00:00','PAX080','FL058'),
-- Extra tickets cho các chuyến nội địa
('TK075','T1','30A','Economy',880000.00,'2025-05-22 08:00:00','PAX026','FL005'),
('TK076','T1','31B','Economy',880000.00,'2025-05-23 11:00:00','PAX030','FL005'),
('TK077','T3','26C','Economy',870000.00,'2025-05-31 09:00:00','PAX042','FL044'),
('TK078','T2','32D','Economy',4200000.00,'2025-05-28 08:00:00','PAX043','FL038'),
('TK079','T1','14C','Economy',1150000.00,'2025-06-02 08:00:00','PAX050','FL019'),
('TK080','T3','19A','Economy',1280000.00,'2025-06-03 10:00:00','PAX058','FL058');

-- ============================================================
-- 9. BOARDING PASS (78 records - không tạo cho FL013, FL030, FL060 vì cancelled)
-- ============================================================
INSERT INTO Boarding_Pass VALUES
('BP001','TK001','2025-06-01 05:20:00','G12'),
('BP002','TK002','2025-06-01 05:25:00','G12'),
('BP003','TK003','2025-06-01 05:30:00','G12'),
('BP004','TK004','2025-06-01 06:50:00','G08'),
('BP005','TK005','2025-06-01 06:55:00','G08'),
('BP006','TK006','2025-06-01 08:15:00','G05'),
('BP007','TK007','2025-06-01 08:20:00','G05'),
('BP008','TK008','2025-06-01 07:00:00','A01'),
('BP009','TK009','2025-06-01 07:05:00','A01'),
('BP010','TK010','2025-06-01 07:10:00','A01'),
('BP011','TK011','2025-06-01 09:30:00','A03'),
('BP012','TK012','2025-06-01 09:35:00','A03'),
('BP013','TK013','2025-06-01 12:00:00','A07'),
('BP014','TK014','2025-06-01 12:05:00','A07'),
('BP015','TK015','2025-06-01 14:45:00','A05'),
('BP016','TK016','2025-06-01 05:30:00','C02'),
('BP017','TK017','2025-06-01 05:35:00','C02'),
('BP018','TK018','2025-06-01 07:00:00','C04'),
('BP019','TK019','2025-06-01 07:05:00','C04'),
('BP020','TK020','2025-06-01 11:30:00','C06'),
('BP021','TK021','2025-06-02 05:20:00','G14'),
('BP022','TK022','2025-06-02 05:25:00','G14'),
('BP023','TK023','2025-06-02 06:50:00','G09'),
('BP024','TK024','2025-06-02 06:55:00','G09'),
('BP025','TK025','2025-06-02 08:15:00','G06'),
('BP026','TK026','2025-06-02 07:00:00','A02'),
('BP027','TK027','2025-06-02 07:05:00','A02'),
('BP028','TK028','2025-06-02 07:10:00','A02'),
('BP029','TK029','2025-06-02 09:30:00','A04'),
('BP030','TK030','2025-06-02 09:35:00','A04'),
('BP031','TK031','2025-06-02 00:10:00','A08'),
('BP032','TK032','2025-06-02 00:15:00','A08'),
('BP033','TK033','2025-06-02 11:45:00','A06'),
('BP034','TK034','2025-06-02 11:50:00','A06'),
('BP035','TK035','2025-06-02 15:15:00','A09'),
('BP036','TK036','2025-06-02 05:30:00','C03'),
('BP037','TK037','2025-06-02 05:35:00','C03'),
('BP038','TK038','2025-06-02 07:15:00','C05'),
('BP039','TK039','2025-06-02 07:20:00','C05'),
('BP040','TK040','2025-06-02 09:15:00','C07'),
('BP041','TK041','2025-06-03 05:20:00','G10'),
('BP042','TK042','2025-06-03 05:25:00','G10'),
('BP043','TK043','2025-06-03 06:45:00','G07'),
('BP044','TK044','2025-06-03 06:50:00','G07'),
('BP045','TK045','2025-06-03 08:15:00','G04'),
('BP046','TK046','2025-06-03 07:00:00','A10'),
('BP047','TK047','2025-06-03 07:05:00','A10'),
('BP048','TK048','2025-06-03 07:10:00','A10'),
('BP049','TK049','2025-06-03 09:30:00','A11'),
('BP050','TK050','2025-06-03 09:35:00','A11'),
('BP051','TK051','2025-06-03 08:45:00','A12'),
('BP052','TK052','2025-06-03 08:50:00','A12'),
('BP053','TK053','2025-06-03 19:15:00','A13'),
('BP054','TK054','2025-06-03 19:20:00','A13'),
('BP055','TK055','2025-06-03 05:30:00','C08'),
('BP056','TK056','2025-06-03 05:35:00','C08'),
('BP057','TK057','2025-06-03 07:15:00','C09'),
('BP058','TK058','2025-06-03 07:20:00','C09'),
('BP059','TK059','2025-06-03 09:15:00','C10'),
('BP060','TK060','2025-06-04 05:20:00','G11'),
('BP061','TK061','2025-06-04 05:25:00','G11'),
('BP062','TK062','2025-06-04 07:15:00','G13'),
('BP063','TK063','2025-06-04 08:15:00','A14'),
('BP064','TK064','2025-06-04 08:20:00','A14'),
('BP065','TK065','2025-06-04 08:25:00','A14'),
('BP066','TK066','2025-06-04 13:15:00','A15'),
('BP067','TK067','2025-06-04 05:30:00','C11'),
('BP068','TK068','2025-06-04 05:35:00','C11'),
('BP069','TK069','2025-06-05 05:20:00','G15'),
('BP070','TK070','2025-06-05 05:25:00','G15'),
('BP071','TK071','2025-06-05 10:15:00','A16'),
('BP072','TK072','2025-06-05 10:20:00','A16'),
('BP073','TK073','2025-06-05 15:45:00','A17'),
('BP074','TK074','2025-06-05 06:15:00','C12'),
('BP075','TK075','2025-06-01 13:15:00','G01'),
('BP076','TK076','2025-06-01 13:20:00','G01'),
('BP077','TK077','2025-06-03 11:30:00','C13'),
('BP078','TK079','2025-06-02 10:15:00','G03');

-- ============================================================
-- 10. LUGGAGE (90 records)
-- ============================================================
INSERT INTO Luggage VALUES
('LG001',22.50,'2025-06-01 05:00:00','Delivered','TK001'),
('LG002',18.00,'2025-06-01 05:05:00','Delivered','TK002'),
('LG003',15.30,'2025-06-01 05:08:00','Delivered','TK003'),
('LG004',20.00,'2025-06-01 06:30:00','Delivered','TK004'),
('LG005',12.50,'2025-06-01 06:35:00','Delivered','TK005'),
('LG006',25.00,'2025-06-01 08:00:00','Delivered','TK006'),
('LG007',10.00,'2025-06-01 08:05:00','Delivered','TK007'),
('LG008',30.00,'2025-06-01 06:45:00','Delivered','TK008'),
('LG009',28.00,'2025-06-01 06:50:00','Delivered','TK009'),
('LG010',19.50,'2025-06-01 06:55:00','Delivered','TK010'),
('LG011',23.00,'2025-06-01 09:20:00','Delivered','TK011'),
('LG012',17.00,'2025-06-01 09:25:00','Delayed','TK012'),
('LG013',21.00,'2025-06-01 11:50:00','Delivered','TK013'),
('LG014',14.50,'2025-06-01 11:55:00','Delivered','TK014'),
('LG015',32.00,'2025-06-01 14:30:00','Delivered','TK015'),
('LG016',16.00,'2025-06-01 05:10:00','Delivered','TK016'),
('LG017',11.00,'2025-06-01 05:15:00','Delivered','TK017'),
('LG018',24.00,'2025-06-01 06:50:00','Delivered','TK018'),
('LG019',9.50,'2025-06-01 06:55:00','Delivered','TK019'),
('LG020',13.00,'2025-06-01 11:15:00','Delivered','TK020'),
('LG021',18.50,'2025-06-01 06:58:00','Lost','TK003'),
('LG022',26.00,'2025-06-01 09:22:00','Delayed','TK012'),
('LG023',20.00,'2025-06-02 05:00:00','Delivered','TK021'),
('LG024',15.00,'2025-06-02 05:05:00','Delivered','TK022'),
('LG025',22.00,'2025-06-02 06:30:00','Delivered','TK023'),
('LG026',18.00,'2025-06-02 06:35:00','Delivered','TK024'),
('LG027',11.50,'2025-06-02 08:00:00','Delivered','TK025'),
('LG028',31.00,'2025-06-02 06:45:00','Delivered','TK026'),
('LG029',29.00,'2025-06-02 06:50:00','Delivered','TK027'),
('LG030',20.50,'2025-06-02 06:55:00','Delivered','TK028'),
('LG031',24.00,'2025-06-02 09:20:00','Delivered','TK029'),
('LG032',16.50,'2025-06-02 09:25:00','Delivered','TK030'),
('LG033',33.00,'2025-06-02 00:05:00','Delivered','TK031'),
('LG034',27.00,'2025-06-02 00:07:00','Delivered','TK032'),
('LG035',14.00,'2025-06-02 11:40:00','Delivered','TK033'),
('LG036',19.00,'2025-06-02 11:45:00','Lost','TK034'),
('LG037',22.50,'2025-06-02 15:10:00','Delivered','TK035'),
('LG038',17.00,'2025-06-02 05:10:00','Delivered','TK036'),
('LG039',12.00,'2025-06-02 05:15:00','Delivered','TK037'),
('LG040',25.00,'2025-06-02 07:05:00','Delivered','TK038'),
('LG041',10.50,'2025-06-02 07:10:00','Delivered','TK039'),
('LG042',16.00,'2025-06-02 09:10:00','Delivered','TK040'),
('LG043',21.00,'2025-06-03 05:00:00','Delivered','TK041'),
('LG044',16.00,'2025-06-03 05:05:00','Delivered','TK042'),
('LG045',23.00,'2025-06-03 06:30:00','Delayed','TK043'),
('LG046',19.00,'2025-06-03 06:35:00','Delivered','TK044'),
('LG047',12.00,'2025-06-03 08:00:00','Delivered','TK045'),
('LG048',32.00,'2025-06-03 06:45:00','Delivered','TK046'),
('LG049',30.00,'2025-06-03 06:50:00','Delivered','TK047'),
('LG050',21.50,'2025-06-03 06:55:00','Delivered','TK048'),
('LG051',25.00,'2025-06-03 09:20:00','Delivered','TK049'),
('LG052',17.50,'2025-06-03 09:25:00','Delivered','TK050'),
('LG053',14.00,'2025-06-03 08:45:00','Delivered','TK051'),
('LG054',20.00,'2025-06-03 08:50:00','Delivered','TK052'),
('LG055',35.00,'2025-06-03 19:10:00','Delivered','TK053'),
('LG056',28.50,'2025-06-03 19:12:00','Delivered','TK054'),
('LG057',17.00,'2025-06-03 05:10:00','Delivered','TK055'),
('LG058',13.00,'2025-06-03 05:15:00','Delivered','TK056'),
('LG059',26.00,'2025-06-03 07:05:00','Delivered','TK057'),
('LG060',11.50,'2025-06-03 07:10:00','Lost','TK058'),
('LG061',17.00,'2025-06-03 09:10:00','Delivered','TK059'),
('LG062',22.00,'2025-06-04 05:00:00','Delivered','TK060'),
('LG063',15.00,'2025-06-04 05:05:00','Delivered','TK061'),
('LG064',20.50,'2025-06-04 07:10:00','Delivered','TK062'),
('LG065',34.00,'2025-06-04 08:10:00','Delivered','TK063'),
('LG066',29.00,'2025-06-04 08:12:00','Delivered','TK064'),
('LG067',23.00,'2025-06-04 08:15:00','Delivered','TK065'),
('LG068',16.00,'2025-06-04 13:10:00','Delivered','TK066'),
('LG069',18.00,'2025-06-04 05:10:00','Delivered','TK067'),
('LG070',14.00,'2025-06-04 05:12:00','Delivered','TK068'),
('LG071',23.50,'2025-06-05 05:00:00','Delivered','TK069'),
('LG072',17.00,'2025-06-05 05:05:00','Delivered','TK070'),
('LG073',36.00,'2025-06-05 10:10:00','Delivered','TK071'),
('LG074',20.00,'2025-06-05 10:12:00','Delivered','TK072'),
('LG075',22.00,'2025-06-05 15:40:00','Delivered','TK073'),
('LG076',15.50,'2025-06-05 06:10:00','Delivered','TK074'),
('LG077',19.00,'2025-06-01 13:10:00','Delivered','TK075'),
('LG078',14.00,'2025-06-01 13:12:00','Delivered','TK076'),
('LG079',21.00,'2025-06-03 11:25:00','Delayed','TK077'),
('LG080',27.00,'2025-06-02 10:10:00','Delivered','TK079'),
-- Một số hành lý bị check-in trễ / vấn đề
('LG081',8.50,'2025-06-02 07:08:00','Delivered','TK039'),
('LG082',30.50,'2025-06-03 06:48:00','Lost','TK043'),
('LG083',13.50,'2025-06-04 08:18:00','Delayed','TK065'),
('LG084',11.00,'2025-06-05 05:08:00','Delivered','TK074'),
('LG085',19.50,'2025-06-01 11:52:00','Delivered','TK013'),
('LG086',24.00,'2025-06-02 06:52:00','Delivered','TK028'),
('LG087',16.50,'2025-06-03 06:52:00','Delivered','TK048'),
('LG088',22.00,'2025-06-04 13:12:00','Delivered','TK066'),
('LG089',18.00,'2025-06-05 10:14:00','Delivered','TK072'),
('LG090',14.50,'2025-06-03 09:12:00','Delivered','TK059');

-- ============================================================
-- 11. SECURITY LOG (80 records)
-- ============================================================
INSERT INTO Security_Log (Passenger_ID, Screen_DateTime, Result, Note) VALUES
('PAX001','2025-06-01 04:45:00','Clear',NULL),
('PAX002','2025-06-01 04:50:00','Clear',NULL),
('PAX003','2025-06-01 04:52:00','Alert','Flagged – secondary screening required'),
('PAX004','2025-06-01 06:20:00','Clear',NULL),
('PAX005','2025-06-01 06:30:00','Clear',NULL),
('PAX006','2025-06-01 11:00:00','Clear',NULL),
('PAX007','2025-06-01 06:35:00','Clear',NULL),
('PAX008','2025-06-01 09:00:00','Clear',NULL),
('PAX009','2025-06-01 06:25:00','Clear',NULL),
('PAX010','2025-06-01 08:00:00','Clear',NULL),
('PAX011','2025-06-01 06:40:00','Alert','Prohibited item detected'),
('PAX012','2025-06-01 09:05:00','Clear',NULL),
('PAX013','2025-06-01 08:05:00','Clear',NULL),
('PAX014','2025-06-01 05:05:00','Clear',NULL),
('PAX015','2025-06-01 11:40:00','Clear',NULL),
('PAX016','2025-06-01 11:45:00','Clear',NULL),
('PAX017','2025-06-01 05:10:00','Clear',NULL),
('PAX018','2025-06-01 06:40:00','Clear',NULL),
('PAX019','2025-06-01 14:30:00','Clear',NULL),
('PAX020','2025-06-01 06:45:00','Alert','Oversized carry-on'),
-- 02/06
('PAX021','2025-06-02 04:45:00','Clear',NULL),
('PAX022','2025-06-02 04:50:00','Clear',NULL),
('PAX023','2025-06-02 06:20:00','Clear',NULL),
('PAX024','2025-06-02 06:25:00','Clear',NULL),
('PAX025','2025-06-02 06:30:00','Clear',NULL),
('PAX026','2025-06-02 13:00:00','Clear',NULL),
('PAX027','2025-06-02 06:35:00','Clear',NULL),
('PAX028','2025-06-02 09:00:00','Clear',NULL),
('PAX029','2025-06-02 06:40:00','Clear',NULL),
('PAX030','2025-06-02 13:05:00','Alert','Liquid over 100ml detected'),
('PAX031','2025-06-02 08:00:00','Clear',NULL),
('PAX032','2025-06-02 09:10:00','Clear',NULL),
('PAX033','2025-06-02 05:05:00','Clear',NULL),
('PAX034','2025-06-02 05:10:00','Clear',NULL),
('PAX035','2025-06-02 23:45:00','Clear',NULL),
('PAX036','2025-06-02 23:50:00','Clear',NULL),
('PAX037','2025-06-02 11:45:00','Clear',NULL),
('PAX038','2025-06-02 07:05:00','Clear',NULL),
('PAX039','2025-06-02 07:10:00','Clear',NULL),
('PAX040','2025-06-02 11:50:00','Alert','Metal object in bag – cleared after secondary check'),
-- 03/06
('PAX041','2025-06-02 15:10:00','Clear',NULL),
('PAX042','2025-06-03 11:20:00','Clear',NULL),
('PAX043','2025-06-02 09:05:00','Clear',NULL),
('PAX044','2025-06-03 04:45:00','Clear',NULL),
('PAX045','2025-06-03 04:50:00','Clear',NULL),
('PAX046','2025-06-03 06:20:00','Clear',NULL),
('PAX047','2025-06-03 06:25:00','Clear',NULL),
('PAX048','2025-06-03 08:00:00','Clear',NULL),
('PAX049','2025-06-03 06:30:00','Clear',NULL),
('PAX050','2025-06-02 10:00:00','Clear',NULL),
('PAX051','2025-06-03 06:35:00','Alert','Passport irregularity – referred to immigration'),
('PAX052','2025-06-03 09:05:00','Clear',NULL),
('PAX053','2025-06-03 06:40:00','Clear',NULL),
('PAX054','2025-06-03 09:10:00','Clear',NULL),
('PAX055','2025-06-03 08:25:00','Clear',NULL),
('PAX056','2025-06-03 08:30:00','Clear',NULL),
('PAX057','2025-06-03 05:10:00','Clear',NULL),
('PAX058','2025-06-05 06:05:00','Clear',NULL),
('PAX059','2025-06-03 19:05:00','Clear',NULL),
('PAX060','2025-06-03 19:10:00','Clear',NULL),
-- 04/06
('PAX061','2025-06-03 05:05:00','Clear',NULL),
('PAX062','2025-06-03 05:08:00','Clear',NULL),
('PAX063','2025-06-03 07:00:00','Clear',NULL),
('PAX064','2025-06-03 07:05:00','Clear',NULL),
('PAX065','2025-06-03 09:05:00','Clear',NULL),
('PAX066','2025-06-04 04:45:00','Clear',NULL),
('PAX067','2025-06-04 04:50:00','Alert','Random selection – secondary screening'),
('PAX068','2025-06-04 07:00:00','Clear',NULL),
('PAX069','2025-06-04 08:05:00','Clear',NULL),
('PAX070','2025-06-04 08:08:00','Clear',NULL),
('PAX071','2025-06-04 08:10:00','Clear',NULL),
('PAX072','2025-06-04 13:05:00','Clear',NULL),
('PAX073','2025-06-04 05:05:00','Clear',NULL),
('PAX074','2025-06-04 05:08:00','Clear',NULL),
-- 05/06
('PAX075','2025-06-05 04:45:00','Clear',NULL),
('PAX076','2025-06-05 04:50:00','Clear',NULL),
('PAX077','2025-06-05 10:05:00','Clear',NULL),
('PAX078','2025-06-05 10:08:00','Alert','Restricted item – confiscated'),
('PAX079','2025-06-05 15:30:00','Clear',NULL),
('PAX080','2025-06-05 06:00:00','Clear',NULL);

-- ============================================================
-- 12. SECURITY RESTRICTED ITEMS
-- ============================================================
INSERT INTO Security_Restricted_Items (Log_ID, Item_Name) VALUES
-- Log 3 PAX003
(3,'Metal object (belt buckle)'),
-- Log 11 PAX011
(11,'Lighter fluid'),
(11,'Pocket knife > 6cm'),
-- Log 20 PAX020
(20,'Oversized carry-on bag (62L)'),
-- Log 30 PAX030
(30,'Water bottle 500ml (liquid > 100ml)'),
(30,'Sunscreen tube 200ml'),
-- Log 40 PAX040
(40,'Stainless steel thermos'),
-- Log 51 PAX051
(51,'Expired visa document'),
-- Log 67 PAX067
(67,'Electronic device without declaration'),
-- Log 78 PAX078
(78,'Swiss army knife'),
(78,'Gas lighter');
