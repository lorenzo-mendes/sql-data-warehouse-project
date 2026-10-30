-- Control: duplicados o nulos en la clave primaria
SELECT cst_id, COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Control: espacios no deseados
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

-- Control: estandarización de valores
SELECT DISTINCT cst_gndr FROM silver.crm_cust_info;
SELECT DISTINCT cst_marital_status FROM silver.crm_cust_info;

   -- ===== crm_prd_info =====
   -- Control: duplicados o nulos en prd_id
   SELECT prd_id, COUNT(*)
   FROM bronze.crm_prd_info
   GROUP BY prd_id
   HAVING COUNT(*) > 1 OR prd_id IS NULL;

   -- Control: costos nulos o negativos
   SELECT prd_cost
   FROM bronze.crm_prd_info
   WHERE prd_cost < 0 OR prd_cost IS NULL;

   -- Control: valores de la línea de producto
   SELECT DISTINCT prd_line FROM bronze.crm_prd_info;

   -- Control: fecha de fin anterior a la de inicio
   SELECT *
   FROM bronze.crm_prd_info
   WHERE prd_end_dt < prd_start_dt;

   -- ===== crm_sales_details =====
   -- Control: productos de ventas que no existen en productos
   SELECT * FROM bronze.crm_sales_details
   WHERE sls_prd_key NOT IN (SELECT prd_key FROM silver.crm_prd_info);

   -- Control: clientes de ventas que no existen en clientes
   SELECT * FROM bronze.crm_sales_details
   WHERE sls_cust_id NOT IN (SELECT cst_id FROM silver.crm_cust_info);

   -- Control: fechas inválidas (cero o sin 8 dígitos)
   SELECT sls_order_dt
   FROM bronze.crm_sales_details
   WHERE sls_order_dt <= 0 OR LEN(sls_order_dt) != 8;

   -- Control: fecha de pedido posterior al envío o al vencimiento
   SELECT * FROM bronze.crm_sales_details
   WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt;

   -- Control: ventas = cantidad x precio, sin nulos, ceros ni negativos
   SELECT DISTINCT sls_sales, sls_quantity, sls_price
   FROM bronze.crm_sales_details
   WHERE sls_sales != sls_quantity * sls_price
      OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
      OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
   ORDER BY sls_sales, sls_quantity, sls_price;

-- ===== erp_cust_az12 =====
-- Control: ids que no coinciden con los clientes del CRM
SELECT cid FROM bronze.erp_cust_az12
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info);

-- Control: fechas de nacimiento fuera de rango
SELECT DISTINCT bdate FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE();

-- Control: valores de género
SELECT DISTINCT gen FROM bronze.erp_cust_az12;

-- ===== erp_loc_a101 =====
-- Control: ids que no coinciden con los clientes del CRM
SELECT cid FROM bronze.erp_loc_a101
WHERE cid NOT IN (SELECT cst_key FROM silver.crm_cust_info);

-- Control: valores de país
SELECT DISTINCT cntry FROM bronze.erp_loc_a101 ORDER BY cntry;

-- ===== erp_px_cat_g1v2 =====
-- Control: espacios no deseados
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance);

-- Control: valores de mantenimiento
SELECT DISTINCT maintenance FROM bronze.erp_px_cat_g1v2;
