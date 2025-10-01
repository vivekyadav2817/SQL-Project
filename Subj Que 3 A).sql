-- Subjective Question 3:What are some of the parameters that should be focused on while selecting the players?
-- For Batsmen: 1.	Total Runs Scored (Top 10 Players)

use ipl;
SELECT 
    p.Player_Name,
    SUM(b.Runs_Scored) AS Total_Runs
FROM 
    Ball_by_Ball b
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name
ORDER BY Total_Runs DESC
LIMIT 10;



