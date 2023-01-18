FROM ruby:3.0.2-alpine

RUN apk add --update --no-cache \
  build-base \
  postgresql-dev \
  nodejs \
  yarn \
  git \
  tzdata \
  && rm -rf /var/cache/apk/*

ENV BUNDLER_VERSION 2.3.17
ENV BUNDLE_WITHOUT development:test
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

RUN gem install bundler -v $BUNDLER_VERSION

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle config build.nokogiri --use-system-libraries
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

COPY . ./

RUN rails webpacker:compile

CMD ["rails", "s", "-b", "0.0.0.0"]

EXPOSE 3000
