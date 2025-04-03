-- File: 03-views.sql
-- Creates essential views for the DJ and event management schemas

\set ON_ERROR_STOP on
\set ECHO all

-- Active packages with details
CREATE OR REPLACE VIEW dj.vw_packages AS
SELECT 
    p.id,
    p.name,
    p.description,
    p.price,
    p.duration,
    p.capacity,
    p.features,
    p.is_active
FROM 
    dj.package p;

COMMENT ON VIEW dj.vw_packages IS 'All DJ packages with details';

-- Client booking summary
CREATE OR REPLACE VIEW event.vw_client_bookings AS
SELECT 
    c.id AS client_id,
    c.name AS client_name,
    c.email,
    c.phone,
    COUNT(b.id) AS total_bookings,
    COUNT(CASE WHEN b.status = 'completed' THEN 1 END) AS completed_bookings,
    COUNT(CASE WHEN b.status = 'confirmed' AND b.event_date >= CURRENT_DATE THEN 1 END) AS upcoming_bookings
FROM 
    event.client c
LEFT JOIN 
    event.booking b ON c.id = b.client_id
GROUP BY 
    c.id, c.name, c.email, c.phone;

COMMENT ON VIEW event.vw_client_bookings IS 'Client summary with booking counts';

-- Upcoming events
CREATE OR REPLACE VIEW event.vw_upcoming_events AS
SELECT 
    b.id AS booking_id,
    b.event_date,
    b.event_start_time,
    b.event_end_time,
    b.event_type,
    b.venue,
    b.guest_count,
    b.status,
    c.name AS client_name,
    c.phone AS client_phone,
    p.name AS package_name,
    b.price
FROM 
    event.booking b
JOIN 
    event.client c ON b.client_id = c.id
LEFT JOIN 
    dj.package p ON b.package_id = p.id
WHERE 
    b.event_date >= CURRENT_DATE
ORDER BY 
    b.event_date, b.event_start_time;

COMMENT ON VIEW event.vw_upcoming_events IS 'Upcoming events calendar';

-- Booking financial summary
CREATE OR REPLACE VIEW event.vw_booking_finances AS
SELECT 
    b.id AS booking_id,
    b.event_date,
    c.name AS client_name,
    b.price AS total_price,
    COALESCE(SUM(p.amount), 0) AS amount_paid,
    b.price - COALESCE(SUM(p.amount), 0) AS balance_due
FROM 
    event.booking b
JOIN 
    event.client c ON b.client_id = c.id
LEFT JOIN 
    event.payment p ON b.id = p.booking_id
GROUP BY 
    b.id, b.event_date, c.name, b.price;

COMMENT ON VIEW event.vw_booking_finances IS 'Financial summary for each booking';