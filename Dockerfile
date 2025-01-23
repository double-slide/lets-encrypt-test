# Specify base image
FROM ruby:3.2.2

# Add application code
ADD . /dev-blog
WORKDIR /dev-blog

# Install utilities
RUN apt-get update
RUN apt-get -y install vim

# Install dependencies
RUN bundle install

# Precompile assets - only required for non-API apps
RUN rake assets:precompile

# Set up env
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY ./bin/entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose port
EXPOSE 3000

# Run server when container starts
CMD ["rails", "server", "-b", "0.0.0.0"]

