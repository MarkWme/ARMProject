# The Faff-Free Guide to Azure Resource Manager

## Creating a Simple Template to Deploy A Virtual Machine

In this post, I will walk you through the creation of a simple template to deploy a virtual machine. The template created will be far from ideal, in fact, it will only be good for a one-time deployment of a single virtual machine, but it will show you how to create, from scratch, a fully working virtual machine template and will introduce some key concepts.

### Getting Started

As described in *this* post, Visual Studio Code is my recommended tool for Azure Resource Manager deployment template creation. If you're new to Visual Studio Code, take a look at that post first as it will give you some useful hints on how Visual Studio Code can help simplify the template authoring process. 

Of course, you're free to use any text editor you like. So, using your Visual Studio Code or your favourite text editor, create a new, empty file, name it whatever you like but make sure it ends with a `.json` extension.

### The Header

All Azure Resource Manager templates begin with the `$schema`, `contentVersion` sections, so let's add those.

    {
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0"
    }

Next, we add the `resources` section.

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

We can create all of the resources that our virtual machine requires within our Azure Resource Manager (ARM) template, but clearly we now have a situation where we need to ensure that resources are created in a particular order. We can't store the virtual hard drive on storage that doesn't yet exist, neither can be attach a virtual network card to a network that isn't there.

To resolve this, resource manager templates can define dependencies. This is done using the `dependsOn` property.