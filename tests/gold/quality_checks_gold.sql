   /*
   Controles de calidad de la capa Gold:
   unicidad de claves sustitutas e integridad del modelo estrella.
   */

   -- Control: customer_key único en dim_customers
   SELECT customer_key, COUNT(*)
   FROM gold.dim_customers
   GROUP BY customer_key
   HAVING COUNT(*) > 1;

   -- Control: product_key único en dim_products
   SELECT product_key, COUNT(*)
   FROM gold.dim_products
   GROUP BY product_key
   HAVING COUNT(*) > 1;

   -- Control: toda venta conecta con su cliente y su producto
   SELECT *
   FROM gold.fact_sales f
   LEFT JOIN gold.dim_customers c ON f.customer_key = c.customer_key
   LEFT JOIN gold.dim_products p ON f.product_key = p.product_key
   WHERE c.customer_key IS NULL OR p.product_key IS NULL;
