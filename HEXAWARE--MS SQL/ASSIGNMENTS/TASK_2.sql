-- TASK 2: Insert and Filtering Queries

-- 1. Insert sample records (only a few for demonstration)
INSERT INTO Venue (venue_name, address) VALUES 
('City Arena', '123 Main Street'), 
('Grand Theater', '456 Broadway'), 
('Stadium Dome', '789 Arena Blvd');

INSERT INTO Event (event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type) VALUES
('World Cup Final', '2025-08-20', '18:00:00', 3, 20000, 15000, 3000.00, 'Sports'),
('Jazz Concert', '2025-07-10', '20:00:00', 2, 5000, 2000, 1500.00, 'Concert'),
('Movie Premiere', '2025-06-25', '19:30:00', 1, 300, 250, 500.00, 'Movie');

INSERT INTO Customer (customer_name, email, phone_number) VALUES
('Alice', 'alice@example.com', '123456000'),
('Bob', 'bob@example.com', '987654321'),
('Charlie', 'charlie@example.com', '999990000');

INSERT INTO Booking (customer_id, event_id, num_tickets, total_cost) VALUES
(1, 1, 5, 15000),
(2, 2, 3, 4500),
(3, 3, 2, 1000);

-- 2. List all Events
SELECT * FROM Event;

-- 3. Select events with available tickets
SELECT * FROM Event WHERE available_seats > 0;

-- 4. Events name partial match with ‘cup’
SELECT * FROM Event WHERE event_name LIKE '%cup%';

-- 5. Ticket price between 1000 to 2500
SELECT * FROM Event WHERE ticket_price BETWEEN 1000 AND 2500;

-- 6. Events in a date range
SELECT * FROM Event WHERE event_date BETWEEN '2025-06-01' AND '2025-08-31';

-- 7. Available tickets and event type 'Concert'
SELECT * FROM Event WHERE available_seats > 0 AND event_type = 'Concert';

-- 8. Users in batches of 5, starting from the 6th
SELECT * FROM Customer LIMIT 5 OFFSET 5;

-- 9. Bookings with more than 4 tickets
SELECT * FROM Booking WHERE num_tickets > 4;

-- 10. Customers with phone number ending in ‘000’
SELECT * FROM Customer WHERE phone_number LIKE '%000';

-- 11. Events ordered by seat capacity > 15000
SELECT * FROM Event WHERE total_seats > 15000 ORDER BY total_seats DESC;

-- 12. Events name not starting with x/y/z
SELECT * FROM Event WHERE event_name NOT REGEXP '^[xyzXYZ]';
