FROM ruby

RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN apt-get update
RUN apt-get install -y python3-pip
RUN gem install bundler
ADD . /itamae-plugin-resource-pip
WORKDIR /itamae-plugin-resource-pip
RUN bundle install --path .bundle/gems
RUN bundle exec itamae local ./samples/recipe.rb
