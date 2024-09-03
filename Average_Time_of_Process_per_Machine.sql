WITH dt AS(
SELECT 
  machine_id,
  process_id,
  ROUND(MAX(timestamp) - MIN(timestamp), 3) as 'pidtimediff'
FROM Activity
GROUP BY machine_id, process_id
)
SELECT 
    dt.machine_id, 
    ROUND(AVG(dt.pidtimediff), 3)  AS 'processing_time'
FROM dt 
GROUP BY dt.machine_id;


SELECT a.machine_id, ROUND(AVG(b.timestamp - a.timestamp), 3) AS 'processing_time'
FROM Activity a JOIN Activity b 
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id 
AND a.activity_type = 'start'
AND b.activity_type = 'end'
GROUP BY a.machine_id


SELECT a.machine_id, ROUND(AVG(b.timestamp - a.timestamp), 3) AS 'processing_time'
FROM Activity a JOIN Activity b 
ON a.machine_id = b.machine_id
AND a.process_id = b.process_id 
AND a.activity_type > b.activity_type 
GROUP BY a.machine_id
