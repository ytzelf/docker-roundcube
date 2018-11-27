FROM roundcube/roundcubemail

# GENERAL
RUN apt-get update \
  && apt-get install -qq --no-install-recommends wget unzip \
  && pecl install apcu

# CARDDAV
ENV CARDDAV_VERSION=3.0.3
ENV CARDDAV_URL=https://github.com/blind-coder/rcmcarddav/releases/download
RUN wget ${CARDDAV_URL}/v${CARDDAV_VERSION}/carddav-${CARDDAV_VERSION}.zip \
  && unzip carddav-${CARDDAV_VERSION}.zip \
  && mv carddav /usr/src/roundcubemail/plugins/

# LOGIN_CONTROL
ENV LC_VERSION=1.3
ENV LC_URL=https://github.com/san4op/roundcube_login_control/archive/
RUN wget ${LC_URL}/v${LC_VERSION}.zip \
  && unzip v${LC_VERSION}.zip \
  && mv roundcube_login_control-${LC_VERSION} /usr/src/roundcubemail/plugins/login_control

# IMAGE PASTER
ENV IP_VERSION=1.0
ENV IP_URL=https://codeload.github.com/mkrauser/roundcube_image_paster/zip
RUN wget -O ip.zip ${IP_URL}/v${IP_VERSION} \
  && unzip ip.zip \
  && mv roundcube_image_paster-${IP_VERSION} /usr/src/roundcubemail/plugins/image_paster

# PERSISTENT LOGIN
ENV PL_VERSION=5.1.0
ENV PL_URL=https://codeload.github.com/mfreiholz/persistent_login/zip
RUN wget -O pl.zip ${PL_URL}/version-${PL_VERSION} \
  && unzip pl.zip \
  && mv persistent_login-version-${PL_VERSION} /usr/src/roundcubemail/plugins/persistent_login

# CONTEXT MENU
ENV CM_VERSION=2.1.2
ENV CM_URL=https://codeload.github.com/random-cuber/contextmenu/zip
RUN wget -O cm.zip ${CM_URL}/${CM_VERSION} \
  && unzip cm.zip \
  && mv contextmenu-${CM_VERSION} /usr/src/roundcubemail/plugins/contextmenu

# CONTEXT MENU FOLDER
ENV CMF_VERSION=1.3.3
ENV CMF_URL=https://codeload.github.com/random-cuber/contextmenu_folder/zip
RUN wget -O cmf.zip ${CMF_URL}/${CMF_VERSION} \
  && unzip cmf.zip \
  && mv contextmenu_folder-${CMF_VERSION} /usr/src/roundcubemail/plugins/contextmenu_folder

# CLEANUP
RUN chown -R 501:80 /usr/src/roundcubemail/plugins \
  && rm *.zip \
  && apt-get purge -qq wget unzip \
  && apt-get -qq autoremove --purge \
  && apt-get clean

