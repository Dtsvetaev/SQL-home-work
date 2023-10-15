
CREATE TABLE Musicalgenre (
    Musicalgenre_id INT PRIMARY KEY,
    name VARCHAR(255)
);


CREATE TABLE Singer (
    singer_id INT PRIMARY KEY,
    name VARCHAR(255),
    Singergenre_id INT,
    FOREIGN KEY (Singergenre_id) REFERENCES SingerGenre(Musicalgenre_id)
);

CREATE TABLE Album (
    album_id INT PRIMARY KEY,
    name VARCHAR(255),
    release_year INT
);


CREATE TABLE PoolSinger (
    singer_id INT,
    album_id INT,
    FOREIGN KEY (singer_id) REFERENCES Singer(singer_id),
    FOREIGN KEY (album_id) REFERENCES Album(album_id)
);


CREATE TABLE Song (
    song_id INT PRIMARY KEY,
    name VARCHAR(255),
    duration INT,
    album_id INT,
    FOREIGN KEY (album_id) REFERENCES Album(album_id)
);


CREATE TABLE Collection (
    collection_id INT,
    compilation_name VARCHAR(255),
    release_year INT
);


CREATE TABLE SongCollection (
    collection_id INT,
    song_id INT,
    FOREIGN KEY (collection_id) REFERENCES Collection(collection_id),
    FOREIGN KEY (song_id) REFERENCES Song(song_id)
);

CREATE TABLE SingerGenre (
    Musicalgenre_id INT,
    singergenre_id INT,
    FOREIGN KEY (Musicalgenre_id) REFERENCES Musicalgenre(Musicalgenre_id),
    FOREIGN KEY (singergenre_id) REFERENCES Singer(singer_id)
);
