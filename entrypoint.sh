#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
LIGHTBLUE='\033[1;34m'
NC='\033[0m' # No Color

function success() {
  echo -e "${GREEN}${1}${NC}"
}

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

  # Setup key for SSHing into the target server
  SSH_DEPLOY_KEY_PATH=~/.ssh/deployment_key
  SSH_CONFIG_PATH=~/.ssh/config
  mkdir -p ~/.ssh
  ls -la ~
  touch $SSH_DEPLOY_KEY_PATH
  chmod 0600 $SSH_DEPLOY_KEY_PATH
  echo -e "$INPUT_CLOUDWAYS_SSH_PRIVATE_KEY" > $SSH_DEPLOY_KEY_PATH
  echo -e "Host target-server\n  HostName ${INPUT_CLOUDWAYS_SERVER}\n  Port ${INPUT_CLOUDWAYS_PORT}\n  User ${INPUT_CLOUDWAYS_USERNAME}\n  IdentityFile ~/.ssh/deployment_key" > $SSH_CONFIG_PATH
  ssh-keyscan -H $INPUT_CLOUDWAYS_SERVER >> ~/.ssh/known_hosts 2> /dev/null
  
  # Check if we can connect to the server
  ssh target-server "echo 2>&1" && success "2. SSH connection OK" || error "Unable to SSH into the server ${LIGHTBLUE}${INPUT_CLOUDWAYS_USERNAME}@${INPUT_CLOUDWAYS_SERVER}${NC}. Please check your ${LIGHTBLUE}cloudways_username${NC} & ${LIGHTBLUE}cloudways_server${NC} inputs. Also make sure cloudways_ssh_private_key was added to Cloudways (for ${LIGHTBLUE}cloudways_username${NC} user)."
  success "All good"
}

function deploy() {
  echo "---------------------------------------"
  echo "Starting deploy()"
  echo "---------------------------------------"

  echo ""
  echo "1. Cloning repository"
  TMP_PATH=~/tmp-deployment/
  cd ~
  ssh-keyscan -H github.com >> ~/.ssh/known_hosts 2> /dev/null
  git clone https://github.com/IvanGrginovInf/deploy-to-cloudways-action.git tmp-deployment
  # git clone git@github.com:IvanGrginovInf/metadev-theme.git $TMP_PATH
  cd $TMP_PATH

  echo ""
  echo "2. Running build script (if set)"
  eval "$INPUT_BUILD_SCRIPT"

  echo ""
  echo "3. Deploying changes to the server"
  ssh target-server "mkdir -p ${INPUT_CLOUDWAYS_DEPLOY_PATH}"
  rsync -avz --delete $TMP_PATH target-server:$INPUT_CLOUDWAYS_DEPLOY_PATH
}

preflightChecklist
deploy