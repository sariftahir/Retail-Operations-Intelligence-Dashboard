CREATE VIEW vw_InventorySnapshot AS
SELECT 
    i.SnapshotID,
    i.Date AS SnapshotDate,
    i.WarehouseID,
    w.Location AS WarehouseName,
    w.Type AS WarehouseType,
    w.Capacity AS WarehouseCapacity,
    i.ProductID,
    p.ProductName,
    p.Category,
    p.DemandTier,
    i.OpeningStock,
    i.IncomingStock,
    i.OutgoingStock,
    i.EndingStock,
    i.StockValue,
    p.ReorderLevel,
    
    CASE 
        WHEN i.EndingStock = 0 THEN 'Out of Stock'
        WHEN i.EndingStock <= p.ReorderLevel THEN 'Restock Needed'
        ELSE 'Safe'
    END AS StockStatus

FROM dbo.inventory i
INNER JOIN dbo.products p 
    ON i.ProductID = p.ProductID
INNER JOIN dbo.warehouses w 
    ON i.WarehouseID = w.WarehouseID;
