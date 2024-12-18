SELECT 
    P.product AS ProductName, 
    A.CurrencyCode, 
    C.CustomerGroup, 
    SUM(B.AccountNo) AS TotalAmountBet
FROM 
    Betting B
JOIN Product P ON B.ClassId = P.CLASSID AND B.CategoryId = P.CATEGORYID
JOIN Account A ON B.AccountNo = A.AccountNo
JOIN Customer C ON A.CustId = C.CustId  -- Replace CustomerID with the correct column name
WHERE STR_TO_DATE(B.BetDate, '%m/%d/%Y') > '2012-12-01'
GROUP BY 
    P.product, 
    A.CurrencyCode, 
    C.CustomerGroup;
