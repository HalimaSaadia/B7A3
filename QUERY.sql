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
SELECT
    match_id,
    fixture,
    round(base_ticket_price)
FROM
    matches
WHERE
    tournament_category = 'Champions League'
    AND match_status = 'Available';

-- QUERY 2
SELECT
    user_id,
    full_name,
    email
FROM
    users
WHERE
    full_name ILIKE 'Tanvir%'
    OR full_name ILIKE '%Haque%';

-- QUERY 3
SELECT
    booking_id,
    user_id,
    match_id,
    COALESCE(payment_status, 'Action Required') AS systematic_status
FROM
    bookings
WHERE
    payment_status IS NULL;

query 4
SELECT
    b.booking_id,
    u.full_name,
    m.fixture,
    b.total_cost
FROM
    bookings b
    INNER JOIN users u ON b.user_id = u.user_id
    INNER JOIN matches m ON b.match_id = m.match_id;

-- QUERY 5
SELECT
    u.user_id,
    u.full_name,
    b.booking_id
FROM
    users u
    LEFT JOIN bookings b ON u.user_id = b.user_id;

-- query 6
SELECT
    booking_id,
    match_id,
    total_cost
FROM
    bookings
where
    total_cost > (
        SELECT
            AVG(total_cost)
        FROM
            bookings
    )

    -- query 7
    select match_id,
    fixture,
    base_ticket_price from matches order by base_ticket_price desc limit(2) offset(1)