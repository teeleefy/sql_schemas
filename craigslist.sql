-- Design a schema for Craigslist! Your schema should keep track of the following

-- - The region of the craigslist post (San Francisco, Atlanta, Seattle, etc)
-- - Users and preferred region
-- - Posts: contains title, text, the user who has posted, the location of the posting, the region of the posting
-- - Categories that each post belongs to

-- from the terminal run:
-- psql < craigslist.sql


DROP DATABASE IF EXISTS craigslist;

CREATE DATABASE craigslist;


\c craigslist


CREATE TABLE region (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL,
    location INTEGER REFERENCES region ON DELETE SET NULL
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    posted_by INTEGER REFERENCES users ON DELETE CASCADE,
    title TEXT NOT NULL,
    description TEXT,
    category INTEGER REFERENCES categories ON DELETE SET NULL,
    price MONEY NOT NULL, 
    street TEXT,
    location INTEGER REFERENCES region ON DELETE SET NULL
);


INSERT INTO region
(name) VALUES 
('San Franscisco'),
('Seattle'),
('Atlanta');

INSERT INTO categories
(name) VALUES 
('Animals'),
('Vehicles'),
('Furniture');

INSERT INTO users
(username, location) VALUES 
('Katz', 1),
('Moore', 2),
('Patel', 3);

INSERT INTO posts
(posted_by, title, description, category, price, street, location) VALUES 
(3,'Mini Dauschund','Cute brown and white puppy.', 1,'$295.00', '111 Taco Lane', 2),
(1,'Mini Cooper','2023 Sky Blue Mini Cooper', 2,'$29995.00','222 Taco Lane', 3),
(2,'Loveseat','Red sofa- fits only two.', 3,'$595.00', '333 Taco Lane', 1);
