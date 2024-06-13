##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script que crea vista producto categoría.

PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"

bq query --nouse_legacy_sql \
'CREATE VIEW `'"$PROJECT_ID"'.'"$DATASET_ID"'.producto_categoria_refined` AS (
  SELECT
    PRODUCTO_CATEGORIA_ID,
    CATALOGO_PRODUCTO_ID,
    CATALOGO_CATEGORIA_ID,
    PRECIO,
    FECHA
  FROM
   `'"$PROJECT_ID"'.'"$DATASET_ID"'.producto_categoria_staging`
)'
