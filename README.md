# sql-data-warehouse-project
# DATA WAREHOUSE CON SQL SERVER
Proyecto de data warehouse construido desde cero con SQL Server, siguiendo una arquitectura Medallion (Bronza -> Silver -> Gold).
Integra datos de ventas de 2 sistemas (CRM y ERP), los limpia y los organiza en un modelo estrella listo para reportes y analisis.
Proyecto hecho a partir del tutorial "SQL Data Warehouse from Scratch" de *Data With Baraa* (https://www.youtube.com/watch?v=9GVqKuTVANE)

ARQUITECTURA

CAPA: Bronze 
QUE CONTIENE: Datos crudos CSV 
TIPO DE OBJETO: Tablas 
CARGA: Full load (truncate + insert)

CAPA: Silver
QUE CONTIENE: Datos limpios y estandarizados
TIPO DE OBJETO: Tablas
CARGA: Full load (truncate + insert)

CAPA: Gold
QUE CONTIENE: Modelo estrella listo para el negocio
TIPO DE OBJETO: Vistas
CARGA: —

REQUISITOS DEL PROYECTO
- OBJETIVO: construir un datawarehouse en SQL Server que consolide los datos de ventas para facilitar el analisis y la toma de decisiones.
- FUENTES: 2 sistemas, ERP y CRM, como archivos CSV.
- CALIDAD DE DATOS: detecter y corregir problemas antes del analisis.
- INTEGRACION: unir ambas fuentes en un unico modelo, simple de consultar.
- ALCANCE: solo datos actuales, sin historizacion.
- DOCUMENTACION: documentar el modelo para usuarios de negocio y analistar.

ESTRUCTURA DEL REPOSITORIO
sql-data-warehouse-project/
- datasets/ CSV de origen (CRM y ERP)
- docs/ Diagramas y catalogo de datos
- scripts/ Scripts SQL por capa
- tests/ Controles de calidad de datos
- LICENSE
- README.md

sql-dwh/
├── datasets/
│   ├── source_crm/  (3 CSV)
│   └── source_erp/  (3 CSV)
├── docs/
│   ├── diagramas_dwh.drawio + diagramas_dwh.jpg
│   ├── data_integration.drawio + data_integration.png
│   ├── data_model.drawio + data_model.png
│   └── data_catalog.md
├── scripts/
│   ├── init_database.sql
│   ├── bronze/  ddl_bronze.sql, proc_load_bronze.sql
│   ├── silver/  ddl_silver.sql, proc_load_silver.sql
│   └── gold/    ddl_gold.sql
└── tests/
    ├── quality_checks_silver.sql
    └── quality_checks_gold.sql

HERRAMIENTAS
- SQL Server 2022 (en Docker, sobre macOS)
- VS Code con la extension SQL Server (mssql)
- draw.io
- Git y Github

LICENCIA
Proyecto bajo licencia [MIT](LICENSE)

LinkedIn: https://www.linkedin.com/in/lorenzomendess/
