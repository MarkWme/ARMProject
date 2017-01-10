# The No Faff Guide to Azure Resource Manager

## Creating and Editing Templates with Visual Studio

Azure Resource Manager (ARM) templates are plain text files and can be created or edited in any text editor. I recommend [Visual Studio Code](https://code.visualstudio.com/) as the best tool for template creation and editing. There are a lot of choices when it comes to text editors, but I like **Code** because it's quick and easy to install, it has a large and growing library of high quality extensions and it's under active development with new features and refinements being added every month. On top of that, Code works on Windows, macOS or Linux and it's [open source](https://github.com/Microsoft/vscode).

Code isn't just a text editor, it's a development environment. Because of this, Code can help you create and edit your template, pointing out problems and helping you fix them as you go.

### Installing Visual Studio Code
(install code on Surface Pro, record first time install experience)

### Installing Extensions for Azure Resource Manager

(do you need anything in particular for Code to read JSON schema?)
(What does the ARM extension do specifically?)
(Install the Azure Tools extension)

### How Does Visual Studio Code Help You Create and Edit ARM Templates?

Open Visual Studio Code and create a new file with a `.json` extension. Code should automatically determine from the extension that this is a JSON file. If you check the bottom right of Code's application window, it will tell you what the current language mode is. If it hasn't switched to JSON for some reason, you can manually select JSON from the *Command Palette* by pressing CTRL-SHIFT-P, then type `language` and select "Change Language Mode", then type and select JSON.

Next, open up the "Problems" panel either by pressing CTRL-SHIFT-M or choosing "Problems" from the "View" menu.  I find it useful to have the Problems panel open whilst developing as it helps identify issues with your template, as I'll demonstrate now.

Let's start by creating the minimum required for a JSON document.  In our case, an empty object.  So, just type an empty curly bracket or brace `{` and Code should auto-complete the closing brace for you. Press enter and Code will reformat the layout and position the cursor ready for your first line.

    {

    }

Next, type a quote `"` and Code should automatically prompt you with the option to insert `$schema`

(image of Code prompting)

At this point, simply press the tab key on your keyboard and Code will auto-complete adding `$schema`, closing quote and a colon.

    {
        "$schema":
    }

Now, Code's good but here you have to give it a little clue as to which JSON schema you want to use.  Complete the line by adding the reference to the Azure Resource Manager schema.

    {
        "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#"
    }

If you look at your Problems panel now, it should now be telling you that there's something wrong with your template. Specifically that it's missing two properties - `contentVersion` and `resources`. Visual Studio Code [understands JSON schemas natively](https://code.visualstudio.com/Docs/languages/json#_json-schemas-settings), so as you type it's reviewing the schema that you've referenced and validating your JSON document against that schema.  In this case, it's detected that the ARM deployment template schema specifies that `$schema`, `contentVersion` and `resources` must all be present for a template to be valid.