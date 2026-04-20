-- Subjective Question 3:What are some of the parameters that should be focused on while selecting the players?
-- For Bowlers: 1.Total Wickets Taken	
use ipl;
SELECT 
    p.Player_Name,
    COUNT(w.Player_Out) AS Total_Wickets
FROM 
    Ball_by_Ball b
JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id 
                   AND b.Over_Id = w.Over_Id 
                   AND b.Ball_Id = w.Ball_Id 
                   AND b.Innings_No = w.Innings_No
JOIN Player p ON b.Bowler = p.Player_Id
GROUP BY 
    p.Player_Name
ORDER BY Total_Wickets DESC
LIMIT 10;