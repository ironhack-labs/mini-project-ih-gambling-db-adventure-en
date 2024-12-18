SELECT C.*, A.CurrencyCode
FROM Customer C
JOIN Account A ON C.CustId = A.CustId;
