-- TASK 4: Subqueries

-- 1. Avg ticket price per venue using subquery
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event e2 WHERE e2.venue_id = e1.venue_id) AS avg_price
FROM Event e1 GROUP BY venue_id;

-- 2. Events with > 50% tickets sold
SELECT * FROM Event WHERE (total_seats - available_seats) > (total_seats / 2);

-- 3. Total tickets sold per event
SELECT event_id, SUM(num_tickets) FROM Booking GROUP BY event_id;

-- 4. Users with no bookings
SELECT * FROM Customer c WHERE NOT EXISTS (SELECT 1 FROM Booking b WHERE b.customer_id = c.customer_id);

-- 5. Events with no bookings (NOT IN)
SELECT * FROM Event WHERE event_id NOT IN (SELECT DISTINCT event_id FROM Booking);

-- 6. Total tickets per event type using subquery
SELECT event_type, SUM(tickets_sold) FROM (
    SELECT event_type, (total_seats - available_seats) AS tickets_sold FROM Event
) AS sub GROUP BY event_type;

-- 7. Events priced higher than average
SELECT * FROM Event WHERE ticket_price > (SELECT AVG(ticket_price) FROM Event);

-- 8. Revenue by user (correlated)
SELECT customer_id, (SELECT SUM(total_cost) FROM Booking b2 WHERE b2.customer_id = b1.customer_id) AS revenue
FROM Booking b1 GROUP BY customer_id;

-- 9. Users booked for a venue
SELECT * FROM Customer WHERE customer_id IN (
    SELECT b.customer_id FROM Booking b JOIN Event e ON b.event_id = e.event_id WHERE e.venue_id = 1
);

-- 10. Total tickets per event category
SELECT event_type, SUM(sold) FROM (
    SELECT event_type, (total_seats - available_seats) AS sold FROM Event
) AS sub GROUP BY event_type;

-- 11. Users booked in each month
SELECT customer_id, MONTH(booking_date) FROM Booking GROUP BY customer_id, MONTH(booking_date);

-- 12. Avg ticket price per venue using subquery (repeat from 1)
SELECT venue_id, (SELECT AVG(ticket_price) FROM Event e2 WHERE e2.venue_id = e1.venue_id) AS avg_price
FROM Event e1 GROUP BY venue_id;
