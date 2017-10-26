### All original imdb tsv files are retrived from Amazon S3 bucket on 09/27/2017
## /N denotes NULL value
## title.basics.tsv
# row count = 4536820
# /N count = 2259 -- originalTitle
# /N count = 1 -- isAdult
# /N count = 322116 -- startYear
# /N count = 4504051 -- endYear
# /N count = 3140191 -- runtimeMinutes
# /N count = 526726 -- genres

## title.crew.tsv
# row count = 4536820
# /N count = 1972950 -- directors
# /N count = 2335513 -- writers

## title.principals.tsv
# row count = 4009811
# /N count = 0

## title.ratings.tsv
# row count = 767374
# averageRating MAX = 10.0
# averageRating MIN = 1.0
# numVotes MAX = 1859042
# numVotes MIN = 5

## name.basics.tsv
# row count = 8155447

### python script to join imdb tsv files and convert to csv files on 10/15/2017
## /N is regarded as NULL 
basic = pandas.read_csv('~/imdb/title.basics.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
crew = pandas.read_csv('~/imdb/title.crew.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
cast = pandas.read_csv('~/imdb/title.principals.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
rating = pandas.read_csv('~/imdb/title.ratings.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
names = pandas.read_csv('~/imdb/name.basics.tsv', sep='\t', header=0, index_col='nconst', na_values = '\\N')

## optional: drop columns
basic=basic.drop(['titleType','endYear','originalTitle', "isAdult", "runtimeMinutes"], axis=1)
crew=crew.drop(['writers'], axis=1)

## optional: convert type to int
basic["startYear"] = basic["startYear"].fillna(0.0).astype(int)

## join tables
basic_crew = basic.join(crew)
basic_crew_cast = basic_crew.join(cast)
basic_crew_cast_rating = basic_crew_cast.join(rating)

## output denormalized table to csv
basic_crew_cast_rating.to_csv('~/imdb/imdb_denorm.csv') # 753.8 Mb
names.to_csv("~/imdb/names.csv") # 473.8 Mb

### Import imdb_denorm.csv and names.csv to Cassandra
