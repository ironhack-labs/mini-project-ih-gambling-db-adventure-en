SELECT P.product AS ProductName,
       SUM(B.Bet_Amt) AS TotalAmountBet
FROM Betting B
JOIN Product P ON B.ClassId = P.ClassId
WHERE DATE(STR_TO_DATE(B.BetDate, '%m/%d/%Y')) >= '2012-11-01'
AND P.product = 'Sportsbook'
GROUP BY P.product;
