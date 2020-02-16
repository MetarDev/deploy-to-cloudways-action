#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTBLUE='\033[1;34m'
NC='\033[0m' # No Color

function error() {
  echo -e "${RED}===== ERROR: ${NC} $1"
  exit 1
}

function preflightChecklist() {

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

  echo -e "${GREEN}1. All variables are present${NC}"

  # -------------------------------------------------------------
  # 1. Check ssh connection
  # -------------------------------------------------------------

  # Save key to file
  DEPLOY_KEY_PATH="~/.ssh/deployment_key"
  echo $INPUT_CLOUDWAYS_SSH_PRIVATE_KEY > $DEPLOY_KEY_PATH
  echo -e "Host target-server\n  HostName ${INPUT_CLOUDWAYS_SERVER}\n  Port ${INPUT_CLOUDWAS_PORT}\n  User ${INPUT_CLOUDWAYS_USERNAME}\n  IdentityFile ~/.ssh/deployment_key" > $DEPLOY_KEY_PATH
  echo "---"
  cat ~/.ssh/config
  echo "---"

  # Check if we can connect to the server
  ssh target-server "echo 2>&1" && echo -e "${GREEN}2. SSH connection OK${NC}" || error "Unable to SSH into the server ${LIGHTBLUE}${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER}${NC}. Please check your ${LIGHTBLUE}cloudways_username${NC} & ${LIGHTBLUE}cloudways_server${NC} inputs. Also make sure cloudways_ssh_private_key was added to Cloudways (for ${LIGHTBLUE}cloudways_username${NC} user)."
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