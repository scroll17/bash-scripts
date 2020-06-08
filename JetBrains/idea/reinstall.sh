#!/bin/bash

type=$1
next_options=$2

remove_message="remove -> snap remove intellij-idea-${type:2}"
install_message="install -> snap install intellij-idea-${type:2}"
rm_message="clear -> sudo rm -rf ~/.local/share/JetBrains"

if [ "${type:2}" = 'community' ]; then
	echo $remove_message
	sudo snap remove intellij-idea-community

	echo "$rm_message"
	sudo rm -rf ~/.local/share/JetBrains
fi

if [ "${type:2}" = 'ultimate' ]; then
	echo $remove_message
	sudo snap remove intellij-idea-ultimate

	echo "$rm_message"
	sudo rm -rf ~/.local/share/JetBrains
fi


if [ "${next_options:2}" = 'yes' ]; then
	echo $install_message
	bash ./install-IDEA.sh $type	
fi
