FROM ubuntu:22.10
RUN apt update
RUN apt install maven -y
RUN mkdir /app
ADD . /app
WORKDIR /app
