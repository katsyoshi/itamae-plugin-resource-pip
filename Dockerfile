FROM themattrix/pyenv

RUN apt update
RUN apt install -y --force-yes build-essential curl git
RUN apt install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev
RUN apt-get clean
RUN git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /root/.rbenv/plugins/ruby-build
RUN ./root/.rbenv/plugins/ruby-build/install.sh
ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
ENV CONFIGURE_OPTS --disable-install-doc
ADD ./ruby-versions.txt /root/versions.txt
RUN xargs -L 1 rbenv install < /root/versions.txt
RUN echo 'gem: --no-rdoc --no-ri' >> /.gemrc
RUN bash -l -c 'for v in $(cat /root/versions.txt); do rbenv global $v; gem install bundler; done'
ADD . /itamae-plugin-resource-pip
WORKDIR /itamae-plugin-resource-pip
RUN bundle install --path .bundle/gems
RUN bundle exec itamae local ./samples/recipe.rb
