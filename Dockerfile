FROM ruby:2.6.1
MAINTAINER Giovanni Naufal <gionaufal@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential vim
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN bundle install
ADD . $APP_HOME
