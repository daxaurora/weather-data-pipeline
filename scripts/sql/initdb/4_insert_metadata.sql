INSERT INTO us_states
(
  state_id,
  state_name
)
SELECT
  SUBSTRING(states_rows,1,2) AS state_id,
  SUBSTRING(states_rows,4,50) AS state_name
FROM us_states_staging;

INSERT INTO countries
(
  fips,
  country_name
)
SELECT
  SUBSTRING(countries_rows,1,2) AS fips,
  SUBSTRING(countries_rows,4,64) AS country_name
FROM countries_staging;

INSERT INTO stations
(
  station_id,
  fips,
  latitude,
  longitude,
  elevation,
  state_id,
  station_name,
  gsn_flag,
  hcn_crn_flag,
  wmo_id
)
SELECT
  SUBSTRING(stations_rows,1,11) AS station_id,
  SUBSTRING(stations_rows,1,2) AS fips,
  CAST(SUBSTRING(stations_rows,13,8) AS NUMERIC) AS latitude,
  CAST(SUBSTRING(stations_rows,22,8) AS NUMERIC) AS longitude,
  CAST(SUBSTRING(stations_rows,32,6) AS NUMERIC) AS elevation,
  SUBSTRING(stations_rows,39,2) AS state_id,
  SUBSTRING(stations_rows,42,30) AS station_name,
  SUBSTRING(stations_rows,73,3) AS gsn_flag,
  SUBSTRING(stations_rows,77,3) AS hcn_crn_flag,
  SUBSTRING(stations_rows,81,5) AS wmo_id
FROM stations_staging;
