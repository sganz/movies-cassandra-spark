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

 CREATE TABLE movies.imdb_basics ( 
   tconst text PRIMARY KEY,
   titleType text,
   primaryTitle text,
   isAdult boolean,
   startYear double,
   endYear double,
   runtimeMinutes double,
   genres text,
   directors text,
   writers text,
   principalCast text,
   averageRating double,
   numVotes double
) ;