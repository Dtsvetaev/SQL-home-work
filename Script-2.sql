
CREATE table IF NOT EXISTS Genres (
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT exists Artists (
    artist_id SERIAL PRIMARY KEY,
    artist_name VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT exists Albums (
    album_id SERIAL PRIMARY KEY,
    album_name VARCHAR(255) NOT NULL,
    release_year INT NOT NULL
);

CREATE TABLE IF NOT exists tracks (
    track_id SERIAL PRIMARY KEY,
    track_name VARCHAR(255) NOT NULL,
    duration TIME NOT NULL,
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);

CREATE table IF NOT EXISTS Compilations (
    compilation_id SERIAL PRIMARY KEY,
    compilation_name VARCHAR(255) NOT NULL,
    release_year INT NOT NULL
);


CREATE table IF NOT EXISTS Genres_Artists (
    genre_id INT,
    artist_id INT,
    PRIMARY KEY (genre_id, artist_id),
    FOREIGN KEY (genre_id) REFERENCES Genres(genre_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

CREATE TABLE IF NOT exists Artists_Albums (
    artist_id INT,
    album_id INT,
    PRIMARY KEY (artist_id, album_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id),
    FOREIGN KEY (album_id) REFERENCES Albums(album_id)
);

CREATE TABLE IF NOT exists Tracks_Compilations (
    track_id INT,
    compilation_id INT,
    PRIMARY KEY (track_id, compilation_id),
    FOREIGN KEY (track_id) REFERENCES tracks(track_id),
    FOREIGN KEY (compilation_id) REFERENCES Compilations(compilation_id)
);

ALTER TABLE tracks
ALTER COLUMN duration TYPE VARCHAR(255);

INSERT INTO Genres (genre_name) VALUES 
('Rock'),
('Pop'),
('Hip-Hop'),
('Electronic');


INSERT INTO Artists (artist_name) VALUES 
('Nickleback'),
('Beyonce'),
('Jay Z'),
('The Prodigy');


INSERT INTO Albums (album_name, release_year) VALUES 
('All the Right Reasons', 2005),     -- Nickleback
('Lemonade', 2016),                  -- Beyonce
('The Blueprint', 2001),             -- Jay Z
('The Fat of the Land', 1997);       -- The Prodigy


INSERT INTO tracks  (track_name, duration, album_id) VALUES 
('Photograph', '04:19', 1),
('Rockstar', '04:15', 1),
('Formation', '03:26', 2),
('Sorry', '03:53', 2),
('Izzo (H.O.V.A.)', '04:00', 3),
('Girls, Girls, Girls', '04:35', 3),
('Breathe', '05:35', 4),
('Firestarter', '04:40', 4);


INSERT INTO Compilations (compilation_name, release_year) VALUES 
('Best of 2000s', 2010),
('Pop Divas', 2018),
('Hip-Hop Legends', 2019),
('Electro Icons', 2015);


INSERT INTO Genres_Artists (genre_id, artist_id) VALUES 
(1, 1), -- Nickleback - Rock
(2, 2), -- Beyonce - Pop
(3, 3), -- Jay Z - Hip-Hop
(4, 4) -- The Prodigy - Electronic
ON CONFLICT (genre_id, artist_id) DO NOTHING;

INSERT INTO Artists_Albums (artist_id, album_id) VALUES 
(1, 1), -- Nickleback - All the Right Reasons
(2, 2), -- Beyonce - Lemonade
(3, 3), -- Jay Z - The Blueprint
(4, 4) -- The Prodigy - The Fat of the Land
ON CONFLICT (artist_id, album_id) DO NOTHING;

INSERT INTO Tracks_Compilations (track_id, compilation_id) VALUES 
(1, 1), -- Photograph - Best of 2000s
(2, 1), -- Rockstar - Best of 2000s
(3, 2), -- Formation - Pop Divas
(4, 2), -- Sorry - Pop Divas
(5, 3), -- Izzo (H.O.V.A.) - Hip-Hop Legends
(6, 3), -- Girls, Girls, Girls - Hip-Hop Legends
(7, 4), -- Breathe - Electro Icons
(8, 4) -- Firestarter - Electro Icons
ON CONFLICT (track_id, compilation_id) DO NOTHING;