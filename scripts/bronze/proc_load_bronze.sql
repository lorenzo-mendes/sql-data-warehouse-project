CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
BEGIN TRY
SET @batch_start_time = GETDATE();
    PRINT '====================';
    PRINT 'Cargando capa Bronze';
    PRINT '====================';

    PRINT '-----------------------';
    PRINT 'Cargando tablas del CRM';
    PRINT '-----------------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    PRINT '>> Insertando datos en: bronze.crm_cust_info';
    BULK INSERT bronze.crm_cust_info
    FROM '/datasets/source_crm/cust_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
PRINT '>> -------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    PRINT '>> Insertando datos en: bronze.crm_prd_info';
    BULK INSERT bronze.crm_prd_info
    FROM '/datasets/source_crm/prd_info.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
PRINT '>> -------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    PRINT '>> Insertando datos en: bronze.crm_sales_details';
    BULK INSERT bronze.crm_sales_details
    FROM '/datasets/source_crm/sales_details.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
   PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
   PRINT '>> -------------';

    PRINT '------------------------';
    PRINT 'Cargando tablas del ERP';
    PRINT '------------------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    PRINT '>> Insertando datos en: bronze.erp_cust_az12';
    BULK INSERT bronze.erp_cust_az12
    FROM '/datasets/source_erp/CUST_AZ12.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
PRINT '>> -------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    PRINT '>> Insertando datos en: bronze.erp_loc_a101';
    BULK INSERT bronze.erp_loc_a101
    FROM '/datasets/source_erp/LOC_A101.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
PRINT '>> -------------';
SET @start_time = GETDATE();
    PRINT '>> Vaciando tabla: bronze.erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    PRINT '>> Insertando datos en: bronze.erp_px_cat_g1v2';
    BULK INSERT bronze.erp_px_cat_g1v2
    FROM '/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (FIRSTROW = 2, FIELDTERMINATOR = ',', ROWTERMINATOR = '0x0d0a', TABLOCK);
SET @end_time = GETDATE();
PRINT '>> Duración: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' segundos';
PRINT '>> -------------';
SET @batch_end_time = GETDATE();
   PRINT '================================================';
   PRINT 'Carga de la capa Bronze completada';
   PRINT 'Duración total: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' segundos';
   PRINT '================================================';
END TRY
BEGIN CATCH
PRINT '================================================';
PRINT 'ERROR durante la carga de la capa Bronze';
PRINT 'Mensaje: ' + ERROR_MESSAGE();
PRINT 'Número de error: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
PRINT 'Estado: ' + CAST(ERROR_STATE() AS NVARCHAR);
PRINT '================================================';
END CATCH
END
