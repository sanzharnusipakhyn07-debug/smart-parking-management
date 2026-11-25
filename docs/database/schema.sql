CREATE TABLE tariffs (
    tariff_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price_per_hour NUMERIC(10, 2) NOT NULL CHECK (price_per_hour >= 0)
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    phone VARCHAR(20) NOT NULL UNIQUE,
    car_plate VARCHAR(20) NOT NULL
);

CREATE TABLE parking_spots (
    spot_id SERIAL PRIMARY KEY,
    spot_code VARCHAR(20) NOT NULL UNIQUE,
    zone_name VARCHAR(50) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('free', 'reserved', 'occupied')),
    tariff_id INT NOT NULL REFERENCES tariffs(tariff_id)
);

CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    spot_id INT NOT NULL REFERENCES parking_spots(spot_id),
    qr_code VARCHAR(100) NOT NULL UNIQUE,
    status VARCHAR(20) NOT NULL CHECK (status IN ('active', 'completed', 'cancelled')),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE services (
    service_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price >= 0)
);

CREATE TABLE booking_services (
    booking_id INT NOT NULL REFERENCES bookings(booking_id) ON DELETE CASCADE,
    service_id INT NOT NULL REFERENCES services(service_id),
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    PRIMARY KEY (booking_id, service_id)
);

CREATE TABLE access_logs (
    log_id SERIAL PRIMARY KEY,
    booking_id INT NOT NULL REFERENCES bookings(booking_id),
    gate_name VARCHAR(50) NOT NULL,
    direction VARCHAR(10) NOT NULL CHECK (direction IN ('entry', 'exit')),
    logged_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO tariffs (name, price_per_hour) VALUES
('Стандарт', 300.00),
('VIP аймақ', 600.00),
('Түнгі тариф', 200.00);

INSERT INTO users (full_name, phone, car_plate) VALUES
('Санжар Нұсипахын', '+77011112233', '777ABC02'),
('Алихан Серіков', '+77022223344', '123XYZ02'),
('Данияр Төлеуов', '+77053334455', '456KLM05'),
('Айгерім Қасымова', '+77074445566', '890QWE02');

INSERT INTO parking_spots (spot_code, zone_name, status, tariff_id) VALUES
('A-01', 'A аймағы', 'reserved', 1),
('A-02', 'A аймағы', 'free', 1),
('B-01', 'B аймағы', 'occupied', 2),
('C-01', 'C аймағы', 'free', 3);

INSERT INTO services (title, price) VALUES
('Электромобильді зарядтау', 1000.00),
('Автокөлікті жуу', 2500.00),
('Броньды ұзарту', 500.00);

INSERT INTO bookings (user_id, spot_id, qr_code, status) VALUES
(1, 1, 'QR-2026-001', 'active'),
(2, 3, 'QR-2026-002', 'active'),
(3, 2, 'QR-2026-003', 'completed'),
(4, 4, 'QR-2026-004', 'cancelled');

INSERT INTO booking_services (booking_id, service_id, quantity) VALUES
(1, 1, 1),
(2, 1, 1),
(2, 2, 1),
(3, 3, 1);

INSERT INTO access_logs (booking_id, gate_name, direction) VALUES
(1, 'Кіру шлагбаумы №1', 'entry'),
(2, 'Кіру шлагбаумы №1', 'entry'),
(3, 'Кіру шлагбаумы №2', 'entry'),
(3, 'Шығу шлагбаумы №1', 'exit');

SELECT
    b.booking_id,
    u.full_name,
    u.car_plate,
    ps.spot_code,
    b.qr_code,
    b.status
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN parking_spots ps ON b.spot_id = ps.spot_id;

SELECT
    zone_name,
    status,
    COUNT(*) AS spots_count
FROM parking_spots
GROUP BY zone_name, status;
