FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /nile
WORKDIR /nile

ADD Gemfile /nile/Gemfile
ADD Gemfile.lock /nile/Gemfile.lock

RUN bundle install

ADD . /nile