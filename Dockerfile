FROM jetbrains/teamcity-agent:2019.1-linux
MAINTAINER Julien Enocq <julien@enocq.fr>

ENV USER buildagent
ENV HOME /home/${USER}
ENV PATH ${HOME}/.rbenv/bin:$HOME/.rbenv/shims:${PATH}
ENV RBENV ${HOME}/.rbenv

RUN apt-get -q update \
  && DEBIAN_FRONTEND=noninteractive apt-get -q -y --no-install-recommends install \
       autoconf bison build-essential libssl1.0-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm5 libgdbm-dev \
       libicu-dev \
  && apt-get -q clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone https://github.com/rbenv/rbenv.git $RBENV
RUN mkdir -p $RBENV/plugins \
  &&  git clone https://github.com/rbenv/ruby-build.git $RBENV/plugins/ruby-build
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.profile
RUN echo 'eval "$(rbenv init -)"' >> $HOME/.bashrc