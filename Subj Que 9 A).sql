-- Question 9.	Come up with a visual and analytical analysis of the RCB's past season's performance and potential reasons for them not winning a trophy.
-- 1. RCB’s Season-Wise Win Percentage:
use ipl;
SELECT 
    YEAR(m.Match_Date) AS Season,
    COUNT(*) AS Total_Matches,
    SUM(CASE WHEN m.Match_Winner = 3 THEN 1 ELSE 0 END) AS Matches_Won,
    ROUND(SUM(CASE WHEN m.Match_Winner = 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Win_Percentage
FROM Matches m
WHERE m.Team_1 = 2 OR m.Team_2 = 2  
GROUP BY Season
ORDER BY Season;
