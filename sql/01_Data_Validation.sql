/* Step 1 - Total Rows */

SELECT COUNT(*) AS total_rows
FROM all_trips_2023;


/* Step 2 - Unique Ride IDs */

SELECT
COUNT(*) AS Total_Rows,
COUNT(DISTINCT ride_id) AS Unique_Rides
FROM all_trips_2023;


/* Step 3 - Duplicate Ride IDs */

SELECT
ride_id,
COUNT(*) AS duplicate_count
FROM all_trips_2023
GROUP BY ride_id
HAVING COUNT(*) > 1
LIMIT 20;

/* Step 4 - Missing Values Check */
SELECT
    SUM(start_station_name IS NULL OR start_station_name='') AS missing_start_station,
    SUM(end_station_name IS NULL OR end_station_name='') AS missing_end_station,
    SUM(start_lat IS NULL) AS missing_start_lat,
    SUM(end_lat IS NULL) AS missing_end_lat,
    SUM(member_casual IS NULL OR member_casual='') AS missing_member_type
FROM all_trips_2023;


/* Step 5 - Date Range Validation */
SELECT
    MIN(started_at) AS first_ride,
    MAX(started_at) AS last_ride_start,
    MIN(ended_at) AS first_end,
    MAX(ended_at) AS last_end
FROM all_trips_2023;


/* Step 6 - Ride Duration Validation */
SELECT
    COUNT(*) AS invalid_rides
FROM all_trips_2023
WHERE TIMESTAMPDIFF(SECOND, started_at, ended_at) <= 0;