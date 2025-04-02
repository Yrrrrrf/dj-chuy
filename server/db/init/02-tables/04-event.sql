-- File: 02-event.sql
-- Creates a streamlined event management schema

\set ON_ERROR_STOP on
\set ECHO all

-- Create the event schema
CREATE SCHEMA IF NOT EXISTS event;

-- Client: Stores client information
CREATE TABLE IF NOT EXISTS event.client (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL, -- Combined name instead of separate fields
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE event.client IS 'Client information for DJ services';

-- Booking: Stores event bookings with flexible structure
CREATE TABLE IF NOT EXISTS event.booking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL REFERENCES event.client(id),
    package_id UUID REFERENCES dj.package(id),
    event_date DATE NOT NULL,
    event_start_time TIME NOT NULL,
    event_end_time TIME NOT NULL,
    event_type VARCHAR(50) NOT NULL,
    venue VARCHAR(255), -- Combined venue field instead of separate name/address
    guest_count INT,
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    price DECIMAL(10, 2) CHECK (price >= 0),
    details JSONB DEFAULT '{}', -- Flexible details field for additional info
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT valid_event_times CHECK (event_start_time < event_end_time)
);

COMMENT ON TABLE event.booking IS 'Event bookings for DJ services';
COMMENT ON COLUMN event.booking.details IS 'Flexible JSON object for storing additional booking details';

-- Additional Services: Services added to a booking
CREATE TABLE IF NOT EXISTS event.booking_service (
    booking_id UUID REFERENCES event.booking(id) ON DELETE CASCADE,
    service_id UUID REFERENCES dj.service(id) ON DELETE CASCADE,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    PRIMARY KEY (booking_id, service_id)
);

-- Payment: Tracks payments for bookings
CREATE TABLE IF NOT EXISTS event.payment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    booking_id UUID NOT NULL REFERENCES event.booking(id) ON DELETE CASCADE,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    reference VARCHAR(100), -- Simplified from reference_number
    notes TEXT
);

-- Quote: Stores quotes with a flexible structure
CREATE TABLE IF NOT EXISTS event.quote (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    client_id UUID NOT NULL REFERENCES event.client(id),
    package_id UUID REFERENCES dj.package(id),
    event_date DATE,
    event_type VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    valid_until DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'pending',
    details JSONB DEFAULT '{}', -- Flexible details field
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE event.quote IS 'Quotes provided to potential clients';

-- Function to check for schedule conflicts
CREATE OR REPLACE FUNCTION event.check_schedule_conflict()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM event.booking b
        WHERE b.id != NEW.id
          AND b.event_date = NEW.event_date
          AND b.status NOT IN ('cancelled', 'no_show')
          AND (
              (NEW.event_start_time BETWEEN b.event_start_time AND b.event_end_time) OR
              (NEW.event_end_time BETWEEN b.event_start_time AND b.event_end_time) OR
              (NEW.event_start_time <= b.event_start_time AND NEW.event_end_time >= b.event_end_time)
          )
    ) THEN
        RAISE EXCEPTION 'Schedule conflict detected';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create timestamp update function
CREATE OR REPLACE FUNCTION event.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers
CREATE TRIGGER update_client_timestamp
    BEFORE UPDATE ON event.client
    FOR EACH ROW
    EXECUTE FUNCTION event.update_timestamp();

CREATE TRIGGER update_booking_timestamp
    BEFORE UPDATE ON event.booking
    FOR EACH ROW
    EXECUTE FUNCTION event.update_timestamp();

CREATE TRIGGER update_quote_timestamp
    BEFORE UPDATE ON event.quote
    FOR EACH ROW
    EXECUTE FUNCTION event.update_timestamp();

CREATE TRIGGER check_booking_conflict
    BEFORE INSERT OR UPDATE OF event_date, event_start_time, event_end_time, status ON event.booking
    FOR EACH ROW
    EXECUTE FUNCTION event.check_schedule_conflict();

-- Create indexes
CREATE INDEX idx_client_email ON event.client(email);
CREATE INDEX idx_booking_client ON event.booking(client_id);
CREATE INDEX idx_booking_date ON event.booking(event_date);
CREATE INDEX idx_booking_status ON event.booking(status);