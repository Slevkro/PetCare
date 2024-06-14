##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script que crea vista orden compra.

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"

bq query --nouse_legacy_sql \
'CREATE VIEW `'"$PROJECT_ID"'.'"$DATASET_ID"'.orden_compra_refined` AS (
  SELECT
    ORDEN_COMPRA_ID,
    FOLIO,
    FECHA_SOLICITUD,
    SAFE_CAST(IMPORTE_TOTAL AS FLOAT64) AS IMPORTE_TOTAL,
    SAFE_CAST(IMPORTE_SERVICIO AS FLOAT64) AS IMPORTE_SERVICIO,
    SAFE_CAST(IMPORTE_PRODUCTOS AS FLOAT64) AS IMPORTE_PRODUCTOS,
    CLIENTE_ID,
    EMPLEADO_ID
  FROM
    `'"$PROJECT_ID"'.'"$DATASET_ID"'.orden_compra_staging`
)'
