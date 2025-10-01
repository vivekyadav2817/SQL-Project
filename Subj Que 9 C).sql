-- Question 9.	Come up with a visual and analytical analysis of the RCB's past season's performance and potential reasons for them not winning a trophy.
-- 3. RCB Bowlers by Economy Rate:
use ipl;
SELECT 
    p.Player_Name,
    ROUND(SUM(b.Runs_Scored) * 6.0 / COUNT(*), 2) AS Economy_Rate
FROM Ball_by_Ball b
JOIN Player p ON b.Bowler = p.Player_Id
WHERE b.Bowler IN (
    SELECT DISTINCT b1.Bowler
    FROM Ball_by_Ball b1
    WHERE b1.Team_Bowling = 2 
)
GROUP BY p.Player_Name
HAVING COUNT(*) >= 30
ORDER BY Economy_Rate ASC
