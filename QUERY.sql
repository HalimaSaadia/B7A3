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


    (
        101,
        'Real Madrid vs Barcelona',
        'Champions League',
        150.00,
        'Available'
    ),
    (
        102,
        'Man City vs Liverpool',
        'Premier League',
        120.00,
        'Selling Fast'
    ),
    (
        103,
        'Bayern Munich vs PSG',
        'Champions League',
        130.00,
        'Available'
    ),
    (
        104,
        'AC Milan vs Inter Milan',
        'Serie A',
        90.00,
        'Sold Out'
    ),
    (
        105,
        'Juventus vs Roma',
        'Serie A',
        80.00,
        'Available'
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


    (501, 1, 101, 'A-12', 'Confirmed', 150.00),
    (502, 1, 102, 'B-04', 'Confirmed', 120.00),
    (503, 2, 101, 'A-13', 'Confirmed', 150.00),
    (504, 2, 101, NULL, NULL, 150.00),
    (505, 3, 102, 'C-20', 'Pending', 120.00);