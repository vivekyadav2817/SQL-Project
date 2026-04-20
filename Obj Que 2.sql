-- Question 2.	What is the total number of runs scored in 1st season by RCB (bonus: also include the extra runs using the extra runs table)
use ipl;
SELECT 
    SUM(b.Runs_Scored + COALESCE(e.Extra_Runs, 0)) AS Total_Runs_With_Extras
FROM Ball_by_Ball b
JOIN Matches m ON b.Match_Id = m.Match_Id
LEFT JOIN Extra_Runs e 
    ON b.Match_Id = e.Match_Id
   AND b.Over_Id = e.Over_Id
   AND b.Ball_Id = e.Ball_Id
   AND b.Innings_No = e.Innings_No
WHERE m.Season_Id = 1
  AND b.Team_Batting = 2; 

