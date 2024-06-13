##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script que crea vista de catalogo producto

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"

bq query --nouse_legacy_sql \
'CREATE VIEW `'"$PROJECT_ID"'.'"$DATASET_ID"'.catalogo_producto_refined` AS (
  SELECT
    CATALOGO_PRODUCTO_ID,
    NOMBRE, 
    PRECIO,
    TRIM(DESCRIPCION) AS DESCRIPCION
  FROM
      `'"$PROJECT_ID"'.'"$DATASET_ID"'.catalogo_producto_staging`
)'
 