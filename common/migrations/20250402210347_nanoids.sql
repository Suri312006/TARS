-- Drop existing tables (in reverse order due to foreign key constraints)
DROP TABLE IF EXISTS Tasks;
DROP TABLE IF EXISTS Groups;

-- Create new tables with updated schema
CREATE TABLE Groups (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pub_id VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE TABLE Tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pub_id VARCHAR(255) NOT NULL UNIQUE,
    group_id VARCHAR(255) NOT NULL,  -- Changed to VARCHAR to match Groups.pub_id
    name VARCHAR(255) NOT NULL,
    priority INTEGER NOT NULL,
    description TEXT NOT NULL,
    due DATETIME,
    completed BOOLEAN DEFAULT FALSE NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    FOREIGN KEY (group_id) REFERENCES Groups (pub_id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create indexes on pub_id for faster lookups
CREATE INDEX idx_groups_pub_id ON Groups (pub_id);
CREATE INDEX idx_tasks_pub_id ON Tasks (pub_id);
CREATE INDEX idx_tasks_group_id ON Tasks (group_id);  -- Additional index for the foreign key
