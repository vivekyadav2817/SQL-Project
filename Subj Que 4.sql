-- Question 4.	Which players offer versatility in their skills and can contribute effectively with both bat and ball? (can you visualize the data for the same)

use ipl;
SELECT 
    p.Player_Name,
    COALESCE(batting.Total_Runs, 0) AS Total_Runs,
    COALESCE(bowling.Total_Wickets, 0) AS Total_Wickets
FROM 
    Player p
LEFT JOIN (
    SELECT 
        b.Striker AS Player_Id,
        SUM(b.Runs_Scored) AS Total_Runs
    FROM Ball_by_Ball b
    GROUP BY b.Striker
) AS batting ON p.Player_Id = batting.Player_Id

LEFT JOIN (
    SELECT 
        b.Bowler AS Player_Id,
        COUNT(w.Player_Out) AS Total_Wickets
    FROM Ball_by_Ball b
    JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id 
                       AND b.Over_Id = w.Over_Id 
                       AND b.Ball_Id = w.Ball_Id 
                       AND b.Innings_No = w.Innings_No
    GROUP BY b.Bowler
) AS bowling ON p.Player_Id = bowling.Player_Id

WHERE 
    Total_Runs >= 200 AND Total_Wickets >= 15
ORDER BY 
    Total_Runs DESC, Total_Wickets DESC;
