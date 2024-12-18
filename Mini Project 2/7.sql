SELECT 
    C.Title, 
    C.FirstName, 
    C.LastName, 
    IFNULL(SUM(B.Bet_Amt), 0) AS TotalBetAmount
FROM Customer C
LEFT JOIN Account A ON C.CustId = A.CustId
LEFT JOIN Betting B ON A.AccountNo = B.AccountNo
WHERE DATE(STR_TO_DATE(B.BetDate, '%m/%d/%Y')) BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY C.CustId, C.Title, C.FirstName, C.LastName;
