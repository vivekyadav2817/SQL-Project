-- Question 13: Using SQL, write a query to find out the average wickets taken by each bowler in each venue. Also, rank the gender according to the average value.

use ipl;
WITH bowler_venue_wickets AS (
    SELECT 
        b.Bowler AS Player_Id,
        m.Venue_Id,
        COUNT(w.Player_Out) AS Total_Wickets
    FROM 
        Ball_by_Ball b
    JOIN 
        Wicket_Taken w ON b.Match_Id = w.Match_Id 
                      AND b.Over_Id = w.Over_Id 
                      AND b.Ball_Id = w.Ball_Id 
                      AND b.Innings_No = w.Innings_No
    JOIN 
        Matches m ON b.Match_Id = m.Match_Id
    GROUP BY 
        b.Bowler, m.Venue_Id
),
venue_avg_wickets AS (
    SELECT 
        v.Venue_Name,
        p.Player_Name,
        w.Total_Wickets,
        COUNT(DISTINCT b.Match_Id) AS Matches_Played,
        ROUND(w.Total_Wickets * 1.0 / COUNT(DISTINCT b.Match_Id), 2) AS Avg_Wickets
    FROM 
        bowler_venue_wickets w
    JOIN 
        Venue v ON w.Venue_Id = v.Venue_Id
    JOIN 
        Player p ON w.Player_Id = p.Player_Id
    JOIN 
        Ball_by_Ball b ON b.Bowler = w.Player_Id
    WHERE 
        b.Match_Id IN (SELECT Match_Id FROM Matches WHERE Venue_Id = w.Venue_Id)
    GROUP BY 
        v.Venue_Name, p.Player_Name, w.Total_Wickets
)
SELECT 
    Venue_Name,
    Player_Name,
    Total_Wickets,
    Matches_Played,
    Avg_Wickets,
    RANK() OVER (PARTITION BY Venue_Name ORDER BY Avg_Wickets DESC) AS Rank_in_Venue
FROM 
    venue_avg_wickets
ORDER BY 
    Venue_Name, Rank_in_Venue;