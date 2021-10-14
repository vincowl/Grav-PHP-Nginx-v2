FROM bitnami/minideb:bullseye
MAINTAINER Vincent GIRARD <vincent@heliosphere.fr>

RUN \
  ## Docker User
  useradd -u 911 -U -d /var/www -s /bin/false xyz && \
  usermod -G users xyz && \
  ## Install Pre-reqs
  install_packages \
    apt-transport-https \
    ca-certificates \
    curl \
    lsb-release \
    nano \
    nginx \
    unzip \
    cron \
    git \
    wget && \
  ## Install PHP APT Repository
  wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
  echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php8.0.list && \
  ## Install PHP 8.0
  install_packages \
    php8.0 \
    php8.0-fpm \
    php8.0-gd \
    php8.0-curl \
    php8.0-apcu \
    php8.0-zip \
    php8.0-mbstring \
    php8.0-xml \
    php8.0-intl && \
  ## Download GRAV
  mkdir -p \
    /grav && \
  GRAV_VERSION=$(curl -sX GET "https://api.github.com/repos/getgrav/grav/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') && \
  curl -o /grav/grav.zip -L https://github.com/getgrav/grav/releases/download/${GRAV_VERSION}/grav-admin-v${GRAV_VERSION}.zip && \
  ## Setup cron to make control console green
  touch /var/spool/cron/crontabs/xyz && \
  (crontab -l; echo "* * * * * cd /var/www/grav;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1") | crontab -u xyz - && \
  chown xyz /var/spool/cron/crontabs/xyz && \
  ## Setup cron that really works
  (crontab -l; echo "* * * * * cd /var/www/grav;/usr/bin/php bin/grav scheduler 1>> /dev/null 2>&1") | crontab - && \
  ## Nginx Logs
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 443

COPY root/ /

WORKDIR /var/www/grav

CMD ["/init-admin"]
