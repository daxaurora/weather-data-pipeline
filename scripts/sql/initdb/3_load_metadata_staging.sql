COPY us_states_staging
FROM '/data/ghcnd-states.txt';

COPY countries_staging
FROM '/data/ghcnd-countries.txt';

COPY stations_staging
FROM '/data/ghcnd-stations.txt';
