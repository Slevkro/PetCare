##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script encargado de realizar la capa gold y crear modelo estrella específico.

#!/bin/bash

# --- Configuración ---
PROJECT_ID="weighty-legend-423622-k1"
DATASET_ID="gold"
TABLE_NAME="orden_compra"  
LOCATION="US"  
BUCKET_NAME="bronze-us-central-1"

# --- Crear Dataset ---
echo "Creating dataset: $PROJECT_ID.$DATASET_ID"
bq --location=$LOCATION mk --dataset \
    --description "Gold layer for star model" \
    $PROJECT_ID:$DATASET_ID

# --- 2. Crear Tablas Fact y Dimension (vacías) ---
echo "Creating Fact abd Dimensions tables"

# Ejemplo: Reemplaza con tus nombres de tablas y esquemas
bq --location=$LOCATION mk --table \
    --schema "id:INTEGER,fecha:DATE,cliente_id:INTEGER,producto_id:INTEGER,ventas:FLOAT" \
    $PROJECT_ID:$DATASET_GOLD.tabla_fact_ventas

bq --location=$LOCATION mk --table \
    --schema "cliente_id:INTEGER,nombre:STRING,ciudad:STRING" \
    $PROJECT_ID:$DATASET_GOLD.dim_clientes

bq --location=$LOCATION mk --table \
    --schema "producto_id:INTEGER,nombre:STRING,categoria:STRING" \
    $PROJECT_ID:$DATASET_GOLD.dim_productos

# --- 3. Cargar datos en Tablas Dimension ---
echo "Loading data in  Dimension tables..."

# Ejemplo: Reemplaza con tus consultas y nombres de tablas
bq --location=$LOCATION query --use_legacy_sql=false --destination_table=$PROJECT_ID:$DATASET_GOLD.dim_clientes << EOF
SELECT DISTINCT
    cliente_id,
    nombre,
    ciudad
FROM
    `$PROJECT_ID.silver.tabla_clientes_aggregated` 
EOF

bq --location=$LOCATION query --use_legacy_sql=false --destination_table=$PROJECT_ID:$DATASET_GOLD.dim_productos << EOF
SELECT DISTINCT
    producto_id,
    nombre,
    categoria
FROM
    `$PROJECT_ID.silver.tabla_productos_aggregated`
EOF

# --- 4. Cargar datos en Tablas Fact ---
echo "Loading data in Fact table..."

# Ejemplo: Reemplaza con tus consultas y nombres de tablas
bq --location=$LOCATION query --use_legacy_sql=false --destination_table=$PROJECT_ID:$DATASET_GOLD.tabla_fact_ventas << EOF
SELECT
    venta_id,
    fecha_venta,
    cliente_id,
    producto_id,
    total_venta
FROM
    `$PROJECT_ID.silver.tabla_ventas_aggregated`
EOF

echo "Gold layer executed succesfully!"