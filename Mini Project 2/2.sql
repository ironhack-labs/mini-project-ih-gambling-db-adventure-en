SELECT CustomerGroup, COUNT(*) AS TotalCustomers
FROM Customer
GROUP BY CustomerGroup;
