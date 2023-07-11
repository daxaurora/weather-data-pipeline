CREATE TABLE IF NOT EXISTS us_states
(
  state_id   CHAR(2)     NOT NULL PRIMARY KEY,
  state_name VARCHAR(47) NOT NULL
);

CREATE TABLE IF NOT EXISTS countries
(
  fips          CHAR(2)     NOT NULL PRIMARY KEY,
  country_name  VARCHAR(61) NOT NULL
);

CREATE TABLE IF NOT EXISTS stations
(
  station_id    CHAR(11)        NOT NULL PRIMARY KEY,
  fips          CHAR(2)         NOT NULL,
  latitude      NUMERIC(7,4)    NOT NULL,
  longitude     NUMERIC(7,4)    NOT NULL,
  elevation     NUMERIC(6,1),
  state_id      CHAR(2),
  station_name  VARCHAR(30)     NOT NULL,
  gsn_flag      CHAR(3),
  hcn_crn_flag  CHAR(3),
  wmo_id        CHAR(5)
);
