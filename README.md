# Brew42 #
## A tool to install Homebrew on 42US iMacs without admin access. ##
### What it does: ###
* Goes through all of the necessary steps to install Homebrew on 42US iMacs and performs any actions needed such as:
  * Checks for local goinfre directory, creates one if it doesn't exist.
  * Checks if homebrew is installed, installs it if not. Updates it if it is.
  * Checks that PATH variable has been changed to use 'brew' and other commands, appends export PATH to .zshrc if it has not been, then reloads .zshrc.
* Installs specific Homebrew packages, and can be edited to add or remove default packages.
* If package is already installed, prompts to update package.

- - - -

## Usage ##
**1.** Open terminal where you want to save the script. <br>
**2.** Type `git clone https://github.com/Etregoning/brew42 && cd $_` <br>
**3.** Type sh brew42.sh <br>
**4.** Follow prompts <br>

- - - -

## Customization ##
### Example Script ###
#### Replace `PACKAGE-NAME` with name of package you want to add. No caps. ####
```
if [ ! -e "$HOME/goinfre/brew/bin/PACKAGE-NAME" ] ; then
  brew install PACKAGE-NAME
		if [ -e "$HOME/goinfre/brew/bin/PACKAGE-NAME" ] ; then
			echo "${GREEN}PACKAGE-NAME successfully installed. Version: \c" ; PACKAGE-NAME --version ; echo "${RESET}"
		else
			echo "${RED}PACKAGE-NAME failed to install.${RESET}"
		fi
else
	echo  "\nPACKAGE-NAME is already installed. ${GREEN}Version:${RESET} \c" ; PACKAGE-NAME --version
    while true ;  do
      read -p "Would you like to update it? [y/n] " yn
    	case $yn in
        	[Yy]* ) brew upgrade PACKAGE-NAME ; break ;;
        	[Nn]* ) break ;;
        	* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
    	esac
    done
	fi
done
echo "--------------------"
```
- - - -

# TO DO #
- [ ] At the end, list details about any errors that might have occured.
- [ ] Write said errors into log file as well
