# Bito CLI
This is the official repository or tap for Bito CLI to support installation via homebrew.

### Using Homebrew for Bito CLI:
1. Before using homebrew, please make sure that you uninstall any previously installed versions of Bito CLI using the uninstall script provided [here](https://github.com/gitbito/CLI#uninstalling-bito-cli).
2. Once above is done then you can use following commands to install Bito CLI using homebrew:
    - First tap the CLI repo using ```brew tap gitbito/bitocli```, this should be a one time action and not required every time.
    - Now you can install Bito CLI using following command:
        - ```brew install bito-cli``` - this should install Bito CLI based upon your machine architecture.
    - To update Bito CLI to the latest version, use following commands:
        - Please make sure you always do ```brew update``` before upgrading to avoid any errors.
        - ```brew update``` - this will update all the required packages before upgrading.
        - ```brew upgrade bito-cli``` - once above is done, this will update Bito CLI to the latest version.
    - To uninstall Bito CLI you can either use the uninstall command from [here](https://github.com/gitbito/CLI#uninstalling-bito-cli) or use following commands:
        - ```brew uninstall bito-cli``` - this should uninstall Bito CLI completely from your system.

## License ##

Copyright (C) 2021, Bito Inc - All Rights Reserved