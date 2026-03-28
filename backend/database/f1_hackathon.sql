/*
=============================================================================
DATABASE: f1_hackathon
PURPOSE:  Normalized database to power a gamified F1 driver "Slot Machine" app.
          Stores static driver data (NOW INCLUDING OVERALL RARITY), event details, 
          overall race results, and granular lap-by-lap telemetry.
=============================================================================
*/

-- Drop the existing database to ensure a clean slate before recreating
DROP DATABASE IF EXISTS f1_hackathon;

-- Create the database and switch to it
CREATE DATABASE f1_hackathon;
USE f1_hackathon;

-- --------------------------------------------------------------------------
-- TABLE: drivers
-- Contains static profile information for each driver, including their OVERALL RARITY.
-- --------------------------------------------------------------------------
CREATE TABLE drivers (
    driver_id VARCHAR(50) NOT NULL,    -- PRIMARY KEY: Unique string identifier (e.g., 'max_verstappen')
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    abbreviation VARCHAR(5),
    driver_number INT,
    team_name VARCHAR(100),
    team_color VARCHAR(10),
    headshot_url VARCHAR(255),
    rarity VARCHAR(20),                -- Overall driver rarity (Legendary, Epic, Rare, Common)
    PRIMARY KEY (driver_id)
);

-- --------------------------------------------------------------------------
-- TABLE: events
-- Contains information about the specific race weekend.
-- --------------------------------------------------------------------------
CREATE TABLE events (
    round INT NOT NULL,                -- PRIMARY KEY: The race round number (e.g., 1)
    event_name VARCHAR(100),
    location VARCHAR(100),
    country VARCHAR(100),
    PRIMARY KEY (round)
);

-- --------------------------------------------------------------------------
-- TABLE: race_results
-- Stores specific race outcomes for a driver at a specific event.
-- --------------------------------------------------------------------------
CREATE TABLE race_results (
    id INT AUTO_INCREMENT NOT NULL,    -- PRIMARY KEY: Unique surrogate key for the result record
    driver_id VARCHAR(50) NOT NULL,    -- FOREIGN KEY: Points to driver_id in the 'drivers' table
    round INT NOT NULL,                -- FOREIGN KEY: Points to round in the 'events' table
    position INT,
    grid_position INT,
    points FLOAT,
    status VARCHAR(50),
    laps_completed INT,
    PRIMARY KEY (id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (round) REFERENCES events(round)
);

-- --------------------------------------------------------------------------
-- TABLE: lap_times
-- Stores granular, lap-by-lap performance data for statistical analysis.
-- --------------------------------------------------------------------------
CREATE TABLE lap_times (
    id INT AUTO_INCREMENT NOT NULL,    -- PRIMARY KEY: Unique surrogate key for the lap record
    driver_id VARCHAR(50) NOT NULL,    -- FOREIGN KEY: Points to driver_id in the 'drivers' table
    round INT NOT NULL,                -- FOREIGN KEY: Points to round in the 'events' table
    lap_number INT,
    lap_time_seconds FLOAT,
    compound VARCHAR(20),
    tyre_life INT,
    position_at_lap INT,
    PRIMARY KEY (id),
    FOREIGN KEY (driver_id) REFERENCES drivers(driver_id),
    FOREIGN KEY (round) REFERENCES events(round)
);