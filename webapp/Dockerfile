#Start by pulling the python image
FROM python:latest
# Copy the requirements file into the image
COPY ./requirements.txt /app/requirements.txt
# install the requirements.txt
RUN pip install -r requirements.txt
# copy the complete python program
COPY . /app
# configure container to run the python program as starting point
ENTRYPOINT [ "python" ]
CMD [ "trdl.py" ]