-- Question 9.	Come up with a visual and analytical analysis of the RCB's past season's performance and potential reasons for them not winning a trophy.
-- 2. Top RCB Batsmen by Average Runs
use ipl;
SELECT 
    p.Player_Name,
    ROUND(SUM(b.Runs_Scored) * 1.0 / COUNT(DISTINCT m.Match_Id), 2) AS Avg_Runs
FROM Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Player p ON b.Striker = p.Player_Id
WHERE b.Team_Batting = 2
GROUP BY p.Player_Name
HAVING COUNT(DISTINCT m.Match_Id) >= 5
ORDER BY Avg_Runs DESC;
