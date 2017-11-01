CREATE KEYSPACE movies WITH REPLICATION = 
{ 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

CREATE TABLE movies.unique_tags (
        userId bigint,
        movieId bigint,
        tag text,
        timestamp bigint,
        PRIMARY KEY (userId, movieId, tag)
       );

CREATE TABLE movies.ratings (
        userId bigint,
        movieId bigint,
        rating float,
	timestamp bigint,
        PRIMARY KEY (userId, movieId)
       );

CREATE TABLE movies.links (
        movieId bigint,
        imbdId bigint,
        tmbbId bigint,
        PRIMARY KEY (movieId, imbdId)
       );

COPY movies.ratings FROM  'data/grouplens_data/ratings.csv' WITH HEADER=TRUE;
COPY movies.links FROM  'data/grouplens_data/links.csv' WITH HEADER=TRUE;
