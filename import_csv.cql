COPY movies.ratings FROM  'data/grouplens_data/ratings.csv' WITH HEADER=TRUE;
COPY movies.links FROM  'data/grouplens_data/links.csv' WITH HEADER=TRUE;
COPY movies.imdb_basics(tconst,titleType,primaryTitle,isAdult,endYear,runtimeMinutes,genres,directors,writers,principalCast,averageRating,numVotes) FROM 'data/imdb_denorm_small.csv' WITH HEADER = TRUE AND BOOLSTYLE = '1,0';