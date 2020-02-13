#!/usr/bin/env sh

function preflightChecklist() {

  echo "---------------------------------------"
  echo "Starting preflightChecklist()"

  printenv

  # Check if all environment variables are set
  if [ -z ${INPUT_CLOUDWAYS_USERNAME} ]; then
    echo "Missing cloudways_username input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS_SERVER} ]; then
    echo "Missing cloudways_server input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS_DEPLOY_PATH} ]; then
    echo "Missing cloudways_deploy_path input!"
    exit 1
  fi

  if [ -z ${INPUT_CLOUDWAYS_SSH_KEY} ]; then
    echo "Missing cloudways_ssh_key input!"
    exit 1
  fi

  echo "${INPUT_CLOUDWAYS_USERNAME}"
  echo "${INPUT_CLOUDWAYS_SERVER}"
  echo "${INPUT_CLOUDWAYS_DEPLOY_PATH}"
  echo "${INPUT_CLOUDWAYS_SSH_KEY}"

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