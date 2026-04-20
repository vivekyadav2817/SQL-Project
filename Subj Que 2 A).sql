-- Subjective Question 2:	Suggest some of the players who would be best fit for the team.
-- Top 10 Batsmen with High Average Runs:
use ipl;
SELECT 
    p.Player_Name,
    ROUND(SUM(b.Runs_Scored) * 1.0 / COUNT(DISTINCT m.Match_Id), 2) AS Avg_Runs_Per_Match
FROM 
    Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name
HAVING COUNT(DISTINCT m.Match_Id) >= 5  -- filters out players who played too few matches
ORDER BY Avg_Runs_Per_Match DESC
LIMIT 10;