-- Question 9:	Create a table rcb_record table that shows the wins and losses of RCB in an individual venue 

use ipl;
SELECT 
    v.Venue_Name,
    SUM(CASE WHEN m.Match_Winner = 2 THEN 1 ELSE 0 END) AS Wins,
    SUM(CASE 
            WHEN (m.Match_Winner IS NOT NULL AND m.Match_Winner != 2 AND (m.Team_1 = 2 OR m.Team_2 = 2)) 
            THEN 1 
            ELSE 0 
        END) AS Losses
FROM 
    Matches m
JOIN 
    Venue v ON m.Venue_Id = v.Venue_Id
WHERE 
    (m.Team_1 = 2 OR m.Team_2 = 2) 
GROUP BY 
    v.Venue_Name
    order by wins desc, losses asc;