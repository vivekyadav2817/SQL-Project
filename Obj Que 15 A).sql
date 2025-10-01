-- Question 15:Are there players whose performance is more suited to specific venues or conditions? (how would you present this using charts?) 
-- For Batsmen (Runs per Venue):
use ipl;
SELECT 
    p.Player_Name,
    v.Venue_Name,
    SUM(b.Runs_Scored) AS Total_Runs
FROM 
    Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Venue v ON m.Venue_Id = v.Venue_Id
JOIN Player p ON b.Striker = p.Player_Id
GROUP BY 
    p.Player_Name, v.Venue_Name;