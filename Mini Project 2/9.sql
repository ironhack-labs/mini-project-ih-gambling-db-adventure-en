SELECT A.CustId, SUM(B.AccountNo) AS TotalBetAmount
FROM Betting B
JOIN Product P ON B.ClassId = P.CLASSID AND B.CategoryId = P.CATEGORYID
JOIN Account A ON B.AccountNo = A.AccountNo
WHERE P.product = 'Sportsbook' AND B.AccountNo > 0
GROUP BY A.CustId;
