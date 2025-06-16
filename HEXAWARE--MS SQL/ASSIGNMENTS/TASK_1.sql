-- Task 1: Database Design - Ticket Booking System

-- 1. Create Database
CREATE DATABASE IF NOT EXISTS TicketBookingSystem;
USE TicketBookingSystem;

-- 2. Create Venu Table
CREATE TABLE IF NOT EXISTS Venu (
    venue_id INT AUTO_INCREMENT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    address VARCHAR(255) NOT NULL
);

-- 3. Create Booking Table
CREATE TABLE IF NOT EXISTS Booking (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    event_id INT,
    num_tickets INT NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    booking_date DATE NOT NULL
);

-- 4. Create Customer Table
CREATE TABLE IF NOT EXISTS Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone_number VARCHAR(15) NOT NULL,
    booking_id INT,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- 5. Create Event Table
CREATE TABLE IF NOT EXISTS Event (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_date DATE NOT NULL,
    event_time TIME NOT NULL,
    venue_id INT NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    event_type ENUM('Movie', 'Sports', 'Concert') NOT NULL,
    booking_id INT,
    FOREIGN KEY (venue_id) REFERENCES Venu(venue_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- 6. Add Missing Foreign Keys to Booking Table
ALTER TABLE Booking
    ADD CONSTRAINT fk_booking_customer
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id);

ALTER TABLE Booking
    ADD CONSTRAINT fk_booking_event
    FOREIGN KEY (event_id) REFERENCES Event(event_id);
