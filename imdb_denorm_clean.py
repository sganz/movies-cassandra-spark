### python script to join imdb tsv files and convert to csv files on 10/15/2017
## /N is regarded as NULL 
basic = pandas.read_csv('~/imdb/title.basics.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
crew = pandas.read_csv('~/imdb/title.crew.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
cast = pandas.read_csv('~/imdb/title.principals.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
rating = pandas.read_csv('~/imdb/title.ratings.tsv', sep='\t', header=0, index_col='tconst', na_values = '\\N')
names = pandas.read_csv('~/imdb/name.basics.tsv', sep='\t', header=0, index_col='nconst', na_values = '\\N')

## find null count, max and min values
basic.isnull().sum()
basic["startYear"].max()
basic["startYear"].min()

## drop columns
basic=basic.drop(['titleType','endYear','originalTitle', "isAdult", "runtimeMinutes"], axis=1)
crew=crew.drop(['writers'], axis=1)
names = names.drop(['birthYear','deathYear','primaryProfession','knownForTitles'], axis=1)

## optional: convert type to int
basic["startYear"] = basic["startYear"].fillna(0.0).astype(int)

## join tables
basic_crew = basic.join(crew)
basic_crew_cast = basic_crew.join(cast)
basic_crew_cast_rating = basic_crew_cast.join(rating)

## output denormalized table to csv
basic_crew_cast_rating.to_csv('~/imdb/imdb_denorm.csv') # 753.8 Mb
names.to_csv("~/imdb/names.csv") # 473.8 Mb
