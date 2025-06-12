FROM ruby:3.1.4
ENV LANG C.UTF-8
ENV TZ Asia/Tokyo
RUN gem install rails -v "7.0.3.1"
RUN echo "require 'logger'" >> /usr/local/lib/ruby/site_ruby/logger_patch.rb
ENV RUBYOPT="-r/usr/local/lib/ruby/site_ruby/logger_patch.rb"
RUN apt-get update -qq && \
    apt-get install -y curl gnupg build-essential libpq-dev && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn
RUN mkdir /v3_apuri
WORKDIR /v3_apuri
RUN gem install bundler:2.3.17
COPY Gemfile /v3_apuri/Gemfile
COPY Gemfile.lock /v3_apuri/Gemfile.lock
COPY yarn.lock /v3_apuri/yarn.lock
RUN bundle install
RUN yarn install
COPY . /v3_apuri
