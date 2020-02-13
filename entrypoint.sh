#!/usr/bin/env sh
function error() {
  echo "===== ERROR: "
  echo "$1"
  echo "====="
  exit 1
}

function preflightChecklist() {

  printenv
  echo "---------------------------------------"
  echo "Starting preflightChecklist()"


  # Check if all environment variables are set
  if [ -z ${INPUT_CLOUDWAYS_USERNAME} ]; then
    error "Missing cloudways_username input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_SERVER} ]; then
    error "Missing cloudways_server input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_DEPLOY_PATH} ]; then
    error "Missing cloudways_deploy_path input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_SSH_KEY} ]; then
    error "Missing cloudways_ssh_key input!"
  fi

  echo "1. All variables are present"

  echo "${INPUT_CLOUDWAYS_USERNAME}"
  echo "${INPUT_CLOUDWAYS_SERVER}"
  echo "${INPUT_CLOUDWAYS_DEPLOY_PATH}"
  echo "${INPUT_CLOUDWAYS_SSH_KEY}"

  # Check if we can connect to the server
  ssh ${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER} "echo 2>&1" && echo "2. SSH connection OK" || error "Unable to SSH into the server ${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER}. Please check your cloudways_username & cloudways_server inputs. Also make sure cloudways_ssh_key was added to Cloudways (for cloudways_username user)."

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