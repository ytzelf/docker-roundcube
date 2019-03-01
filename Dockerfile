FROM roundcube/roundcubemail:elastic

# GENERAL
RUN apt-get update \
  && apt-get -qq upgrade \
  && apt-get install -qq --no-install-recommends wget unzip nano \
  && pecl install apcu \
  && pecl install redis

COPY composer.json /usr/src/roundcubemail/composer.json
RUN cd /usr/src/roundcubemail \
  && curl -s https://getcomposer.org/installer | php \
  && php composer.phar update

# CLEANUP
RUN apt-get purge -qq wget unzip \
  && apt-get -qq autoremove --purge \
  && apt-get clean
