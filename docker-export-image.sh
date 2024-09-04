#!/bin/bash
for image in $(docker images --format "{{.Repository}}:{{.Tag}}")
do
    filename=$(echo $image | sed 's/\//_/g').tar
    docker save -o $filename $image
    echo "Imagem $image exportada para $filename"
done
