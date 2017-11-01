# create Cassandra Docker container
docker run --name CDB -d cassandra:latest

# start cqlsh
docker run -it --link CDB:cassandra --rm cassandra cqlsh cassandra

# inspect IP address of CDB
docker inspect --format='{{ .NetworkSettings.IPAddress }}' CDB

# create a new Cassandra container on a new VM
docker run --name CDB2 -d cassandra:latest

# connect the 2nd Cassandra container to the 1st one
docker run --name CDB2 -m 2g -d \ -e CASSANDRA_SEEDS=<CDB_ip_address> \ cassandra:latest

# now we have a 2-node cluster
