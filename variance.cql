# Code adapted from example at: https://streamsets.com/blog/standard-deviation-cassandra-aggregate-function/

CREATE OR REPLACE FUNCTION movies.varState ( state tuple<int,double,double>, val double ) CALLED ON NULL INPUT RETURNS tuple<int,double,double> LANGUAGE java AS 'int n = state.getInt(0); double mean = state.getDouble(1); double m2 = state.getDouble(2); n++; double delta = val - mean; mean += delta / n; m2 += delta * (val - mean); state.setInt(0, n); state.setDouble(1, mean); state.setDouble(2, m2); return state;';


CREATE OR REPLACE FUNCTION movies.varFinal ( state tuple<int,double,double> ) CALLED ON NULL INPUT RETURNS double LANGUAGE java AS 'int n = state.getInt(0); double m2 = state.getDouble(2); if (n < 1) { return null; } return (m2 / (n - 1));';


CREATE OR REPLACE AGGREGATE movies.var ( double ) SFUNC varState STYPE tuple<int,double,double> FINALFUNC varFinal INITCOND (0,0,0);
SELECT var(rating) FROM movies.ratings WHERE userid = 1535;
