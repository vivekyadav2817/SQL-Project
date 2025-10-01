-- Question 6:	What are the average runs scored by each batsman considering all the seasons?

use ipl;
WITH player_runs AS (
    SELECT 
        Striker AS Player_Id,
        SUM(Runs_Scored) AS Total_Runs
    FROM 
 Ball_by_Ball
    GROUP BY 
        Striker
),
player_innings AS (
    SELECT 
        Striker AS Player_Id,
        COUNT(DISTINCT CONCAT(Match_Id, '-', Innings_No)) AS Innings_Played
    FROM 
        Ball_by_Ball
    GROUP BY 
        Striker
)
SELECT 
    p.Player_Name,
    r.Total_Runs,
    i.Innings_Played,
    ROUND(r.Total_Runs * 1.0 / i.Innings_Played, 2) AS Avg_Runs
FROM 
    player_runs r
JOIN 
    player_innings i ON r.Player_Id = i.Player_Id
JOIN 
    Player p ON p.Player_Id = r.Player_Id
ORDER BY 
    Avg_Runs DESC;