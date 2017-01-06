# The No Faff Guide to Azure Resource Manager

## Anatomy of a Template

An Azure Resource Manager (ARM) Template is a plain text file containing data in JSON format.  **JSON data k,v, arrays, objects.**  The simplest ARM template you can create looks like this:

    {  
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "resources": [
        ]
    }

Granted, the above doesn't do anything, but without these lines your ARM template isn't valid.

### Schema

>       "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",


The first line contains a key / value pair with a special purpose. It specifies the [JSON Schema](http://json-schema.org/) for an ARM Template. The schema defines what your ARM template should look like, what things it should contain. The schema can be used to validate a template file. The schema is itself a plain text, JSON format file. If you're interested, just paste **http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#** into a web browser and you can browse through the definition of an ARM template for yourself. In fact, you know we said that the above lines were the minimum required for a valid template, well if you do browse the schema file you'll eventually find ...

    "required": [
            "$schema",
            "contentVersion",
            "resources"
            ],

... which tells us that the `$schema`, `contentVersion` and `resources` sections are **required** for an ARM template to be considered valid.

### Content Version

>       "contentVersion": "1.0.0.0",

The second line defines a version number for this template. It **has** to be made up of four numbers, seperated by dots, as shown. The version numbering system used is up to you, but it makes good sense to figure something out that makes sense to you. For example, you could use a year, month, day and version

>       "contentVersion": "2017.01.06.001"

### Resources

>       "resources": [
>        ]

The third line is where all the action is. The resources section is where you list all of the things you're going to deploy. As you can see it defaults to an empty array, but as you build out your template you'll quickly have many items listed here