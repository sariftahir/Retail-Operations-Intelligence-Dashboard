CREATE VIEW vw_SalesPerformance AS
SELECT 
    s.OrderID,
    s.OrderDate,
    s.ProductID,
    p.ProductName,
    p.Category,
    p.SubCategory,
    p.Brand,
    p.DemandTier,
    s.Quantity AS QtySold,
    p.UnitCost,
    p.SellingPrice,
    s.Revenue,
    
    (s.Quantity * p.UnitCost) AS TotalCost,
    (s.Revenue - (s.Quantity * p.UnitCost)) AS GrossProfit,
    ISNULL(w.Location, 'Unknown') AS WarehouseLocation,
    ISNULL(w.Region, 'Unknown') AS WarehouseRegion

FROM dbo.sales_outflow s
INNER JOIN dbo.products p 
    ON s.ProductID = p.ProductID
LEFT JOIN (
    SELECT DISTINCT ProductID, WarehouseID 
    FROM dbo.inventory
) inv 
    ON s.ProductID = inv.ProductID
LEFT JOIN dbo.warehouses w 
    ON inv.WarehouseID = w.WarehouseID;
