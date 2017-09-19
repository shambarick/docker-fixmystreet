FROM debian:stretch as build
RUN apt-get update && apt-get install -y \
        make \
        g++ \
        jhead \
        liblocale-gettext-perl \
        memcached \
        perl \
        perlmagick \
        libmath-bigint-gmp-perl \
        gettext \
        postgresql \
        postgresql-server-dev-all \
        gnuplot \
        ttf-bitstream-vera \
        libexpat1-dev \
        libssl-dev \
        zlib1g-dev \
        git
RUN git clone --recursive https://github.com/mysociety/fixmystreet.git /var/www/fixmystreet
WORKDIR /var/www/fixmystreet
RUN git checkout tags/v2.2
RUN bin/install_perl_modules
RUN bin/make_css

FROM debian:stretch
RUN apt-get update && apt-get install -y \
      ca-certificates gettext gnuplot jhead \
      liblocale-gettext-perl libmath-bigint-gmp-perl perl perlmagick \
      ttf-bitstream-vera \
      libpq-dev \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /var/www/fixmystreet
COPY --from=build /var/www/fixmystreet /var/www/fixmystreet
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
