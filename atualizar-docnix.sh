#!/bin/bash

array=()
find . -maxdepth 1 -type f -name "*.war" -print0 >docnixLista
while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
done <docnixLista
rm -f docnixLista

select opt in "${array[@]}" "Sair do script"; do
  case $opt in
    *.war)
      echo "Arquivo $opt selected"
      read -p "Pressione qualquer tecla para continuar ou ctrl+c interrompe..."
      echo "Descompactando..."
      unzip -q $opt -d docnix;
      echo "Configurando context.xml"
      cp ./context.xml docnix/META-INF/context.xml;
      echo "Parando docker..."
      docker stop tr-postgres
      echo "Limpando arquivos temp, logs, work, apagar arquivo antigo, movendo novo..."
      rm -fr work/* logs/* temp/* webapps/docnix && mv docnix webapps/
      echo "Iniciando container..."
      docker start tr-postgres;
      ;;
    "Sair do script")
      echo "Vc saiu!"
      break
      ;;
    *)
      echo "Escolha um numero"
      ;;
  esac
done
