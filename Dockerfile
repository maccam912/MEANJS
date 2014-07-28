FROM phusion/baseimage
MAINTAINER Matt Koski <maccam912@gmail.com>

RUN apt-get upgrade && apt-get update -y
RUN apt-get install git python build-essential wget screen tmux curl vim -y

RUN mkdir /Development
RUN cd /Development && git clone git://github.com/joyent/node

RUN cd /Development/node && ./configure && make && make install
RUN rm -rf /Development/node

RUN npm install -g bower grunt-cli yo generator-meanjs

RUN cd /Development && curl -O http://downloads.mongodb.org/linux/mongodb-linux-x86_64-2.6.3.tgz && tar -zxvf mongodb-linux-x86_64-2.6.3.tgz && mkdir -p mongodb && cp -R -n mongodb-linux-x86_64-2.6.3/ mongodb

RUN export PATH=/Development/mongodb:$PATH

RUN mkdir -p /data/db
RUN mongod

curl https://j.mp/spf13-vim3 -L > spf13-vim.sh && sh spf13-vim.sh

EXPOSE 80:80
EXPOSE 443:443
EXPOSE 3000:3000



RUN echo "Run 'yo meanjs myApp', cd into 'myApp', and run 'grunt' to start the service."
