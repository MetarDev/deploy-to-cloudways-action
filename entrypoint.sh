#!/usr/bin/env sh

function preflightChecklist() {

  echo "---------------------------------------"
  echo "Starting preflightChecklist()"

  # Check if all environment variables are set
  if [ -z ${INPUT_CLOUDWAYS-USERNAME} ]; then
    echo "Missing cloudways-username input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS-SERVER} ]; then
    echo "Missing cloudways-server input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS-DEPLOY-PATH} ]; then
    echo "Missing cloudways-deploy-path input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS-SSH-KEY} ]; then
    echo "Missing cloudways-ssh-key input!"
    exit 1
  fi

  echo "${INPUT_CLOUDWAYS-USERNAME}"
  echo "${INPUT_CLOUDWAYS-SERVER}"
  echo "${INPUT_CLOUDWAYS-DEPLOY-PATH}"
  echo "${INPUT_CLOUDWAYS-SSH-KEY}"

  # Check if we can connect to the server
  # Check if we can access the theme folder
  echo "---------------------------------------"
}

function addKeyToKeygen() {
  echo "---------------------------------------"
  echo "Starting addKeyToKeygen()"
  echo "---------------------------------------"
}

function deploy() {
  echo "---------------------------------------"
  echo "Starting deploy()"
  # cd ~
  # rm -rf ~/tmp-deployment
  # git clone git@github.com:IvanGrginovInf/metadev-theme.git tmp-deployment
  # cd ~/tmp-deployment
  # npm install
  # composer install --no-dev --no-scripts
  # npm run build
  # rsync -avz ~/tmp-deployment metadev_prod@167.172.58.202:~/public_html/wp-content/themes/metadev
  echo "---------------------------------------"
}

preflightChecklist
addKeyToKeygen
deploy