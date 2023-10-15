
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
('My Hero', '04:21', 1),
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

SELECT track_name, duration 
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

SELECT track_name, duration 
FROM tracks 
WHERE duration >= '00:03:30';

SELECT compilation_name 
FROM Compilations 
WHERE release_year BETWEEN 2018 AND 2020;

SELECT artist_name 
FROM Artists 
WHERE artist_name NOT LIKE '% %';

SELECT track_name 
FROM tracks 
where track_name ILIKE '%my%';

SELECT g.genre_name, COUNT(a.artist_id) AS artist_count
FROM Genres g
JOIN Genres_Artists ga ON g.genre_id = ga.genre_id
JOIN Artists a ON ga.artist_id = a.artist_id
GROUP BY g.genre_name;

SELECT COUNT(t.track_id) AS track_count
FROM tracks t
JOIN Albums a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

SELECT a.album_name, AVG(
    CAST(SUBSTRING(t.duration FROM 1 FOR 2) AS INTEGER) * 60 + 
    CAST(SUBSTRING(t.duration FROM 4 FOR 2) AS INTEGER)
) AS avg_duration_seconds
FROM tracks t
JOIN Albums a ON t.album_id = a.album_id
GROUP BY a.album_name;

SELECT a.artist_name
FROM Artists a
WHERE a.artist_id NOT IN (
    SELECT aa.artist_id
    FROM Artists_Albums aa
    JOIN Albums al ON aa.album_id = al.album_id
    WHERE al.release_year = 2020
);

SELECT c.compilation_name
FROM Compilations c
JOIN Tracks_Compilations tc ON c.compilation_id = tc.compilation_id
JOIN tracks t ON tc.track_id = t.track_id
JOIN Albums a ON t.album_id = a.album_id
JOIN Artists_Albums aa ON a.album_id = aa.album_id
JOIN Artists art ON aa.artist_id = art.artist_id
WHERE art.artist_name = 'Jay Z';


