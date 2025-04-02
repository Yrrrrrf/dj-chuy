-- File: 01-dj.sql
-- Creates the DJ services schema with a flexible, non-redundant structure

\set ON_ERROR_STOP on
\set ECHO all

-- Create the DJ schema
CREATE SCHEMA IF NOT EXISTS dj;

-- Service: Defines basic DJ service types
CREATE TABLE IF NOT EXISTS dj.service (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    category VARCHAR(50) NOT NULL,
    base_price DECIMAL(10, 2) NOT NULL CHECK (base_price >= 0),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE dj.service IS 'Core DJ service offerings';

-- Package: Defines service packages with flexible features structure
CREATE TABLE IF NOT EXISTS dj.package (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
    duration INT NOT NULL CHECK (duration > 0), -- Duration in minutes
    capacity VARCHAR(50), -- Capacity range (e.g., "30-50 people")
    features JSONB DEFAULT '[]', -- Array of features instead of individual columns
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE dj.package IS 'Pre-configured DJ service packages';
COMMENT ON COLUMN dj.package.features IS 'Flexible JSON array of package features';

-- Equipment: Tracks DJ equipment inventory
CREATE TABLE IF NOT EXISTS dj.equipment (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'available',
    attributes JSONB DEFAULT '{}', -- Flexible equipment attributes
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE dj.equipment IS 'DJ equipment inventory';

-- Package Services: Maps services to packages
CREATE TABLE IF NOT EXISTS dj.package_service (
    package_id UUID REFERENCES dj.package(id) ON DELETE CASCADE,
    service_id UUID REFERENCES dj.service(id) ON DELETE CASCADE,
    PRIMARY KEY (package_id, service_id)
);

-- Create timestamp update trigger function
CREATE OR REPLACE FUNCTION dj.update_timestamp()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create triggers for updating timestamps
CREATE TRIGGER update_service_timestamp
    BEFORE UPDATE ON dj.service
    FOR EACH ROW
    EXECUTE FUNCTION dj.update_timestamp();

CREATE TRIGGER update_package_timestamp
    BEFORE UPDATE ON dj.package
    FOR EACH ROW
    EXECUTE FUNCTION dj.update_timestamp();

CREATE TRIGGER update_equipment_timestamp
    BEFORE UPDATE ON dj.equipment
    FOR EACH ROW
    EXECUTE FUNCTION dj.update_timestamp();

-- Create indexes for better performance
CREATE INDEX idx_service_category ON dj.service(category);
CREATE INDEX idx_service_active ON dj.service(is_active);
CREATE INDEX idx_package_active ON dj.package(is_active);