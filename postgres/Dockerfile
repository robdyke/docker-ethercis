FROM postgres:9.4-alpine

LABEL EtherCIS-Version="1.1.0" \
      Description="Docker image for the EtherCIS database" \
      Vendor="Inidus" \
      License=MIT \
      Version=0.0.3 \
      Maintainer="Inidus <cloud-ops@inidus.io>"

RUN apk add --no-cache build-base postgresql-dev bison flex git \
# Install temporal tables extension
  && git clone https://github.com/arkhipov/temporal_tables \
  && cd temporal_tables \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -rf temporal_tables \
# Install jsquery extension
  && git clone https://github.com/postgrespro/jsquery \
  && cd jsquery \
	&& make USE_PGXS=1 \
	&& make install USE_PGXS=1 \
	&& cd .. \
	&& rm -rf jsquery \
# Remove no longer required packages
  && apk del build-base postgresql-dev git

# Copy files required to initialise Postgres with the EtherCIS database schema
#COPY ./scripts ./scripts
COPY ./01_db_creation.sh ./docker-entrypoint-initdb.d/01_db_creation.sh
#COPY ./02_db_init.sh ./docker-entrypoint-initdb.d/02_db_init.sh
