-- Question 10: What is the impact of bowling style on wickets taken?
use ipl;
SELECT 
    bs.Bowling_skill AS Bowling_Style,
    COUNT(w.Player_Out) AS Total_Wickets
FROM 
    Wicket_Taken w
JOIN 
    Ball_by_Ball b ON w.Match_Id = b.Match_Id 
                  AND w.Over_Id = b.Over_Id 
                  AND w.Ball_Id = b.Ball_Id 
                  AND w.Innings_No = b.Innings_No
JOIN 
    Player p ON b.Bowler = p.Player_Id
JOIN 
    Bowling_Style bs ON p.Bowling_skill = bs.Bowling_Id
GROUP BY 
    bs.Bowling_skill
ORDER BY 
    Total_Wickets DESC;
