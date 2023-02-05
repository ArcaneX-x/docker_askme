FROM ruby:3.1.3

RUN apt-get update -qq && apt-get -y install apache2-utils

WORKDIR /rails

# Set production environment
ENV RAILS_LOG_TO_STDOUT="1" \
    RAILS_SERVE_STATIC_FILES="true" \
    RAILS_ENV="production" \
    BUNDLE_WITHOUT="development"

COPY . .

RUN chmod +x /rails/bin/docker-entrypoint

EXPOSE 3000

RUN bundle install

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker-entrypoint"]
CMD ["./bin/rails", "server"]