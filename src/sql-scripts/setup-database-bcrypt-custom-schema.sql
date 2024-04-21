USE employee_directory;

DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS members;

CREATE TABLE members
(
	user_custom_name VARCHAR(50) NOT NULL,
    pass CHAR(68) NOT NULL,
    active TINYINT NOT NULL,
    PRIMARY KEY(user_custom_name)
);

INSERT INTO members VALUES
	('john', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1),
    ('mary', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1),
    ('susan', '{bcrypt}$2a$10$W7r1SnLvmbfsGktTos.iOOlTfcJ2CLyt1n3a96GzsmbTQvBT7ieOa', 1);
    
CREATE TABLE roles
(
	user_custom_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    UNIQUE (user_custom_name, role),
    CONSTRAINT authorities_fgk FOREIGN KEY (user_custom_name)
    REFERENCES members (user_custom_name)
);

INSERT INTO roles VALUES
	('john', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_EMPLOYEE'),
    ('mary', 'ROLE_MANAGER'),
    ('susan', 'ROLE_EMPLOYEE'),
    ('susan', 'ROLE_MANAGER'),
    ('susan', 'ROLE_ADMIN');