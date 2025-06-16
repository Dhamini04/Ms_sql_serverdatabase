USE TicketBookingSystem;

-- 1. Average Ticket Price for Events in Each Venue Using a Subquery
SELECT 
    v.venue_id,
    v.venue_name,
    (
        SELECT AVG(e.ticket_price)
        FROM Event e
        WHERE e.venue_id = v.venue_id
    ) AS average_ticket_price
FROM Venu v;

-- 2. Events with More Than 50% of Tickets Sold Using a Subquery
SELECT 
    e.event_id,
    e.event_name,
    e.total_seats,
    (
        SELECT COALESCE(SUM(b.num_tickets), 0)
        FROM Booking b
        WHERE b.event_id = e.event_id
    ) AS tickets_sold
FROM Event e
WHERE (
    SELECT COALESCE(SUM(b.num_tickets), 0)
    FROM Booking b
    WHERE b.event_id = e.event_id
) > (e.total_seats / 2);

-- 3. Total Number of Tickets Sold for Each Event
SELECT 
    e.event_id,
    e.event_name,
    (
        SELECT SUM(b.num_tickets)
        FROM Booking b
        WHERE b.event_id = e.event_id
    ) AS total_tickets_sold
FROM Event e;

-- 4. Users Who Have Not Booked Any Tickets Using NOT EXISTS
SELECT 
    c.customer_id,
    c.customer_name,
    c.email
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1
    FROM Booking b
    WHERE b.customer_id = c.customer_id
);

-- 5. Events with No Ticket Sales Using NOT IN
SELECT 
    event_id,
    event_name
FROM Event
WHERE event_id NOT IN (
    SELECT DISTINCT event_id
    FROM Booking
);

-- 6. Total Number of Tickets Sold for Each Event Type Using a Subquery in the FROM Clause
SELECT 
    event_type,
    SUM(tickets_sold) AS total_tickets_sold
FROM (
    SELECT 
        e.event_type,
        b.num_tickets AS tickets_sold
    FROM Booking b
    JOIN Event e ON b.event_id = e.event_id
) AS ticket_data
GROUP BY event_type;

-- 7. Events with Ticket Prices Higher Than the Average Using a Subquery in the WHERE Clause
SELECT 
    event_id,
    event_name,
    ticket_price
FROM Event
WHERE ticket_price > (
    SELECT AVG(ticket_price)
    FROM Event
)
ORDER BY ticket_price DESC;

-- 8. Total Revenue by Each User Using a Correlated Subquery
SELECT 
    c.customer_id,
    c.customer_name,
    (
        SELECT COALESCE(SUM(b.total_cost), 0)
        FROM Booking b
        WHERE b.customer_id = c.customer_id
    ) AS total_revenue
FROM Customer c
ORDER BY total_revenue DESC;

-- 9. Users Who Booked Tickets for Events in a Given Venue Using a Subquery in WHERE
SELECT 
    DISTINCT c.customer_id,
    c.customer_name
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
WHERE b.event_id IN (
    SELECT event_id
    FROM Event
    WHERE venue_id = 1  -- Replace with the specific venue_id
);

-- 10. Total Tickets Sold for Each Event Category Using Subquery with GROUP BY
SELECT 
    event_type,
    SUM(tickets_sold) AS total_tickets_sold
FROM (
    SELECT 
        e.event_type,
        b.num_tickets AS tickets_sold
    FROM Event e
    JOIN Booking b ON e.event_id = b.event_id
) AS sales_data
GROUP BY event_type;

-- 11. Users Who Have Booked Tickets for Events in Each Month Using Subquery with DATE_FORMAT
SELECT 
    c.customer_id,
    c.customer_name,
    DATE_FORMAT(b.booking_date, '%Y-%m') AS booking_month
FROM Customer c
JOIN Booking b ON c.customer_id = b.customer_id
WHERE DATE_FORMAT(b.booking_date, '%Y-%m') IN (
    SELECT DISTINCT DATE_FORMAT(booking_date, '%Y-%m')
    FROM Booking
)
ORDER BY booking_month;

-- 12. Average Ticket Price for Events in Each Venue Using a Subquery in FROM Clause
SELECT 
    v.venue_id,
    v.venue_name,
    avg_data.avg_ticket_price
FROM Venu v
JOIN (
    SELECT 
        venue_id,
        AVG(ticket_price) AS avg_ticket_price
    FROM Event
    GROUP BY venue_id
) AS avg_data ON v.venue_id = avg_data.venue_id
ORDER BY avg_ticket_price DESC;
