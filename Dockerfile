FROM roundcube/roundcubemail:latest-apache

# GENERAL
RUN apt-get update \
  && apt-get -qq upgrade \
  && apt-get install -qq --no-install-recommends wget unzip nano git \
  && pecl install apcu \
  && pecl install redis \
  \
# COPY composer.json /usr/src/roundcubemail/composer.json
  && cd /usr/src/roundcubemail \
  && curl -s https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
  && mv /usr/src/roundcubemail/composer.json-dist /usr/src/roundcubemail/composer.json \
  && composer --prefer-dist --no-interaction --optimize-autoloader --apcu-autoloader require roundcube/carddav mfreiholz/persistent_login:dev-master johndoh/contextmenu jfcherng/show-folder-size \
  && composer --prefer-dist --no-interaction --optimize-autoloader --apcu-autoloader update \
  \
# CLEANUP
  && apt-get purge -qq wget unzip \
  && apt-get -qq autoremove --purge \
  && apt-get clean
