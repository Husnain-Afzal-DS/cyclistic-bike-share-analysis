/* Step 1 - Preview Invalid Ride Durations */

SELECT
    ride_id,
    started_at,
    ended_at,
    TIMESTAMPDIFF(SECOND, started_at, ended_at) AS ride_duration_seconds
FROM all_trips_2023
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 0
LIMIT 20;


/* Step 2 - Verify Records to Delete */

SELECT COUNT(*) AS rows_to_delete
FROM all_trips_2023
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 0;


/* Step 3 - Standardizing Date Format for started_at */
UPDATE all_trips_2023
SET started_at = DATE_FORMAT(
    STR_TO_DATE(started_at, '%m/%d/%Y %H:%i'),
    '%Y-%m-%d %H:%i:%s'
)
WHERE started_at LIKE '%/%';


/* Step 4 - Standardizing Date Format for ended_at */
UPDATE all_trips_2023
SET ended_at = DATE_FORMAT(
    STR_TO_DATE(ended_at, '%m/%d/%Y %H:%i'),
    '%Y-%m-%d %H:%i:%s'
)
WHERE ended_at LIKE '%/%';


/* Step 5 - Verification of Date Format */
SELECT COUNT(*) AS old_format_rows
FROM all_trips_2023
WHERE started_at LIKE '%/%'
   OR ended_at LIKE '%/%';


/* Step 6 - Delete Invalid Ride Durations */

DELETE
FROM all_trips_2023
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 0;


/* Step 7 - Verify Delete */
SELECT COUNT(*) AS invalid_rides_remaining
FROM all_trips_2023
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 0;


/* Step 8 - Verify Total Rows after Cleaning */
SELECT COUNT(*) AS total_rows_after_cleaning
FROM all_trips_2023;


/* Step 9 - Convert started_at to DATETIME */

ALTER TABLE all_trips_2023
MODIFY COLUMN started_at DATETIME;


/* Step 10 - Convert ended_at to DATETIME */

ALTER TABLE all_trips_2023
MODIFY COLUMN ended_at DATETIME;


/* Step 11 - Verification */
DESCRIBE all_trips_2023;