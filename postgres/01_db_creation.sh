#!/bin/bash
# Create EtherCIS database and required extensions

psql -U postgres <<-EOSQL
  CREATE DATABASE "ethercis";
  CREATE EXTENSION "uuid-ossp";
  CREATE EXTENSION "temporal_tables";
  CREATE EXTENSION "ltree";
  CREATE EXTENSION "jsquery";
  CREATE ROLE ethercis WITH LOGIN PASSWORD 'ethercis';
  GRANT ALL PRIVILEGES ON DATABASE ethercis TO ethercis;
  -- install the extensions
  \c ethercis
  CREATE SCHEMA IF NOT EXISTS ext AUTHORIZATION ethercis;
  CREATE EXTENSION IF NOT EXISTS "uuid-ossp" SCHEMA ext;
  CREATE EXTENSION IF NOT EXISTS "temporal_tables" SCHEMA ext;
  CREATE EXTENSION IF NOT EXISTS "jsquery" SCHEMA ext;
  CREATE EXTENSION IF NOT EXISTS "ltree" SCHEMA ext;
  -- setup the search_patch so the extensions can be found
  ALTER DATABASE ethercis SET search_path TO "$user",public,ext;
  GRANT ALL ON ALL FUNCTIONS IN SCHEMA ext TO ethercis;
EOSQL
