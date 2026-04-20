-- Question 15:Are there players whose performance is more suited to specific venues or conditions? (how would you present this using charts?) 
-- For Bowlers (Wickets per Venue):
use ipl;
SELECT 
    p.Player_Name,
    v.Venue_Name,
    COUNT(w.Player_Out) AS Total_Wickets
FROM 
    Ball_by_Ball b
JOIN Wicket_Taken w ON b.Match_Id = w.Match_Id 
                   AND b.Over_Id = w.Over_Id 
                   AND b.Ball_Id = w.Ball_Id 
                   AND b.Innings_No = w.Innings_No
JOIN Matches m ON b.Match_Id = m.Match_Id
JOIN Venue v ON m.Venue_Id = v.Venue_Id
JOIN Player p ON b.Bowler = p.Player_Id
GROUP BY 
    p.Player_Name, v.Venue_Name;
