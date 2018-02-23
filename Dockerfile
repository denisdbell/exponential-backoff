FROM ruby:2.5-alpine3.7

MAINTAINER Denis Bell <denisdbell@gmail.com>

RUN apk add --no-cache git

RUN mkdir /usr/app

COPY . /usr/app

WORKDIR /usr/app/

RUN bundle install

ENTRYPOINT ["ruby", "lib/start_back_off.rb"]