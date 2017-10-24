# Use an official Python runtime as a parent image
FROM cassandra:latest

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

# Install any needed packages specified in requirements.txt
RUN echo "enable_user_defined_functions: true" >> /etc/cassandra/cassandra.yaml
RUN apt-get -y update
RUN apt-get install -y python
RUN apt-get install -y python-pip
RUN apt-get install -y python-pandas
RUN pip install cassandra-driver

# Run app.py when the container launches
#CMD [""]
