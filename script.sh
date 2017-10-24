#!/bin/bash
cqlsh -e "SOURCE 'setup.cql'"
cqlsh -e "SOURCE 'imdb_basics.cql'"
cqlsh -e "SOURCE 'unique_tags.cql'"
python app.py
