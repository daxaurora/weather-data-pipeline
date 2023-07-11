UPDATE stations
SET elevation = NULL
WHERE elevation = -999.9;

UPDATE stations
SET state_id = NULL
WHERE state_id = '';

UPDATE stations
SET gsn_flag = NULL
WHERE gsn_flag = '';

UPDATE stations
SET wmo_id = NULL
WHERE wmo_id = '';
