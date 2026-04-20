-- Question 6.	What would you suggest to RCB before going to the mega auction? 
-- B. Pick new players who are good in both batting and bowling
use ipl;
SELECT 
    p.Player_Name,
    COALESCE(batting.Total_Runs, 0) AS Total_Runs,
    COALESCE(bowling.Total_Wickets, 0) AS Total_Wickets
FROM Player p
LEFT JOIN (
    SELECT Striker AS Player_Id, SUM(Runs_Scored) AS Total_Runs
    FROM Ball_by_Ball
    GROUP BY Striker
) AS batting ON p.Player_Id = batting.Player_Id
LEFT JOIN (
    SELECT b.Bowler AS Player_Id, COUNT(*) AS Total_Wickets
    FROM Ball_by_Ball b
    JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id 
                       AND b.Over_Id = w.Over_Id 
                       AND b.Ball_Id = w.Ball_Id 
                       AND b.Innings_No = w.Innings_No
    GROUP BY b.Bowler
) AS bowling ON p.Player_Id = bowling.Player_Id
WHERE COALESCE(batting.Total_Runs, 0) >= 150
  AND COALESCE(bowling.Total_Wickets, 0) >= 10
ORDER BY Total_Runs DESC, Total_Wickets DESC
LIMIT 10;

