/* Step 1 - Add Ride Length in Minutes */

ALTER TABLE all_trips_2023
ADD COLUMN ride_length_minutes DECIMAL(10,2);


/* Step 2 - Populate Ride Length */

UPDATE all_trips_2023
SET ride_length_minutes =
TIMESTAMPDIFF(SECOND, started_at, ended_at) / 60;


/* Step 3 - Check rides longer than 24 hours */

SELECT
COUNT(*) AS rides_over_24_hours
FROM all_trips_2023
WHERE ride_length_minutes > 1440;