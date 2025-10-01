-- Question 5.	Are there players whose presence positively influences the morale and performance of the team? (justify your answer using visualization)
use ipl;
SELECT 
    Player_Name,
    COUNT(*) AS Matches_Played,
    SUM(CASE WHEN Team_Id = Match_Winner THEN 1 ELSE 0 END) AS Matches_Won,
    ROUND(SUM(CASE WHEN Team_Id = Match_Winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Win_Percentage
FROM (
    SELECT DISTINCT 
        m.Match_Id,
        p.Player_Name,
        pb.Team_Batting AS Team_Id,
        m.Match_Winner
    FROM Ball_by_Ball pb
    JOIN Matches m ON pb.Match_Id = m.Match_Id
    JOIN Player p ON pb.Striker = p.Player_Id
) AS player_matches
GROUP BY Player_Name
HAVING Matches_Played >= 10
ORDER BY Win_Percentage DESC;



