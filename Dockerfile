FROM ruby
RUN mkdir -p /opt/docking/vendor
RUN mkdir -p /opt/bundle
WORKDIR /opt/docking
ADD ./Gemfile /opt/docking/Gemfile
ADD ./Gemfile.lock /opt/docking/Gemfile.lock
ADD ./.gemrc /usr/local/etc/gemrc

VOLUME /artifacts

RUN bundle install --path /opt/bundle --deployment
ADD . /opt/docking
CMD bundle exec rails s