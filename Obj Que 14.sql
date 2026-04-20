-- Question 14: A)	Which of the given players have consistently performed well in past seasons? (will you use any visualization to solve the problem)
-- Total Runs by Each Player
use ipl;
SELECT 
    p.Player_Name,
    s.Season_Year,
    SUM(b.Runs_Scored) AS Total_Runs
FROM 
    Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Season s ON m.Season_Id = s.Season_Id
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name, s.Season_Year
ORDER BY 
    p.Player_Name, s.Season_Year;

-- Wickets taken by each bowler in every season
SELECT
p.Player_Name,
s.Season_Year,
COUNT(w.Player_Out) AS Total_Wickets
FROM
Ball_by_Ball b
JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id
AND b.Over_Id = w.Over_Id
AND b.Ball_Id = w.Ball_Id
AND b.Innings_No = w.Innings_No
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Season s ON m.Season_Id = s.Season_Id
JOIN Player p ON b.Bowler = p.Player_Id
GROUP BY
p.Player_Name, s.Season_Year
ORDER BY
p.Player_Name, s.Season_Year;
