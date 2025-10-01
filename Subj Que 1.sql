-- Subjective Question 1: How does the toss decision affect the result of the match? (which visualizations could be used to present your answer better) And is the impact limited to only specific venues?

use ipl;
SELECT     
    td.Toss_Name AS Toss_Decision,
    v.Venue_Name,
    COUNT(*) AS Total_Matches,
    SUM(CASE WHEN m.Toss_Winner = m.Match_Winner THEN 1 ELSE 0 END) AS Matches_Won_After_Toss,
    ROUND(SUM(CASE WHEN m.Toss_Winner = m.Match_Winner THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS Win_Percentage
FROM     
    Matches m
JOIN Toss_Decision td ON m.Toss_Decide = td.Toss_Id
JOIN Venue v ON m.Venue_Id = v.Venue_Id
GROUP BY     
    td.Toss_Name, v.Venue_Name
ORDER BY     
    v.Venue_Name, Win_Percentage DESC;
