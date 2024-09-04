#!/bin/bash

# Diretório onde estão as imagens .tar
IMAGES_DIR="/caminho/para/pasta/com/imagens"

# Verifica se o diretório existe
if [ -d "$IMAGES_DIR" ]; then
    # Percorre todos os arquivos .tar na pasta
    for image in "$IMAGES_DIR"/*.tar
    do
        # Importa a imagem Docker
        echo "Importando imagem $image..."
        docker load -i "$image"
        echo "Imagem $image importada com sucesso!"
    done
else
    echo "Diretório $IMAGES_DIR não encontrado!"
fi
