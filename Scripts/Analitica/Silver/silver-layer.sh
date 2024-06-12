##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script encargado de crear dataset y cargar tablas staging junto con vista
##correspondiente a la limpieza de datos.

#!/bin/bash

# --- Configuración ---
PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"
TABLE_NAME="orden_compra"  
LOCATION="US"  
BUCKET_NAME="bronze-us-central-1"

# --- Crear Dataset ---
echo "Creating dataset: $PROJECT_ID.$DATASET_ID"
bq --location=$LOCATION mk --dataset \
    --description "Capa Silver para análisis" \
    $PROJECT_ID:$DATASET_ID

# --- Crear Tabla Staging ---

TABLES=(
    "orden_compra"
    "servicio_orden_compra"
    "inventario_producto"
    "catalogo_categoria"
    "catalogo_producto"
    "producto_categoria"
)

TABLES=(
    "orden_compra"
    "servicio_orden_compra"
    "inventario_producto"
    "catalogo_categoria"
    "catalogo_producto"
    "producto_categoria"
)


for TABLE in "${TABLES[@]}"; do
GCS_CSV_URI="gs://${BUCKET_NAME}/${TABLE}/${TABLE^^}.csv"  

echo "Creating staging table: $PROJECT_ID.$DATASET_ID.${TABLE}_staging"
bq --location=$LOCATION mk --table \
    $PROJECT_ID:$DATASET_ID.${TABLE}_staging \


bq --location=$LOCATION load --autodetect \
    --source_format=CSV \
    $PROJECT_ID:$DATASET_ID.${TABLE}_staging \
    $GCS_CSV_URI
done

##TODO: Crear archivos de correspondientes vistas e invocarlos en este script
# --- Crear Vista Agregada (con limpieza y enriquecimiento) ---
# echo "Creando vista: $PROJECT_ID.$DATASET_ID.$TABLE_NAME\_aggregated"
# bq --location=$LOCATION query --use_legacy_sql=false << EOF
# CREATE OR REPLACE VIEW `$PROJECT_ID.$DATASET_ID.$TABLE_NAME\_aggregated` AS
# SELECT
#     id,
#     -- Limpieza de datos
#     REPLACE(first_name, 'Krista', 'Kristal') AS first_name_cleaned, 
#     TRIM(last_name) AS last_name_cleaned,
#     email,
#     gender,
#     ip_address,
#     date,
#     -- Columna derivada para segmentar la población
#     IF(last_name IN ('Fitzsimons','Schorah','Artinstall'), TRUE, FALSE) AS is_vip,
#     -- Cálculo para reportes
#     CASE
#         WHEN EXTRACT(MONTH FROM date) < 4 THEN 1
#         WHEN EXTRACT(MONTH FROM date) < 8 THEN 2
#         ELSE 3
#     END AS date_quarter
# FROM
#     `$PROJECT_ID.$DATASET_ID.$TABLE_NAME\_stagging`
# WHERE 
#     -- Control de outliers
#     id < 900
# ORDER BY
#     id DESC;
# EOF
 
echo "Silver layer executed succesfully."