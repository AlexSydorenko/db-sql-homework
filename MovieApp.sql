-- Create custom ENUM types
CREATE TYPE gender_enum AS ENUM ('Male', 'Female', 'Other');
CREATE TYPE role_enum AS ENUM ('leading', 'supporting', 'background');

-- Create File table
CREATE TABLE File (
    id SERIAL PRIMARY KEY,
    file_name VARCHAR(255) NOT NULL,
    mime_type VARCHAR(50) NOT NULL,
    key VARCHAR(255) NOT NULL,
    url VARCHAR(255) NOT NULL
);

-- Create User table
CREATE TABLE "User" (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_file_id INT,
    FOREIGN KEY (avatar_file_id) REFERENCES File(id)
); 

-- Create Country table
CREATE TABLE Country (
    id SERIAL PRIMARY KEY,
    country_name VARCHAR(100) NOT NULL
);

-- Create Person table
CREATE TABLE Person (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    biography TEXT,
    date_of_birth DATE,
    gender gender_enum NOT NULL,
    country_id INT,
    primary_photo_file_id INT,
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (primary_photo_file_id) REFERENCES File(id)
);

-- Create Movie table
CREATE TABLE Movie (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    budget DECIMAL(15, 2),
    release_date DATE,
    duration INT,
    director_id INT,
    country_id INT,
    poster_file_id INT,
    FOREIGN KEY (director_id) REFERENCES Person(id),
    FOREIGN KEY (country_id) REFERENCES Country(id),
    FOREIGN KEY (poster_file_id) REFERENCES File(id)
);

-- Create Character table
CREATE TABLE Character (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    role role_enum NOT NULL,
    movie_id INT,
    person_id INT,
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

-- Create Genre table
CREATE TABLE Genre (
    id SERIAL PRIMARY KEY,
    genre_name VARCHAR(50) NOT NULL
);

-- Create FavoriteMovies table
CREATE TABLE FavoriteMovies (
    user_id INT,
    movie_id INT,
    PRIMARY KEY (user_id, movie_id),
    FOREIGN KEY (user_id) REFERENCES "User"(id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id)
);

-- Create MovieGenre table
CREATE TABLE MovieGenre (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES Movie(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

-- Create PersonPhoto table
CREATE TABLE PersonPhoto (
    person_id INT,
    file_id INT,
    PRIMARY KEY (person_id, file_id),
    FOREIGN KEY (person_id) REFERENCES Person(id),
    FOREIGN KEY (file_id) REFERENCES File(id)
);
