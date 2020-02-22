#!/bin/bash

type=$1 # --community or --ultimate
 
install_message="install -> snap install intellij-idea-${type:2}"

if [ "${type:2}" = 'community' ]; then
	echo $install_message
	sudo snap install intellij-idea-community --classic --edge
fi

if [ "${type:2}" = 'ultimate' ]; then
	echo $install_message
	sudo snap install intellij-idea-ultimate --classic --edge
fi
