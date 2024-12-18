SELECT P.product AS ProductName, 
       DATE(STR_TO_DATE(B.BetDate, '%m/%d/%Y')) AS TransactionDay,
       SUM(B.Bet_Amt) AS TotalAmountBet
FROM Betting B
JOIN Product P ON B.ClassId = P.ClassId
GROUP BY P.product, DATE(STR_TO_DATE(B.BetDate, '%m/%d/%Y'))
ORDER BY TransactionDay;
