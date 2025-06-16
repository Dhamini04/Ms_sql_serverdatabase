USE TicketBookingSystem;

-- 1. Insert into Venu
INSERT INTO Venu (venue_name, address) VALUES
('City Hall Theater', '123 Main St'),
('Grand Concert Arena', '456 Broadway'),
('Movie Max Multiplex', '789 Cinema Ave'),
('Open Air Stadium', '101 Sports Lane'),
('Community Center', '202 Culture Blvd'),
('Riverfront Theater', '303 Riverside Dr'),
('Downtown Cinema', '404 City Circle'),
('Arena Palace', '505 Palace Way'),
('Art Deco Hall', '606 Art Lane'),
('Skyline Auditorium', '707 Skytop Rd');

-- 2. Insert into Event
INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id) VALUES
('Avengers Movie', '2025-07-01', '18:00:00', 3, 150, 150, 250.00, 'Movie', NULL),
('Coldplay Concert', '2025-07-05', '20:00:00', 2, 500, 500, 1200.00, 'Concert', NULL),
('Football Final', '2025-07-10', '17:30:00', 4, 1000, 1000, 1500.00, 'Sports', NULL),
('Jazz Night', '2025-07-12', '19:00:00', 6, 200, 200, 800.00, 'Concert', NULL),
('Shakespeare Play', '2025-07-15', '18:30:00', 1, 100, 100, 300.00, 'Movie', NULL),
('EDM Fest', '2025-07-18', '22:00:00', 8, 700, 700, 1300.00, 'Concert', NULL),
('Art Exhibition', '2025-07-20', '10:00:00', 5, 120, 120, 200.00, 'Movie', NULL),
('Indie Movie Fest', '2025-07-22', '16:00:00', 7, 180, 180, 400.00, 'Movie', NULL),
('Stand-up Comedy', '2025-07-25', '20:30:00', 9, 250, 250, 600.00, 'Concert', NULL),
('National Wrestling', '2025-07-28', '19:00:00', 10, 950, 950, 1000.00, 'Sports', NULL);

-- 3. Insert into Booking
INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost, booking_date) VALUES
(NULL, 1, 2, 500.00, '2025-06-01'),
(NULL, 2, 3, 3600.00, '2025-06-02'),
(NULL, 3, 5, 7500.00, '2025-06-03'),
(NULL, 4, 1, 800.00, '2025-06-04'),
(NULL, 5, 4, 4800.00, '2025-06-05'),
(NULL, 6, 1, 1000.00, '2025-06-06'),
(NULL, 7, 3, 4500.00, '2025-06-07'),
(NULL, 8, 2, 1000.00, '2025-06-08'),
(NULL, 9, 3, 10000.00, '2025-06-09'),
(NULL, 10, 2, 2400.00, '2025-06-10');

-- 4. Insert into Customer
INSERT INTO Customer (customer_name, email, phone_number, booking_id) VALUES
('Alice Johnson', 'alice@example.com', '9876543000', 1),
('Bob Smith', 'bob@example.com', '8765432000', 2),
('Cathy Brown', 'cathy@example.com', '7654321000', 3),
('David Lee', 'david@example.com', '6543210000', 4),
('Eva Green', 'eva@example.com', '5432100000', 5),
('Frank White', 'frank@example.com', '4321000000', 6),
('Grace Kim', 'grace@example.com', '3210000000', 7),
('Henry Adams', 'henry@example.com', '2100000000', 8),
('Isla Moore', 'isla@example.com', '1090000000', 9),
('Jake Bell', 'jake@example.com', '9988776000', 10);

-- 5. Update Booking.customer_id after Customer insert
UPDATE Booking SET customer_id = 1 WHERE booking_id = 1;
UPDATE Booking SET customer_id = 2 WHERE booking_id = 2;
UPDATE Booking SET customer_id = 3 WHERE booking_id = 3;
UPDATE Booking SET customer_id = 4 WHERE booking_id = 4;
UPDATE Booking SET customer_id = 5 WHERE booking_id = 5;
UPDATE Booking SET customer_id = 6 WHERE booking_id = 6;
UPDATE Booking SET customer_id = 7 WHERE booking_id = 7;
UPDATE Booking SET customer_id = 8 WHERE booking_id = 8;
UPDATE Booking SET customer_id = 9 WHERE booking_id = 9;
UPDATE Booking SET customer_id = 10 WHERE booking_id = 10;

-- =============================
-- Basic SQL Queries from Task 2
-- =============================

-- 2 List all Events
SELECT * FROM Event;

-- 3 Events with available tickets
SELECT * FROM Event WHERE available_seats > 0;

-- 4 Events with name containing 'cup'
SELECT * FROM Event WHERE event_name LIKE '%cup%';

-- 5 Events with ticket price between 1000 and 2500
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;

-- 6 Events within a specific date range
SELECT * FROM Event WHERE event_date BETWEEN '2025-07-01' AND '2025-07-15';

-- 7 Events with available tickets AND "Concert" in name
SELECT * FROM Event WHERE available_seats > 0 AND event_name LIKE '%Concert%';

-- 8 Retrieve users in batches of 5, starting from 6th
SELECT * FROM Customer LIMIT 5 OFFSET 5;

-- 9 Bookings with more than 4 tickets
SELECT * FROM Booking WHERE num_tickets > 4;

-- 10 Customers whose phone ends with '000'
SELECT * FROM Customer WHERE phone_number LIKE '%000';

-- 11 Events with more than 15,000 seats
SELECT * FROM Event WHERE total_seats > 15000;

-- 12 Events whose name does not start with 'x', 'y', or 'z'
SELECT * FROM Event 
WHERE event_name NOT LIKE 'x%' AND event_name NOT LIKE 'y%' AND event_name NOT LIKE 'z%';
