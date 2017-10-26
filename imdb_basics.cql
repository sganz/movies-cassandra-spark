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


COPY movies.imdb_basics(tconst,titleType,primaryTitle,isAdult,endYear,runtimeMinutes,genres,directors,writers,principalCast,averageRating,numVotes) FROM 'data/imdb_denorm_small.csv' WITH HEADER = TRUE AND BOOLSTYLE = '1,0';
