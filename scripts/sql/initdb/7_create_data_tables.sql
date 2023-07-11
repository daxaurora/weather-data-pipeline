CREATE TABLE IF NOT EXISTS snow
(
  value_date   DATE        NOT NULL,
  station_id   CHAR(11)    NOT NULL,
  value        VARCHAR(5),
  PRIMARY KEY (station_id, value_date)
);

CREATE TABLE IF NOT EXISTS precip
(
  value_date   DATE        NOT NULL,
  station_id   CHAR(11)    NOT NULL,
  value        VARCHAR(5),
  PRIMARY KEY (station_id, value_date)
);

CREATE TABLE IF NOT EXISTS snow_depth
(
  value_date   DATE        NOT NULL,
  station_id   CHAR(11)    NOT NULL,
  value        VARCHAR(5),
  PRIMARY KEY (station_id, value_date)
);

CREATE TABLE IF NOT EXISTS max_temp
(
  value_date   DATE        NOT NULL,
  station_id   CHAR(11)    NOT NULL,
  value        VARCHAR(5),
  PRIMARY KEY (station_id, value_date)
);
CREATE TABLE IF NOT EXISTS min_temp
(
  value_date   DATE        NOT NULL,
  station_id   CHAR(11)    NOT NULL,
  value        VARCHAR(5),
  PRIMARY KEY (station_id, value_date)
);
