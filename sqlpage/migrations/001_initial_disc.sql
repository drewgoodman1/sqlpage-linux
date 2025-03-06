-- 001_initial_disc.sql
-- This migration creates the necessary tables and populates sample data.

-- Create the brands table.
CREATE TABLE IF NOT EXISTS brands (
    id SERIAL PRIMARY KEY,
    brand_name VARCHAR(255) NOT NULL
);

-- Create the disc_types table.
CREATE TABLE IF NOT EXISTS disc_types (
    id SERIAL PRIMARY KEY,
    type_name VARCHAR(255) NOT NULL
);

-- Create the discs table.
CREATE TABLE IF NOT EXISTS discs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INTEGER NOT NULL,
    type_id INTEGER NOT NULL,
    speed INTEGER NOT NULL,
    glide INTEGER NOT NULL,
    turn INTEGER NOT NULL,
    fade INTEGER NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(id),
    FOREIGN KEY (type_id) REFERENCES disc_types(id)
);

-- Insert a sample brand.
INSERT INTO brands (brand_name)
VALUES ('Innova')
ON CONFLICT DO NOTHING;

-- Insert sample disc types.
INSERT INTO disc_types (type_name)
VALUES 
    ('Distance Driver'),
    ('Fairway Driver'),
    ('Midrange'),
    ('Putter')
ON CONFLICT DO NOTHING;

-- Insert one sample disc record for each disc type.
-- Sample for Distance Driver (assumed disc_types.id = 1)
INSERT INTO discs (name, brand_id, type_id, speed, glide, turn, fade)
VALUES ('Destroyer', 1, 1, 12, 5, -1, 3);

