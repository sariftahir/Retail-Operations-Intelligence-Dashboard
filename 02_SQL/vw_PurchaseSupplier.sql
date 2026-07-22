CREATE VIEW vw_Purchase_Supplier AS
SELECT 
    po.PO_ID,
    po.PO_Date,
    po.DeliveryDate AS ActualDeliveryDate,
    po.SupplierID,
    sp.SupplierName,
    sp.Country AS SupplierCountry,
    po.ProductID,
    p.ProductName,
    po.OrderedQty,
    po.ReceivedQty,
    po.UnitCost,
    po.Status AS FulfillmentStatus,
    
    DATEDIFF(DAY, po.PO_Date, po.DeliveryDate) AS ActualLeadTimeDays,
    p.LeadTimeDays AS TargetLeadTimeDays,
    (po.OrderedQty * po.UnitCost) AS TotalPOAmount,
    
    CASE 
        WHEN DATEDIFF(DAY, po.PO_Date, po.DeliveryDate) <= p.LeadTimeDays
        THEN 'On-Time Delivery'
        ELSE 'Late Delivery'
    END AS DeliveryPerformance

FROM dbo.purchase_orders po
INNER JOIN dbo.suppliers sp 
    ON po.SupplierID = sp.SupplierID
INNER JOIN dbo.products p 
    ON po.ProductID = p.ProductID;
