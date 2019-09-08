az login

az vm deallocate --resource-group "rg-azurecli" --name "virtual-mac-win"

az vm list --show-details --output table

az vm generalize --resource-group "rg-azurecli" --name "virtual-mac-win"

az image create --resource-group "rg-azurecli" --name "Image-AzureCLI" --source "virtual-mac-win"

az image list --output table

az vm create --resource-group "rg-azurecli" --name "Image-VM-CLI" --location "centralus" --image "Image-AzureCLI" --admin-username "mwalia" --admin-password "January@2017"