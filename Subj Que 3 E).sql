-- Subjective Question 3:What are some of the parameters that should be focused on while selecting the players?
-- For Bowlers: 2. Bowling Strike Rate (Balls per Wicket)
use ipl;
SELECT 
    p.Player_Name,
    COUNT(*) AS Balls_Bowled,
    COUNT(w.Player_Out) AS Total_Wickets,
    ROUND(COUNT(*) * 1.0 / COUNT(w.Player_Out), 2) AS Strike_Rate
FROM 
    Ball_by_Ball b
JOIN Player p ON b.Bowler = p.Player_Id
LEFT JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id 
                         AND b.Over_Id = w.Over_Id 
                         AND b.Ball_Id = w.Ball_Id 
                         AND b.Innings_No = w.Innings_No
GROUP BY 
    p.Player_Name
HAVING Total_Wickets > 0 AND Balls_Bowled >= 30
ORDER BY Strike_Rate ASC
LIMIT 10;