-- File: 04-sample-data.sql
-- Sample data for the DJ CHUY database

\set ON_ERROR_STOP on
\set ECHO all

-- Insert sample services
INSERT INTO dj.service (name, description, category, base_price, is_active) VALUES
('DJ Service', 'Professional DJ service with music selection', 'DJ', 2500.00, true),
('Audio Rental', 'High-quality audio equipment rental', 'Equipment', 1500.00, true),
('Lighting', 'Professional lighting effects', 'Equipment', 800.00, true),
('Animation', 'Professional animator for your event', 'Personnel', 1200.00, true),
('Video Projection', 'Projection screen with visual effects', 'Equipment', 1000.00, true);

-- Insert sample packages
-- todo: Check why this data isn't available in the database!
INSERT INTO dj.package (name, description, price, duration, capacity, features, is_active) VALUES
('Simple', 'Basic audio package for small gatherings', 4499.00, 300, '30-50 people', 
  '[
    "Professional DJ service",
    "Audio for 30-50 people",
    "Basic lighting (2 wash lights)",
    "5 hours of service",
    "Professional host/animator"
  ]', 
  true),
  
('Master', 'Enhanced audio and lighting for medium events', 6899.00, 300, '50-150 people', 
  '[
    "Professional DJ service",
    "Audio for 50-150 people",
    "Enhanced lighting (4 wash lights)",
    "Smoke machine",
    "DJ cabin",
    "5 hours of service",
    "Professional host/animator"
  ]', 
  true),
  
('Gold', 'Premium package for large events', 12899.00, 300, '150-300 people', 
  '[
    "Professional DJ service",
    "Audio for 150-300 people",
    "Premium lighting setup (5 wash lights)",
    "Smoke machine",
    "DJ cabin",
    "Giant screen (6 square meters)",
    "One harlequin performer",
    "Two mascot characters",
    "5 hours of service",
    "Professional host/animator"
  ]', 
  true),
  
('Plus', 'Ultimate entertainment package', 16899.00, 300, '300-500 people', 
  '[
    "Professional DJ service",
    "Audio for 300-500 people",
    "Premium lighting with beam effects",
    "Smoke machine",
    "DJ cabin",
    "Giant screen (6 square meters)",
    "Two 55-inch TVs",
    "One LED robot show",
    "One harlequin performer",
    "Two mascot characters",
    "5 hours of service",
    "Professional host/animator"
  ]', 
  true);

-- Connect packages with services
INSERT INTO dj.package_service (package_id, service_id) VALUES
((SELECT id FROM dj.package WHERE name = 'Simple'), (SELECT id FROM dj.service WHERE name = 'DJ Service')),
((SELECT id FROM dj.package WHERE name = 'Simple'), (SELECT id FROM dj.service WHERE name = 'Audio Rental')),
((SELECT id FROM dj.package WHERE name = 'Simple'), (SELECT id FROM dj.service WHERE name = 'Animation')),

((SELECT id FROM dj.package WHERE name = 'Master'), (SELECT id FROM dj.service WHERE name = 'DJ Service')),
((SELECT id FROM dj.package WHERE name = 'Master'), (SELECT id FROM dj.service WHERE name = 'Audio Rental')),
((SELECT id FROM dj.package WHERE name = 'Master'), (SELECT id FROM dj.service WHERE name = 'Lighting')),
((SELECT id FROM dj.package WHERE name = 'Master'), (SELECT id FROM dj.service WHERE name = 'Animation')),

((SELECT id FROM dj.package WHERE name = 'Gold'), (SELECT id FROM dj.service WHERE name = 'DJ Service')),
((SELECT id FROM dj.package WHERE name = 'Gold'), (SELECT id FROM dj.service WHERE name = 'Audio Rental')),
((SELECT id FROM dj.package WHERE name = 'Gold'), (SELECT id FROM dj.service WHERE name = 'Lighting')),
((SELECT id FROM dj.package WHERE name = 'Gold'), (SELECT id FROM dj.service WHERE name = 'Animation')),
((SELECT id FROM dj.package WHERE name = 'Gold'), (SELECT id FROM dj.service WHERE name = 'Video Projection')),

