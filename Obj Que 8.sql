-- Question 8: List all the players who have average runs scored greater than the overall average and who have taken wickets greater than the overall average

use ipl;
WITH player_runs AS (
    SELECT 
        Striker AS Player_Id,
        SUM(Runs_Scored) AS Total_Runs,
        COUNT(DISTINCT CONCAT(Match_Id, '-', Innings_No)) AS Innings_Played
    FROM 
        Ball_by_Ball
    GROUP BY 
        Striker
),
player_avg_runs AS (
    SELECT 
        Player_Id,
        ROUND(Total_Runs * 1.0 / Innings_Played, 2) AS Avg_Runs
    FROM 
        player_runs
    WHERE Innings_Played > 0
),
overall_avg_runs AS (
    SELECT 
        ROUND(AVG(Total_Runs * 1.0 / Innings_Played), 2) AS Overall_Avg_Runs
    FROM 
        player_runs
    WHERE Innings_Played > 0
),
player_wickets AS (
    SELECT 
        b.Bowler AS Player_Id,
        COUNT(w.Player_Out) AS Total_Wickets
    FROM 
        Ball_by_Ball b
    JOIN 
        Wicket_Taken w ON b.Match_Id = w.Match_Id 
                      AND b.Over_Id = w.Over_Id 
                      AND b.Ball_Id = w.Ball_Id 
                      AND b.Innings_No = w.Innings_No
    GROUP BY 
        b.Bowler
),
overall_avg_wickets AS (
    SELECT 
        ROUND(AVG(Total_Wickets), 2) AS Overall_Wickets
    FROM 
        player_wickets
)
SELECT 
    p.Player_Name,
    r.Avg_Runs,
    w.Total_Wickets
FROM 
    player_avg_runs r
JOIN 
    overall_avg_runs oar ON 1=1
JOIN 
    player_wickets w ON r.Player_Id = w.Player_Id
JOIN 
    overall_avg_wickets oaw ON 1=1
JOIN 
    Player p ON p.Player_Id = r.Player_Id
WHERE 
    r.Avg_Runs > oar.Overall_Avg_Runs
    AND w.Total_Wickets > oaw.Overall_Wickets;