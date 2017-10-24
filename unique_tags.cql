CAPTURE 'output.data'

COPY movies.unique_tags FROM  'data/grouplens_data/tags.csv' WITH HEADER=TRUE;
  
CREATE OR REPLACE FUNCTION uniq(state set<text>, val text)
  CALLED ON NULL INPUT RETURNS set<text> LANGUAGE java
  AS 'state.add(val); return state;';
CREATE OR REPLACE FUNCTION setCount (state set<text>) CALLED ON NULL INPUT RETURNS int LANGUAGE java AS 
  'return state.size();';
CREATE OR REPLACE AGGREGATE uniq(text)
  SFUNC uniq STYPE set<text> FINALFUNC setCount INITCOND {};

SELECT uniq(tag) FROM movies.unique_tags;

CAPTURE OFF
