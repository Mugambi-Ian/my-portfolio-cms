FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Africa/Nairobi /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

# Installing libvips-dev for sharp Compatibility
RUN apt update && apt install build-essential gcc curl autoconf automake zlib1g libpng-dev nasm bash libvips-dev git cron -y

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt install nodejs -y

WORKDIR /opt/app

COPY ./package.json ./package.json
COPY ./yarn.lock ./yarn.lock
RUN npm i -g yarn
RUN yarn global add node-gyp
RUN yarn config set network-timeout 600000 -g && yarn install
ENV PATH /opt/app/node_modules/.bin:$PATH

COPY . .

RUN ["yarn", "build"]
EXPOSE 1337

# Start cron and then the application
CMD ["/bin/bash", "-c", "yarn start"]
