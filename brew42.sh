#!/bin/bash

# To colorize output
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# Check if user has directory in goinfre, makes one if not
if [ ! -e "$HOME/goinfre" ] ; then
	echo "${RED}Directory goinfre does not exist."
	echo "${YELLOW}Creating goinfre directory."
    mkdir /goinfre/$(whoami)
	if [ -e "$HOME/goinfre" ] ; then
		echo "${GREEN}Successfully created goinfre directory."
	fi
else
	echo "${GREEN}goinfre directory already exists."
fi

# Check if Homebrew is installed, installs it if not
if [ ! -d "$HOME/goinfre/brew/bin" ] ; then
	echo "${RED}Homebrew is not installed."
	echo "${YELLOW}Installing Homebrew."
	git clone https://github.com/Homebrew/homebrew.git  ~/goinfre/brew
	if [ -d "$HOME/goinfre/brew/bin" ] ; then
		echo "${GREEN}Successfully installed Homebrew."
	fi
fi

# Check if PATH variable has been modified to use homebrew, changes it accordingly
case ":$PATH:" in
  *:/Volumes/Storage/goinfre/etregoni/brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/munki:*) echo "${GREEN}Path OK." ;;
  *) echo "export PATH=/Volumes/Storage/goinfre/$(whoami)/brew/bin:${PATH}" >> ~/.zshrc ; source ~/.zshrc ;;
esac

# Update Homebrew
echo "${YELLOW}Updating Homebrew.${GREEN}"
brew update
echo "${RESET}--------------------"

# Prompt to install / update packages or exit
while true ; do
	read -p "Would you like to install / update any Homebrew packages? [y/n] " yn
	case $yn in
		[Yy]* ) break ;;
		[Nn]* ) exit ;;
		* ) echo "${RED}Please answer y for yes or n to exit.${RESET}"
	esac
done
#  DELETE BETWEEN THE * TO REMOVE THE PROMPT

# ******************************************************************************
# Prompt to install / update Node
while true ; do
	if [ ! -e "$HOME/goinfre/brew/bin/node" ] ; then
		read -p "\nWould you like to install node? [y/n] " yn
		case $yn in
			[Yy]* ) brew install node ; break ;;
			[Nn]* ) break ;;
			* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
		esac
		if [ -e "$HOME/goinfre/brew/bin/node" ] ; then
			echo "${GREEN}Node successfully installed. Version: \c" ; node --version ; echo "${RESET}"
		else
			echo "${RED}Node failed to install.${RESET}"
		fi
	else
		echo  "\nNode is already installed. ${GREEN}Version:${RESET} \c" ; node --version
    	read -p "Would you like to update it? [y/n] " yn
    	case $yn in
        	[Yy]* ) brew upgrade node ; break ;;
        	[Nn]* ) break ;;
        	* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
    	esac
	fi
done
echo "--------------------"
# ******************************************************************************


# ******************************************************************************
# Prompt to update npm
while true ; do
	if [ -e "$HOME/goinfre/brew/bin/node" ] ; then
		if [ ! -e "$HOME/goinfre/brew/bin/npm" ] ; then
			read -p "${YELLOW}You have node, but npm seems to be missing. Would you like to install it?${RESET} [y/n] " yn
			case $yn in
				[Yy]* ) brew install npm ; break ;;
				[Nn]* ) break ;;
				* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
			esac
			if [ -e "$HOME/goinfre/brew/bin/npm" ] ; then
				echo "${GREEN}npm successfully installed. Version: v\c" ; npm --version ; echo "${RESET}"
			else
				echo "${RED}npm failed to install.${RESET}"
			fi
		else
			echo "npm ${GREEN}Version:${RESET} v\c" ; npm --version
			read -p "Would you like to update it? [y/n] " yn
			case $yn in
				[Yy]* ) brew upgrade npm ; break ;;
				[Nn]* ) break ;;
				* ) echo "${RED}Please answer y for yes or n for no.${RESET}"
			esac
		fi
	fi
done
echo "--------------------"
# ******************************************************************************


# ******************************************************************************
# Prompt to install / update bower
while true ; do
	if [ ! -e "$HOME/goinfre/brew/bin/bower" ] ; then
		read -p "Would you like to install Bower? [y/n] " yn
		case $yn in
			[Yy]* ) brew install bower ; break ;;
			[Nn]* ) break ;;
			* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
		esac
		if [ -e "$HOME/goinfre/brew/bin/bower" ] ; then
			echo "${GREEN}Bower successfully installed. Version: v\c" ; bower --version ; echo "${RESET}"
		else
			echo "${RED}Bower failed to install.${RESET}"
		fi
	else
		echo "Bower is already installed. ${GREEN}Version:${RESET} v\c" ; bower --version
		read -p "Would you like to update it? [y/n] " yn
		case $yn in
			[Yy]* ) brew upgrade bower ; break ;;
			[Nn]* ) break ;;
			* ) echo "${RED}Please answer y for yes or n for no.${RESET}"
		esac
	fi
done
echo "--------------------"
# ******************************************************************************

# ------------------------------------------------------------------------------
# *********************INSERT CUSTOM PACKAGES HERE******************************
# ------------------------------------------------------------------------------

# Remove the # between the if and the echo statements and replace PACKAGE-NAME with the package you want to add (no caps)

#if [ ! -e "$HOME/goinfre/brew/bin/PACKAGE-NAME" ] ; then
#  brew install PACKAGE-NAME
#		if [ -e "$HOME/goinfre/brew/bin/PACKAGE-NAME" ] ; then
#			echo "${GREEN}PACKAGE-NAME successfully installed. Version: \c" ; PACKAGE-NAME --version ; echo "${RESET}"
#		else
#			echo "${RED}PACKAGE-NAME failed to install.${RESET}"
#		fi
#else
#	echo  "\nPACKAGE-NAME is already installed. ${GREEN}Version:${RESET} \c" ; PACKAGE-NAME --version
#    while true ;  do
#      read -p "Would you like to update it? [y/n] " yn
#    	case $yn in
#        	[Yy]* ) brew upgrade PACKAGE-NAME ; break ;;
#        	[Nn]* ) break ;;
#        	* ) echo "${RED}Please answer y for yes or n for no.${RESET}" ;;
#    	esac
#    done
#	fi
#done
#echo "--------------------"

# ------------------------------------------------------------------------------
# ************************END CUSTOM PACKAGES***********************************
# ------------------------------------------------------------------------------

# Terminates script
if [ -e "$HOME/goinfre/brew/bin/node" ] && [ -e "$HOME/goinfre/brew/bin/npm" ] && [ -e "$HOME/goinfre/brew/bin/bower" ] ; then
	echo "${YELLOW}********************"
	echo "${GREEN}Homebrew and all packages included in script have been installed successfully, or were already installed"
	echo "${YELLOW}********************${RESET}"
else
	echo "${RED}There was an error installing one or more packages. Scroll up and look for error messages.${RESET}"
fi
exit
