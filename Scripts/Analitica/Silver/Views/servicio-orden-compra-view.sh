##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script que crea vista servicio orden compra.

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"

bq query --nouse_legacy_sql \
'CREATE VIEW `'"$PROJECT_ID"'.'"$DATASET_ID"'.servicio_orden_compra_refined` AS (
  SELECT
    DISTINCT 
    SERVICIO_ORDEN_COMPRA_ID,
    SERVICIO_ID,
    ORDEN_COMPRA_ID
  FROM
    `'"$PROJECT_ID"'.'"$DATASET_ID"'.servicio_orden_compra_staging`
)'
