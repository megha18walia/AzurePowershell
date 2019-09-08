az login

az group create --name "rg-azurecli" --location "centralus"

az group list -o table

az Network Vnet Create --resource-group "rg-azurecli" --name "vnet-test" --address-prefix "10.1.0.0/16" --subnet-name "subnet-test" --subnet-prefix "10.1.1.0/24"

az Network Vnet List -o table

az Network public-ip create --resource-group "rg-azurecli" --name "public-ip-win"

az Network nsg create --resource-group "rg-azurecli" --name "network-security-win"

az network nic create --resource-group "rg-azurecli" --name "network-interface-win" --vnet-name "vnet-test" --subnet "subnet-test" --public-ip-address "public-ip-win" --network-security-group "network-security-win"

az vm create --resource-group "rg-azurecli" --name "virtual-mac-win" --image "win2016datacenter" --admin-username "mwalia" --admin-password "January@2017" --size "basic_A1" --nics "network-interface-win"

az vm open-port --port "3389" --resource-group "rg-azurecli" --name "virtual-mac-win"

az  