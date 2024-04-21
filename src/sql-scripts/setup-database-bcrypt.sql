USE employee_directory;

DROP TABLE IF EXISTS authorities;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
	username VARCHAR(50) NOT NULL,
    password CHAR(68) NOT NULL,
    enabled TINYINT NOT NULL,
    PRIMARY KEY(username)
);

INSERT INTO users VALUES
	('john', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1),
    ('mary', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1),
    ('susan', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1);
    
CREATE TABLE authorities
(
	username VARCHAR(50) NOT NULL,
    authority VARCHAR(50) NOT NULL,
    UNIQUE (username, authority),
    CONSTRAINT authorities_fgk FOREIGN KEY (username)
    REFERENCES users (username)
);

INSERT INTO authorities VALUES
	('john', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_MANAGER'),
    ('susan', 'ROLE_EMPLOYEE'),
    ('susan', 'ROLE_MANAGER'),
    ('susan', 'ROLE_ADMIN');