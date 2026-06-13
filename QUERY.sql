CREATE TABLE
    users (
        user_id SERIAL PRIMARY KEY,
        full_name VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE NOT NULL,
        role VARCHAR(50) CHECK (role IN ('Ticket Manager', 'Football Fan')),
        phone_number VARCHAR(20)
    );


CREATE TABLE
    Matches (
        match_id SERIAL PRIMARY KEY,
        fixture VARCHAR(150),
        tournament_category VARCHAR(100),
        base_ticket_price DECIMAL(10, 2) CHECK (base_ticket_price >= 0),
        match_status VARCHAR(50) CHECK (
            match_status IN (
                'Available',
                'Selling Fast',
                'Sold Out',
                'Postponed'
            )
        )
    );


CREATE TABLE
    Bookings (
        booking_id SERIAL PRIMARY KEY,
        user_id INT REFERENCES Users (user_id),
        match_id INT REFERENCES Matches (match_id),
        seat_number VARCHAR(20),
        payment_status VARCHAR(50) CHECK (
            payment_status IN ('Pending', 'Confirmed', 'Cancelled', 'Refunded')
        ),
        total_cost DECIMAL(10, 2) CHECK (total_cost >= 0)
    );


-- QUERY 1
SELECT match_id, fixture, round(base_ticket_price)
FROM matches
WHERE tournament_category = 'Champions League'
AND match_status = 'Available';

-- QUERY 2
SELECT user_id, full_name, email
FROM users
WHERE full_name ILIKE 'Tanvir%'
OR full_name ILIKE '%Haque%';

-- QUERY 3
SELECT 
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM bookings
WHERE payment_status IS NULL;