-- Subjective Question 3:What are some of the parameters that should be focused on while selecting the players?
-- For Batsmen: 3.	Best Strike Rate (Top 10 Players)

use ipl;
SELECT 
    p.Player_Name,
    SUM(b.Runs_Scored) AS Total_Runs,
    COUNT(*) AS Balls_Faced,
    ROUND(SUM(b.Runs_Scored) * 100.0 / COUNT(*), 2) AS Strike_Rate
FROM 
    Ball_by_Ball b
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name
HAVING COUNT(*) >= 20  -- minimum balls faced
ORDER BY Strike_Rate DESC
limit 10;