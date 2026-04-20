-- Question 5:	List the top 10 players according to their strike rate in the last 4 seasons

use ipl;
SELECT p.Player_Name, ROUND(SUM(b.Runs_Scored) * 100.0 / COUNT(b.Ball_Id), 2) AS Strike_Rate
FROM 
    Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Season s ON m.Season_Id = s.Season_Id
JOIN Player p ON b.Striker = p.Player_Id
WHERE 
    s.Season_Year >= (
        SELECT MAX(Season_Year) - 3 
        FROM Season)
GROUP BY 
    p.Player_Id
ORDER BY 
    Strike_Rate DESC
LIMIT 10;