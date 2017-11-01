# Cinema Exploration with Apache Cassandra and Spark

## Outline
This project is open source and contains scripts and instruction that:
  1. set up AWS Free Tier account,
  2. launch and ssh into AWS EC2 instance,
  3. download files stored in AWS S3 using AWS Java SDK
  4. perform data ETL and denormalization using Python Pandas
  5. install Docker and build a Cassandra cluster on AWS EC2
  6. create keyspaces and tables in Cassandra
  7. load csv files into Cassandra tables
  8. use Spark and Jupyter to analyze data in Cassandra
  
### Data Sources:
1. IMDB datasets: http://www.imdb.com/interfaces/
2. GroupLens datasets: https://grouplens.org/datasets/movielens/

### Set up AWS Free Tier:
https://aws.amazon.com/free/

### Launch AWS EC2 instance:
Once your AWS Free Tier account is created, proceed to AWS Dashboard, click 'EC2' under 'Compute' section to proceed to EC2 Dashboard
1. Click 'Launch instance' button
2. Select a prefered Amazon Machine Image (AMI), e.g. Amazon Linux AMI, which is free for free tier subscription
3. Select an instance type. Different types have different CPU, RAM, storage and prices. t2.micro is free for free tier subscription, pleace see pricing for other instance types here: https://aws.amazon.com/ec2/pricing/
4. Review and launch

### SSH into AWS EC2 instance:
1. Go to EC2 Dashboard
2. Click 'Key Pairs' under 'Resources' section
3. Click 'Create Key Pair' and input a name for the new key pair e.g. test
4. A pem file will be automatically downloaded, which is your key
5. Click 'Instances' on left menu
6. Select a running instance (if none is running, click 'Actions' -> 'Instance State' -> Start)
7. Click 'Actions' -> 'Connect'
8. Copy the ssh command under 'Examples' section, which should look like:
    ssh -i "test.pem" ec2-user@ec2-xx-xxx-xxx-x.xxx.compute.amazonaws.com
9. Open your cmd, type following command (replace test.pem with your the name of your pem file):
    chmod 400 test.pem
10. Type the ssh command you copied at step 8 into cmd

### Request imdb datasets on AWS S3:
IMDB datasets are located in the AWS S3 bucket named “imdb-datasets” and can be accessed by using the REST API or the AWS SDK wrapper libraries. Follow these steps to download files from AWS S3 using AWS Java SDK and Toolkit for Eclipse:
1. Download Eclipse if you don't have it
2. Install AWS Toolkit for Eclipse by following steps on https://aws.amazon.com/eclipse/
3. Log in using your AWS Account
4. Refer GetObject.java to download files from AWS S3
    Note: you will need to change file names and local path to store files
    
### Perform data ETL and denormalization using Python Pandas:
  Refer grouplens_denorm_clean.py and imdb_denorm_clean.py

### Install Docker on AWS EC2
Refer to installDocker.sh
For more info: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/docker-basics.html

### Build a Cassandra cluter on AWS EC2
Refer to create_Cassandra_cluster.sh
For more info: https://hub.docker.com/_/cassandra/

### Create keyspaces and tables in Cassandra
Refer to create_keyspace_tables.cql

### Load csv files into Cassandra tables
Refer to import_csv.cql

### Use Spark and Jupyter to analyze data in Cassandra
Refer to analyze-data-by-spark.ipynb which demonstrate to how to connect Spark to Cassandra and use Spark SQL to perform data analysis on Cassandra data





