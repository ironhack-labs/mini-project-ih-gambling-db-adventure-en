SELECT A.CustId, 
       P.product AS FavoriteProduct, 
       SUM(B.Bet_Amt) AS TotalBetAmount
FROM Betting B
JOIN Product P 
    ON B.ClassId = P.CLASSID AND B.CategoryId = P.CATEGORYID
JOIN Account A 
    ON B.AccountNo = A.AccountNo
GROUP BY A.CustId, P.product
HAVING SUM(B.Bet_Amt) = (
    SELECT MAX(TotalBet) 
    FROM (
        SELECT A2.CustId, 
               SUM(B2.Bet_Amt) AS TotalBet
        FROM Betting B2
        JOIN Product P2 
            ON B2.ClassId = P2.CLASSID AND B2.CategoryId = P2.CATEGORYID
        JOIN Account A2 
            ON B2.AccountNo = A2.AccountNo
        GROUP BY A2.CustId, P2.product
    ) AS PlayerBets
    WHERE PlayerBets.CustId = A.CustId
);
