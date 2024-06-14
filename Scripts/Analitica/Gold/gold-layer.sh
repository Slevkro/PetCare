##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script encargado de realizar la capa gold y crear modelo estrella específico.

#!/bin/bash

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="gold"
DATASET_SILVER_ID="silver"
TABLE_NAME="orden_compra"  
LOCATION="US"  
BUCKET_NAME="bronze-us-central-1"

echo "Creating dataset: $PROJECT_ID.$DATASET_ID"
bq --location=$LOCATION mk --dataset \
    --description "Gold layer for star model" \
    $PROJECT_ID:$DATASET_ID

echo "Creating Fact and Dimensions tables"

bq query --nouse_legacy_sql \
  'CREATE TABLE `'"$PROJECT_ID"'.'"$DATASET_ID"'.fact_ventas`( 
    `VETERINARIA_ID` INT64 NOT NULL,
    `EMPLEADO_ID` INT64 NOT NULL,
    `COMISION_VENTA` FLOAT64 NOT NULL,
    `FECHA_VENTA` DATE NOT NULL,
    `TRIMESTRE` INT64 NOT NULL,
    `SEMESTRE` STRING NOT NULL,
    `ANIO` INT64 NOT NULL,
    `IMPORTE_TOTAL` FLOAT64 NOT NULL,
    `IMPORTE_SERVICIO` FLOAT64 NOT NULL,
    `IMPORTE_PRODUCTOS` FLOAT64 NOT NULL,
  )'


bq query --nouse_legacy_sql \
  'CREATE TABLE `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_inventario_producto`( 
    `INVENTARIO_PRODUCTO_ID` INT64 NOT NULL,
    `ORDEN_COMPRA_ID` INT64 NOT NULL,
    `NUM_INVENTARIO` INT64 NOT NULL,
    `FECHA` DATE NOT NULL,
    `VETERINARIA_ID` INT64 NOT NULL,
    `CATALOGO_PRODUCTO_ID` INT64 NOT NULL
  )'


bq query --nouse_legacy_sql \
  'CREATE TABLE `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_tiempo`( 
    `TIEMPO_ID` INT64 NOT NULL,  
    `FECHA` DATE NOT NULL,
    `SEMESTRE` STRING NOT NULL,
    `ANIO` INT64 NOT NULL,
    `TRIMESTRE` INT64 NOT NULL
  )'


bq query --nouse_legacy_sql \
  'CREATE TABLE `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_orden_compra`( 
    `ORDEN_COMPRA_ID` INT64 NOT NULL,
    `FOLIO` STRING NOT NULL,
    `FECHA_SOLICITUD` DATE NOT NULL, 
    `IMPORTE_TOTAL` FLOAT64 NOT NULL,
    `IMPORTE_SERVICIO` FLOAT64 NOT NULL,
    `IMPORTE_PRODUCTOS` FLOAT64 NOT NULL, 
    `EMPLEADO_ID` INT64 NOT NULL
  )'

bq query --nouse_legacy_sql \
  'CREATE TABLE `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_empleado`( 
    `EMPLEADO_ID` INT64 NOT NULL,
    `COMISION_TOTAL` FLOAT64 NOT NULL
  )'


echo "Loading data in  Dimension tables..."


bq --location=$LOCATION query --use_legacy_sql=false \
    --destination_table=$PROJECT_ID:$DATASET_ID.dim_inventario_producto \
    'SELECT * FROM `'"$PROJECT_ID"'.'"$DATASET_SILVER_ID"'.inventario_producto_refined`'

bq --location=$LOCATION query --use_legacy_sql=false \
    --destination_table=$PROJECT_ID:$DATASET_ID.dim_orden_compra \
    'SELECT orden_compra_id, folio, fecha_solicitud,importe_total,importe_servicio, importe_productos, empleado_id 
    FROM `'"$PROJECT_ID"'.'"$DATASET_SILVER_ID"'.orden_compra_refined`'

bq --location=$LOCATION query --use_legacy_sql=false \
    'CREATE TEMP FUNCTION GetSemestre(fecha DATE) AS (
      CASE 
        WHEN CAST(FORMAT_DATE("%m", fecha) AS INT64) BETWEEN 1 AND 6 THEN "1"
        ELSE "2"
      END
    );

    CREATE TEMP FUNCTION GetTrimestre(fecha DATE) AS (
      CASE
        WHEN CAST(FORMAT_DATE("%m", fecha) AS INT64) BETWEEN 1 AND 3 THEN 1
        WHEN CAST(FORMAT_DATE("%m", fecha) AS INT64) BETWEEN 4 AND 6 THEN 2
        WHEN CAST(FORMAT_DATE("%m", fecha) AS INT64) BETWEEN 7 AND 9 THEN 3
        ELSE 4
      END 
    );
    
    INSERT INTO `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_tiempo`
    SELECT 
      DISTINCT
      OC.ORDEN_COMPRA_ID,
      OC.FECHA_SOLICITUD,
      GetSemestre(OC.FECHA_SOLICITUD) AS SEMESTRE,
      EXTRACT(YEAR FROM OC.FECHA_SOLICITUD) AS ANIO,
      GetTrimestre(OC.FECHA_SOLICITUD) AS TRIMESTRE
    FROM 
      `'"$PROJECT_ID"'.'"$DATASET_SILVER_ID"'.orden_compra_refined` AS OC;'


bq --location=$LOCATION query --use_legacy_sql=false \
    --destination_table=$PROJECT_ID:$DATASET_ID.dim_empleado \
    'SELECT DISTINCT EMPLEADO_ID, (0.05 * IMPORTE_TOTAL) AS COMISION_TOTAL FROM `'"$PROJECT_ID"'.'"$DATASET_SILVER_ID"'.orden_compra_refined`'

echo "Loading data in Fact table..."


bq --location=$LOCATION query --use_legacy_sql=false \
    --destination_table=$PROJECT_ID:$DATASET_ID.fact_ventas \
    'SELECT E.EMPLEADO_ID, E.COMISION_TOTAL AS COMISION_VENTA, 
     IP.VETERINARIA_ID, T.FECHA AS FECHA_VENTA,
     T.TRIMESTRE, T.ANIO, T.SEMESTRE, OC.IMPORTE_TOTAL, OC.IMPORTE_SERVICIO, OC.IMPORTE_PRODUCTOS 
     FROM `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_empleado` AS E
     JOIN `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_orden_compra` AS OC  
       ON E.EMPLEADO_ID = OC.EMPLEADO_ID
     JOIN `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_tiempo` AS T 
       ON T.TIEMPO_ID = OC.ORDEN_COMPRA_ID
     JOIN `'"$PROJECT_ID"'.'"$DATASET_ID"'.dim_inventario_producto` AS IP 
       ON IP.ORDEN_COMPRA_ID = OC.ORDEN_COMPRA_ID;'


echo "Gold layer executed succesfully!"

