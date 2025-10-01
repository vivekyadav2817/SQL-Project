-- Subjective Question 2:	Suggest some of the players who would be best fit for the team.
-- Top 10 Bowlers with Average Wickets:
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