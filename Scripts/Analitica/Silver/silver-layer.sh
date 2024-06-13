##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script encargado de crear dataset y cargar tablas staging junto con vista
##correspondiente a la limpieza de datos.

#!/bin/bash

--- Configuración ---
PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="silver"
TABLE_NAME="orden_compra"  
LOCATION="US"  
BUCKET_NAME="bronze-us-central-1"

# --- Crear Dataset ---
echo "Creating dataset: $PROJECT_ID.$DATASET_ID"
bq --location=$LOCATION mk --dataset \
    --description "Silver layer for analytics" \
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

echo "Creating refined views with cleaned data"

./Views/inventario-producto-view.sh
./Views/catalogo-producto-view.sh
./Views/catalogo-categoria-view.sh
./Views/orden-compra-view.sh
./Views/producto-categoria-view.sh
./Views/servicio-orden-compra-view.sh


echo "Silver layer executed succesfully."