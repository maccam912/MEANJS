FROM ubuntu
MAINTAINER Matt Koski <maccam912@gmail.com>

RUN apt-get update && apt-get upgrade -y
RUN apt-get install git python build-essential wget screen tmux curl vim mongodb-org -y
RUN mkdir /data
RUN mkdir /data/db

RUN sudo service mongod start

RUN mkdir /Development
RUN cd /Development && git clone git://github.com/joyent/node

RUN cd /Development/node && ./configure && make && make install
RUN rm -rf /Development/node
RUN chmod 777 -R /Development

RUN npm install -g bower grunt-cli yo generator-meanjs express

RUN mongod &

RUN cd /Development && git clone https://github.com/angular/angular-seed.git

EXPOSE 80:80
EXPOSE 443:443
EXPOSE 3000:3000
EXPOSE 27017:27017
EXPOSE 9000:9000



RUN echo "\n##############################\n1. Create a new user with adduser, 'su' into that user.\n2. 'yo meanjs' to scaffold your app in the current directory.\n3. Start mongo in the background (e.g. 'mongod &')\n##############################\n"
