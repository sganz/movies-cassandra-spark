import pandas as pd
import numpy as np
import re

df_movies = pd.read_csv('data/grouplens_data/movies.csv')
df_links = pd.read_csv('data/grouplens_data/links.csv')
df_ratings = pd.read_csv('data/grouplens_data/ratings.csv')
df_tags = pd.read_csv('data/grouplens_data/tags.csv')

df_genres_only = df_movies['genres'].str.get_dummies(sep='|')
df_genres = pd.concat([df_movies['movieId'],df_genres_only], axis=1)
#df_genres.to_csv('genres.csv',header=True, index=False)

all_genres = list(df_genres.columns)

from cassandra.query import dict_factory
from cassandra.cluster import Cluster
cluster = Cluster()
session = cluster.connect('movies')
session.row_factory = dict_factory

for i, s in enumerate(all_genres):
    s = s.replace(" ","_")
    all_genres[i] = re.sub(r'[\W]+', '', s)  

query_str = "CREATE TABLE movies.genres_count (movieid bigint, "
for genre in all_genres[1:]:
    query_str+= genre + " int, "
query_str+= "PRIMARY KEY (movieid));"
session.execute(query_str)

insert_str="INSERT INTO movies.genres_count ("
for genre in all_genres:
    insert_str+= genre +","
insert_str = insert_str[:-1] + ") VALUES (" + ("%s,"*len(all_genres))[:-1] + ")"

for i in range(df_genres.shape[0]):
    result = session.execute(insert_str, list(df_genres.iloc[i]))

out_file = open("output.data","a")
for genre in all_genres[1:]:
    res = session.execute("SELECT sum({0}) FROM movies.genres_count".format(genre))
    out_str = "{0}:{1}".format(genre,res[0]['system.sum({0})'.format(genre.lower())])
    print (out_str)
    out_file.write(out_str+"\n")
#movieID,imdbID,tmdbId,title,genres,
#(userId,movieId) -> rating,timestamp  ,tag,timestamp