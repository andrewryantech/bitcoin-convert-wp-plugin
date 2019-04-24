#!/usr/bin/env bash
####################################################################################
# Helper script to package a plugin release and publish it to the Wordpress SVN repo
####################################################################################

# CD to this file's directory
cd $( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Generate optimised composer files
echo "Generating latest composer files"
composer dump-autoload --classmap-authoritative -vvv

# Derive previous tag
prevTag=`git tag | sort -V | egrep "^[0-9]" | tail -n1`
echo "Previous tag: '$prevTag'"

# Prompt for new tag
# TODO suggest new tag is PATCH increment from prev tag
read -p "Please enter the new tag, eg '1.2.3': " tag
if [[ `echo ${tag} | grep -P -e '^[\d]+\.[\d]+\.[\d]+$'` == '' ]]
then
  echo "Tag appears invalid. Please use format [MAJOR].[MINOR].[PATCH] where each element is numeric"
  exit 1;
fi

# Update relevant files with the new tag
sed -i "s/Stable tag: *$prevTag/Stable tag: $tag/g" real-time-bitcoin-currency-converter/README.txt
sed -i "s/Version: *$prevTag/Version: $tag/g" real-time-bitcoin-currency-converter/bitcoin-convert.php
sed -i "s/const VERSION *= *'$prevTag/const VERSION = '$tag/g" real-time-bitcoin-currency-converter/lib/Plugin.php
sed -i "s/version: *\"$prevTag/version: \"$tag/g" real-time-bitcoin-currency-converter/assets/js/tinymce-plugin.js

echo "Tag changes:"
git --no-pager diff --unified=0 \
	real-time-bitcoin-currency-converter/README.txt \
	real-time-bitcoin-currency-converter/bitcoin-convert.php \
	real-time-bitcoin-currency-converter/lib/Plugin.php \
	real-time-bitcoin-currency-converter/assets/js/tinymce-plugin.js


# Prompt user to update changelog by printing all commits since last tag
echo '';
echo "Please update changelog items for the following commits"
git log --oneline ${prevTag}..HEAD
echo "You need to edit 'real-time-bitcoin-currency-converter/README.txt'"
read -p "Press Enter when done " scratch

# Add files, commit, and tag
echo "Adding al files to git and tagging..."
git add .
git commit -m "Prepare release '$tag'"
git tag ${tag}

# Push commit and tag to git origin repo
git push origin HEAD
git push origin --tags

# Copy files to svn trunk
# @see https://developer.wordpress.org/plugins/wordpress-org/how-to-use-subversion/
echo "Copying files to svn trunk"
rm -rf real-time-bitcoin-currency-converter-svn/trunk/*
cp -r real-time-bitcoin-currency-converter/* real-time-bitcoin-currency-converter-svn/trunk

# Add new files to svn
cd real-time-bitcoin-currency-converter-svn
svn add trunk/*
svn cp trunk "tags/$tag"

# Check in svn changes with appropriate message
svn ci -m "Tagging version $tag"
