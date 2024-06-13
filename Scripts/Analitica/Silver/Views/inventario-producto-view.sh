##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script que crea vista de  inventario producto

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"

bq query  --nouse_legacy_sql \
'CREATE VIEW `'"$PROJECT_ID"'.'"$DATASET_ID"'.inventario_producto_refined` AS (
  SELECT
    INVENTARIO_PRODUCTO_ID,
    ORDEN_COMPRA_ID,
    NUM_INVENTARIO,
    FECHA, 
    VETERINARIA_ID,
    CATALOGO_PRODUCTO_ID
  FROM
      `'"$PROJECT_ID"'.'"$DATASET_ID"'.inventario_producto_staging`
)'