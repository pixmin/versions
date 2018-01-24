#!/bin/bash

# Try to (not so) cleverly get platforms latest versions from their websites

PATH_TO_VERSIONS='/volumes/users/shared/paybox/bin/versions'

version=''
platform="$1"

# Do not echo version when called from CRON
QUIET=false
while getopts "q" opt
do
    case $opt in
    (q) QUIET=true ; platform="$2" ;;
    esac
done

case "$platform" in
"magento")
	mageContent=$(wget --no-check-certificate http://devdocs.magento.com/guides/m1x/ce19-ee114/ce1.9_release-notes.html -q -O -)
	version=$(echo "$mageContent" | grep -E -o -m 1 -i "Magento Open Source 1\.([0-9.]+)" | grep -E -o "1\.([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
"magento2")
	mageContent=$(wget --no-check-certificate https://magento.com/tech-resources/download -q -O -)
	version=$(echo "$mageContent" | grep -E -o -m 1 -i "ver 2\.([0-9.]+)" | grep -E -o "([0-9.]+)")
	version=$(echo "$version" | grep -m 1 -E "2\.([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
"prestashop")
	prestaContent=$(wget --no-check-certificate https://www.prestashop.com/en/download -q -O -)
	version=$(echo "$prestaContent" | grep -E -m 1 -i "Latest version")
	version=$(echo "$version" | grep -E -o "([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
"prestashop16")
	prestaContent=$(wget --no-check-certificate https://github.com/PrestaShop/PrestaShop/tags -q -O -)
	version=$(echo "$prestaContent" | grep -E -o -m 1 "1\.6\.([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
"prestashop17")
	prestaContent=$(wget --no-check-certificate https://github.com/PrestaShop/PrestaShop/tags -q -O -)
	version=$(echo "$prestaContent" | grep -E -o -m 1 "1\.7\.([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
"wordpress")
	wpContent=$(wget --no-check-certificate https://wordpress.org/download/ -q -O -)
	version=$(echo "$wpContent" | grep -E -o -i "Version ([0-9.]+)")
	version=$(echo $version | grep -E -o "([0-9.]+)")
	if [ "$QUIET" = false ]; then
		echo "$version"
	fi
	;;
esac

# Save version to file
if [ "$version" != "" ]; then
	echo $version > $PATH_TO_VERSIONS/$platform
fi
