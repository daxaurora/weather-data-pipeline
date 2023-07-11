FROM postgres:15.2

COPY --chmod=0600 .pgpass .
COPY scripts/sql/initdb /docker-entrypoint-initdb.d/

EXPOSE 5432
