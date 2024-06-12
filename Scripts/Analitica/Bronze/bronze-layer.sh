##@Autor: Jorge Francisco Pereda Ceballos / Brandon Cervantes Rubí / Alexis Isaac Alcocer Diaz
##@Fecha: 03/11/2024
##@Descripción: Script encargado de generar bucket y cargar datos CSV a folders correspondientes

#!/bin/bash

echo "Removing existing previous csv and zip files"
find . -type f -name "*.zip" -exec rm -f {} +
find . -type f -name "*.csv" -exec rm -f {} +


PROJECT_ID="weighty-legend-423622-k1"
BUCKET_NAME="bronze-us-central-1"
url="https://drive.usercontent.google.com/download?id=1Qn0GPacCqMNOJx6UeQSswkSWTS3c_YIi&export=download&authuser=0&confirm=t&uuid=a3ce78ca-06e3-48ed-af84-f697f5670471&at=APZUnTXbFO18edaU5tdWfKEy5jBa:1718169656783"
output_filename="downloaded_data.zip"

# Check if the bucket exists
if gsutil ls -b gs://${BUCKET_NAME} > /dev/null 2>&1; then
  echo "Bucket '$BUCKET_NAME' exists. Deleting..."
  gsutil -m rm -r gs://${BUCKET_NAME}
else
  echo "Bucket '$BUCKET_NAME' does not exist."
fi

gcloud storage buckets create gs://${BUCKET_NAME} \
    --project=${PROJECT_ID} \
    --default-storage-class=Standard \
    --location=us-central1 \
    --uniform-bucket-level-access



echo "Downloading zip csv files"
wget -O "$output_filename" "$url"
unzip $output_filename

TABLES=(
    "orden_compra"
    "servicio_orden_compra"
    "inventario_producto"
    "catalogo_categoria"
    "catalogo_producto"
    "producto_categoria"
)


for TABLE in "${TABLES[@]}"; do
    echo "Creating subfolder: ${TABLE} with CSV data"
    gsutil cp ${TABLE^^}.csv gs://${BUCKET_NAME}/${TABLE}/${TABLE^^}.csv
done

echo "Bucket and subfolders created successfully!" 

echo "Validating bucket created with data inside"
gcloud storage ls -R gs://${BUCKET_NAME}