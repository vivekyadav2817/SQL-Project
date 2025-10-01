-- Question 7:	What are the average wickets taken by each bowler considering all the seasons?

use ipl;
WITH bowler_wickets AS (
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
bowler_innings AS (
    SELECT 
        Bowler AS Player_Id,
        COUNT(DISTINCT CONCAT(Match_Id, '-', Innings_No)) AS Innings_Bowled
    FROM 
        Ball_by_Ball
    GROUP BY 
        Bowler
)
SELECT 
    p.Player_Name,
    w.Total_Wickets,
    i.Innings_Bowled,
    ROUND(w.Total_Wickets * 1.0 / i.Innings_Bowled, 2) AS Avg_Wickets
FROM 
    bowler_wickets w
JOIN 
    bowler_innings i ON w.Player_Id = i.Player_Id
JOIN 
    Player p ON p.Player_Id = w.Player_Id
ORDER BY 
    Avg_Wickets DESC;