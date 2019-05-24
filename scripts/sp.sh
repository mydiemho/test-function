#!/bin/bash

set -e

# az login

SP_NAME="http://myhoTestingPrincipal"
echo "create service principal"
SP_RESPONSE=$(az ad sp create-for-rbac --name ${SP_NAME})
echo "${SP_RESPONSE}"

FILE=".env"
cat <<EOF >${FILE}
    export azureSubId=$(az account show | jq .id)
    export azureServicePrincipalTenantId=$(echo "${SP_RESPONSE}" | jq .tenant)
    export azureServicePrincipalClientId=$(echo "${SP_RESPONSE}" | jq .name)
    export azureServicePrincipalPassword=$(echo "${SP_RESPONSE}" | jq .password)
EOF

echo "Done"