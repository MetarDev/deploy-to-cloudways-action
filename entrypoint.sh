#!/usr/bin/env sh
RED='\033[0;31'
GREEN='\033[0;32m'
LIGHTBLUE='\033[1;34m'
NC='\033[0m' # No Color

function error() {
  echo "${RED}===== ERROR: ${NC}"
  echo "$1"
  echo "${RED}=====${NC}"
  exit 1
}

function preflightChecklist() {

  printenv
  echo "---------------------------------------"
  echo "Starting preflightChecklist()"
  echo "---------------------------------------"


  # -------------------------------------------------------------
  # 1. Check if all environment variables are set
  # -------------------------------------------------------------
  if [ -z ${INPUT_CLOUDWAYS_USERNAME} ]; then
    error "Missing cloudways_username input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_SERVER} ]; then
    error "Missing cloudways_server input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_DEPLOY_PATH} ]; then
    error "Missing cloudways_deploy_path input!"
  fi

  if [ -z ${INPUT_CLOUDWAYS_SSH_PRIVATE_KEY} ]; then
    error "Missing cloudways_ssh_private_key input!"
  fi

  echo "${GREEN}1. All variables are present${NC}"

  echo "${INPUT_CLOUDWAYS_USERNAME}"
  echo "${INPUT_CLOUDWAYS_SERVER}"
  echo "${INPUT_CLOUDWAYS_DEPLOY_PATH}"
  echo "${INPUT_CLOUDWAYS_SSH_PRIVATE_KEY}"

  # -------------------------------------------------------------
  # 1. Check ssh connection
  # -------------------------------------------------------------

  # Save key to file
  echo ${INPUT_CLOUDWAYS_SSH_PRIVATE_KEY} > deployment_key.txt

  # Check if we can connect to the server
  ssh -i deployment_key.txt ${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER} "echo 2>&1" && echo "${GREEN}2. SSH connection OK${NC}" || error "Unable to SSH into the server ${LIGHTBLUE}${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER}${NC}. Please check your ${LIGHTBLUE}cloudways_username${NC} & ${LIGHTBLUE}cloudways_server${NC} inputs. Also make sure cloudways_ssh_private_key was added to Cloudways (for cloudways_username user)."

  # Check if we can access the theme folder
}

function addKeyToKeygen() {
  echo "---------------------------------------"
  echo "Starting addKeyToKeygen()"
  echo "---------------------------------------"
}

function deploy() {
  echo "---------------------------------------"
  echo "Starting deploy()"
  echo "---------------------------------------"
  # cd ~
  # rm -rf ~/tmp-deployment
  # git clone git@github.com:IvanGrginovInf/metadev-theme.git tmp-deployment
  # cd ~/tmp-deployment
  # npm install
  # composer install --no-dev --no-scripts
  # npm run build
  # rsync -avz ~/tmp-deployment metadev_prod@167.172.58.202:~/public_html/wp-content/themes/metadev
}

preflightChecklist
addKeyToKeygen
deploy