#!/bin/bash

#Executar script e direcionar saida para um arquivo
#sh get-list-all-instances.sh > inventario.csv

# Para obter a lista de compartimentos
compartimentos=$(oci iam compartment list --all --query "data[*].{nome:\"name\", ocid:\"id\"}")

# Para cada compartimento, obtenha a lista de instâncias e o endereço IP
echo "Compartimento, Instância, Endereço IP Público, Endereço IP Privado"
for compartimento in $(echo "${compartimentos}" | jq -r '.[].ocid'); do
    # Obter todas as instâncias do compartimento
    instancias=$(oci compute instance list --compartment-id "${compartimento}" --all --query "data[*].{nome:\"display-name\", id:\"id\"}")
    
    # Para cada instância, obtenha os detalhes do VNIC
    for instancia in $(echo "${instancias}" | jq -r '.[].id'); do
        vnic_id=$(oci compute instance list-vnics --instance-id "${instancia}" --query "data[0].id" --raw-output)
        vnic_details=$(oci network vnic get --vnic-id "${vnic_id}" --query "data.{ipPublico:\"public-ip\", ipPrivado:\"private-ip\"}" --raw-output)
        
        nome_instancia=$(echo "${instancias}" | jq -r --arg id "${instancia}" '.[] | select(.id == $id) | .nome')
        ip_publico=$(echo "${vnic_details}" | jq -r '.ipPublico')
        ip_privado=$(echo "${vnic_details}" | jq -r '.ipPrivado')
        
        nome_compartimento=$(echo "${compartimentos}" | jq -r --arg ocid "${compartimento}" '.[] | select(.ocid == $ocid) | .nome')

        echo "${nome_compartimento}, ${nome_instancia}, ${ip_publico}, ${ip_privado}"
    done
done
