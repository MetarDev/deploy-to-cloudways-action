#!/usr/bin/env sh

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

addKeyToKeygen
deploy