/* Step 1 - Member vs Casual Ride Count */

SELECT
    member_casual,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY member_casual;


/* Step 2 - Average Ride Length by Membership */

SELECT
    member_casual,
    ROUND(AVG(ride_length_minutes), 2) AS average_ride_minutes
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY member_casual;


/* Step 3 - Bike Type Preference by Membership */

SELECT
    member_casual,
    rideable_type,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;


/* Step 4 - Ride Count by Day of Week */

SELECT
    member_casual,
    DAYNAME(started_at) AS day_of_week,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY
    member_casual,
    DAYOFWEEK(started_at),
    DAYNAME(started_at)
ORDER BY
    member_casual,
    DAYOFWEEK(started_at);
    
    
/* Step 6 - Ride Count by Hour */

SELECT
    member_casual,
    HOUR(started_at) AS start_hour,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY
    member_casual,
    HOUR(started_at)
ORDER BY
    member_casual,
    start_hour;
    

/* Step 7 - Top 10 Start Stations (Casual Riders) */

SELECT
    start_station_name,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE member_casual = 'casual'
  AND ride_length_minutes <= 1440
  AND start_station_name IS NOT NULL
  AND TRIM(start_station_name) <> ''
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;


/* Step 9 - Top 10 End Stations (Casual Riders) */

SELECT
    end_station_name,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE member_casual = 'casual'
  AND ride_length_minutes <= 1440
  AND end_station_name IS NOT NULL
  AND TRIM(end_station_name) <> ''
GROUP BY end_station_name
ORDER BY total_rides DESC
LIMIT 10;


/* Step 10 - Top 10 End Stations (Members) */

SELECT
    end_station_name,
    COUNT(*) AS total_rides
FROM all_trips_2023
WHERE member_casual = 'member'
  AND ride_length_minutes <= 1440
  AND end_station_name IS NOT NULL
  AND TRIM(end_station_name) <> ''
GROUP BY end_station_name
ORDER BY total_rides DESC
LIMIT 10;


/* Bonus Analysis - Average Ride Length by Day */

SELECT
    member_casual,
    DAYNAME(started_at) AS day_of_week,
    ROUND(AVG(ride_length_minutes),2) AS avg_ride_minutes
FROM all_trips_2023
WHERE ride_length_minutes <= 1440
GROUP BY
    member_casual,
    DAYOFWEEK(started_at),
    DAYNAME(started_at)
ORDER BY
    member_casual,
    DAYOFWEEK(started_at);

