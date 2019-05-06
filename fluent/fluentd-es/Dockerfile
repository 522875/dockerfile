FROM gcr.io/google_containers/fluentd-elasticsearch:1.22
RUN apt-get install -y gem
RUN gem install rubygems-update && update_rubygems &&gem update --system
