#Start by pulling the python image
FROM python:3.6-slim

RUN apt-get -y update

RUN apt-get -y install nginx


RUN apt-get -y install python3-dev
RUN apt-get -y install build-essential

#Create a new directory app
RUN mkdir /app
#Make the workdir
WORKDIR /app
# Copy the requirements file into the image
COPY webapp/requirements.txt .
# install the requirements.txt
RUN ls -ll
RUN pip install -r requirements.txt

# copy the code to appropriate locations
COPY webapp/trdl.py /app/trdl.py
COPY webapp/startup.sh /app/startup.sh
COPY webapp/uwsgi.ini /app/uwsgi.ini

COPY webapp/nginx.conf /etc/nginx

#Make the startup executable, expose port 80 and run startup file for nginx.
RUN chmod +x ./startup.sh

EXPOSE 8080

CMD [ "./startup.sh" ]