((SELECT id FROM dj.package WHERE name = 'Plus'), (SELECT id FROM dj.service WHERE name = 'DJ Service')),
((SELECT id FROM dj.package WHERE name = 'Plus'), (SELECT id FROM dj.service WHERE name = 'Audio Rental')),
((SELECT id FROM dj.package WHERE name = 'Plus'), (SELECT id FROM dj.service WHERE name = 'Lighting')),
((SELECT id FROM dj.package WHERE name = 'Plus'), (SELECT id FROM dj.service WHERE name = 'Animation')),
((SELECT id FROM dj.package WHERE name = 'Plus'), (SELECT id FROM dj.service WHERE name = 'Video Projection'));

-- Insert sample clients
INSERT INTO event.client (name, email, phone, address) VALUES
('Juan Pérez', 'juan.perez@mail.com', '7122223333', 'Calle Primera 123, Toluca'),
('María García', 'maria.garcia@mail.com', '7123334444', 'Av. Independencia 456, Metepec'),
('Carlos Rodríguez', 'carlos.rodriguez@mail.com', '7124445555', 'Calle Morelos 789, Lerma');

-- Insert sample bookings
INSERT INTO event.booking (
    client_id, package_id, event_date, event_start_time, event_end_time, 
    event_type, venue, guest_count, status, price, details
) VALUES
(
    (SELECT id FROM event.client WHERE name = 'Juan Pérez'),
    (SELECT id FROM dj.package WHERE name = 'Master'),
    '2025-06-15', '16:00', '21:00',
    'wedding', 'Salón Versalles, Toluca', 120, 'confirmed', 6899.00,
    '{"special_requests": "Play mostly 80s and 90s music", "color_theme": "blue and silver"}'
),
(
    (SELECT id FROM event.client WHERE name = 'María García'),
    (SELECT id FROM dj.package WHERE name = 'Simple'),
    '2025-05-20', '18:00', '23:00',
    'birthday', 'Residencia García, Metepec', 40, 'confirmed', 4499.00,
    '{"special_song": "Las Mañanitas", "birthday_person": "Ana García", "age": 15}'
),
(
    (SELECT id FROM event.client WHERE name = 'Carlos Rodríguez'),
    (SELECT id FROM dj.package WHERE name = 'Gold'),
    '2025-07-30', '19:00', '24:00',
    'corporate', 'Hotel Fiesta Inn, Toluca', 200, 'pending', 12899.00,
    '{"company_name": "Industrias Rodriguez", "event_theme": "Year-end celebration"}'
);

-- Insert sample payments
INSERT INTO event.payment (booking_id, amount, payment_date, payment_method, reference) VALUES
(
    (SELECT id FROM event.booking WHERE client_id = (SELECT id FROM event.client WHERE name = 'Juan Pérez')),
    3000.00, '2025-03-10 15:30:00', 'transfer', 'TRF-12345'
),
(
    (SELECT id FROM event.booking WHERE client_id = (SELECT id FROM event.client WHERE name = 'Juan Pérez')),
    3899.00, '2025-04-20 14:15:00', 'cash', 'CASH-001'
),
(
    (SELECT id FROM event.booking WHERE client_id = (SELECT id FROM event.client WHERE name = 'María García')),
    2000.00, '2025-03-15 10:45:00', 'transfer', 'TRF-23456'
);

-- Insert sample quotes
INSERT INTO event.quote (
    client_id, package_id, event_date, event_type, price, valid_until, status, details
) VALUES
(
    (SELECT id FROM event.client WHERE name = 'Carlos Rodríguez'),
    (SELECT id FROM dj.package WHERE name = 'Plus'),
    '2025-12-15', 'corporate', 16899.00, '2025-05-31', 'pending',
    '{"estimated_guests": 350, "venue": "Centro de Convenciones Toluca", "event_name": "Annual Company Gala"}'
);