#!/usr/bin/env sh

function preflightChecklist() {
  # Check if all environment variables are set
  # Check if we can connect to the server
  # Check if we can access the theme folder
}

function addKeyToKeygen() {
  
}

function deploy() {
  cd ~
  rm -rf ~/tmp-deployment
  git clone git@github.com:IvanGrginovInf/metadev-theme.git tmp-deployment
  cd ~/tmp-deployment
  npm install
  composer install --no-dev --no-scripts
  npm run build
  rsync -avz ~/tmp-deployment metadev_prod@167.172.58.202:~/public_html/wp-content/themes/metadev
}

preflightChecklist
addKeyToKeygen
deploy
