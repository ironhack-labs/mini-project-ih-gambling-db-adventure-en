SELECT A.CustId, COUNT(DISTINCT P.product) AS TotalProducts
FROM Betting B
JOIN Product P ON B.ClassId = P.CLASSID AND B.CategoryId = P.CATEGORYID
JOIN Account A ON B.AccountNo = A.AccountNo
GROUP BY A.CustId;

SELECT A.CustId
FROM Betting B
JOIN Product P ON B.ClassId = P.CLASSID AND B.CategoryId = P.CATEGORYID
JOIN Account A ON B.AccountNo = A.AccountNo
WHERE P.product IN ('Sportsbook', 'Vegas')
GROUP BY A.CustId
HAVING COUNT(DISTINCT P.product) = 2;
