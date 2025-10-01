-- Question 7:	What do you think could be the factors contributing to the high-scoring matches and the impact on viewership and team strategies.
use ipl;
SELECT 
    v.Venue_Name,
    ROUND(SUM(b.Runs_Scored) * 1.0 / COUNT(b.Ball_Id), 2) AS Avg_Runs_Per_Ball
FROM Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Venue v ON m.Venue_Id = v.Venue_Id
GROUP BY v.Venue_Name
ORDER BY Avg_Runs_Per_Ball DESC;

