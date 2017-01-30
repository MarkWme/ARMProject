# The Faff-Free Guide to Azure Resource Manager

## Creating a Simple Template to Deploy A Virtual Machine

In this post, I will walk you through the creation of a simple template to deploy a virtual machine. The template created will be far from ideal, in fact, it will only be good for a one-time deployment of a single virtual machine, but it will show you how to create, from scratch, a fully working virtual machine template and will introduce some key concepts.

### Getting Started

As described in *this* post, Visual Studio Code is my recommended tool for Azure Resource Manager deployment template creation. If you're new to Visual Studio Code, take a look at that post first as it will give you some useful hints on how Visual Studio Code can help simplify the template authoring process. 

Of course, you're free to use any text editor you like. So, using Visual Studio Code or your favourite text editor, create a new empty file, name it whatever you like but make sure it ends with a `.json` extension.

### The Header

All Azure Resource Manager templates begin with the `$schema`, `contentVersion` sections, so let's add those.

    {
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0"
    }

Next, we add the `resources` section after `contentVersion`.

        ...
        "contentVersion": "1.0.0.0"
        "resources": [
            
        ]
    }

And we're ready to add our first resource.

### Adding Resources - Which Resource Do I Add First?

In this example we're deploying a virtual machine. Even if you're not familiar with Azure or virtual machines, you will know that a typical computer is made up of a number of different components, two of those usually being storage and network connectivity. Virtual machines created in Azure are the same. They need some way of connecting to a network and somewhere to store the operating system files and data. Virtual machines and other resource types in Azure often have a relationship with some other Azure resources, so before writing your template it's a good idea to think through exactly what needs to be created.

Our virtual machine is going to need an Azure Storage account in which to store its virtual hard drive. The virtual machine also contains a virtual network interface card (vNIC), which needs an IP address, the IP address needs to be part of the IP address range defined in a particular subnet and the subnet is part of a virtual network.

## Dependencies

In order to complete deployments as quickly as possible, Azure Resource Manager will deploy resources in parallel, meaning that the creation of multiple resources is initiated at the same time so we're not waiting around for each individual resource to be created before we deploy the next. However, this can cause a problem if a resource being created requires another to already exist beforehand. In our virtual machine example, it needs storage and networking to exist before the virtual machine can be created.

Dependencies allow us to resolve this. This is achieved using the `dependsOn` property which we can use to let Azure Resource Manager know that we need another resource to exist before we can create *this* resource. Before commencing the deployment, the template file will be parsed to determine dependencies so that the correct deployment order can be established.

For the virtual machine, we need to create the storage account and virtual networks, so we'll define those resources first in the template file. Later, we can add the definition of the virtual machine and reference the storage and network as dependencies, which will ensure that the storage and network get created before the virtual machine.

## Create a Storage account

In the resources section, add the section to create the storage account.

    ...
    "resources": [
        {
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2016-01-01",
            "sku":{
                "name": "Standard_LRS"
            },
            "kind": "BlobStorage",
            "location": "North Europe",
            "name": "mtjw170130",
            "properties": {
                
            }
        },

`type` specifies the type of resource we want to create which in this instance is `Microsoft.Storage/storageAccounts` as we want to create a Storage Account.

`apiVersion` allows us to choose the version of the API we want to use. Most of the time you will want to use the latest, but there may be times when you want to use a specific version of the API, so you can select that here. Don't forget that you can use CTRL + SPACE to display a list of available options if you're not sure which API versions are available.

`sku` and the `name` parameter contained within it is used to define the type of storage account we are creating. In this instance, we are using "Standrd_LRS", meaning "locally redundant storage". Again, the CTRL + SPACE shortcut can be used to see the available options.

The second `name` parameter in this section specifies a unique name for the storage account. For storage accounts, only lower case alpha-numeric characters are allowed, no hypens, underscores or other characters are permitted.