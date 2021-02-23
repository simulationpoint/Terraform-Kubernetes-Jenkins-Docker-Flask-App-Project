# Program: Dockerfile -> build images 
# Name: Jesh Amera
# Date created: 01/18/2021

FROM ubuntu:16.04

RUN apt-get update -y && \
    apt-get install -y python-pip python-dev

COPY ./requirements.txt /app/requirements.txt

WORKDIR /app

RUN pip install -r requirements.txt

EXPOSE 9090

COPY . /app

ENTRYPOINT [ "python" ]
CMD [ "web.py" ]

