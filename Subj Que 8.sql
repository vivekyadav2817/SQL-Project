-- Subjective Question 8.	Analyze the impact of home-ground advantage on team performance and identify strategies to maximize this advantage for RCB.
use ipl;
SELECT
t.Team_Name AS Team,
v.Venue_Name AS Home_Venue,
COUNT(*) AS Matches_Played_At_Home,
SUM(CASE WHEN m.Match_Winner = t.Team_Id THEN 1 ELSE 0 END) AS Wins_At_Home,
ROUND(SUM(CASE WHEN m.Match_Winner = t.Team_Id THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Win_Percentage_At_Home
FROM Matches m
JOIN Venue v ON m.Venue_Id = v.Venue_Id                                        
JOIN Team t ON m.Team_1 = t.Team_Id OR m.Team_2 = t.Team_Id
WHERE v.Venue_Name LIKE '%Chinnaswamy%'
AND (m.Team_1 = t.Team_Id OR m.Team_2 = t.Team_Id)
GROUP BY t.Team_Name, v.Venue_Name
ORDER BY Win_Percentage_At_Home DESC;
