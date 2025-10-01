-- Question 11: Write the SQL query to provide a status of whether the performance of the team is better than the previous year's performance on the basis of the number of runs scored by the team in the season and the number of wickets taken 

use ipl;
WITH team_runs AS (
    SELECT 
        m.Season_Id,
        b.Team_Batting AS Team_Id,
        SUM(b.Runs_Scored) AS Total_Runs
    FROM 
        Ball_by_Ball b
    JOIN 
        Matches m ON b.Match_Id = m.Match_Id
    GROUP BY 
        m.Season_Id, b.Team_Batting
),
team_wickets AS (
    SELECT 
        m.Season_Id,
        b.Team_Bowling AS Team_Id,
        COUNT(w.Player_Out) AS Total_Wickets
    FROM 
        Ball_by_Ball b
    JOIN 
        Matches m ON b.Match_Id = m.Match_Id
    JOIN 
        Wicket_Taken w ON b.Match_Id = w.Match_Id 
                    AND b.Over_Id = w.Over_Id 
                    AND b.Ball_Id = w.Ball_Id 
                    AND b.Innings_No = w.Innings_No
    GROUP BY 
        m.Season_Id, b.Team_Bowling
),
combined AS (
    SELECT 
        r.Season_Id,
        r.Team_Id,
        r.Total_Runs,
        w.Total_Wickets
    FROM 
        team_runs r
    JOIN 
        team_wickets w ON r.Season_Id = w.Season_Id AND r.Team_Id = w.Team_Id
),
with_previous AS (
    SELECT 
        c.*,
        s.Season_Year,
        LAG(c.Total_Runs) OVER (PARTITION BY c.Team_Id ORDER BY s.Season_Year) AS Prev_Total_Runs,
        LAG(c.Total_Wickets) OVER (PARTITION BY c.Team_Id ORDER BY s.Season_Year) AS Prev_Total_Wickets
    FROM 
        combined c
    JOIN 
        Season s ON c.Season_Id = s.Season_Id
)
SELECT 
    t.Team_Name,
    wp.Season_Year,
    wp.Total_Runs,
    wp.Total_Wickets,
    wp.Prev_Total_Runs,
    wp.Prev_Total_Wickets,
    CASE 
        WHEN wp.Total_Runs > wp.Prev_Total_Runs AND wp.Total_Wickets > wp.Prev_Total_Wickets THEN 'Improved'
        WHEN wp.Total_Runs < wp.Prev_Total_Runs AND wp.Total_Wickets < wp.Prev_Total_Wickets THEN 'Declined'
        ELSE 'Same'
    END AS Performance_Status
FROM 
    with_previous wp
JOIN 
    Team t ON wp.Team_Id = t.Team_Id
WHERE 
    wp.Prev_Total_Runs IS NOT NULL AND wp.Prev_Total_Wickets IS NOT NULL
ORDER BY 
    t.Team_Name, wp.Season_Year;