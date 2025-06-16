-- TASK 1: Database Design

-- 1. Create the database
CREATE DATABASE TicketBookingSystem;
USE TicketBookingSystem;

-- 2. Create Venue table
CREATE TABLE Venue (
    venue_id INT PRIMARY KEY AUTO_INCREMENT,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);

-- 3. Create Event table
CREATE TABLE Event (
    event_id INT PRIMARY KEY AUTO_INCREMENT,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE,
    event_time TIME,
    venue_id INT,
    total_seats INT,
    available_seats INT,
    ticket_price DECIMAL(10,2),
    event_type ENUM('Movie', 'Sports', 'Concert'),
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
);

-- 4. Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(15)
);

-- 5. Create Booking table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    event_id INT,
    num_tickets INT,
    total_cost DECIMAL(10,2),
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
);
