#!/bin/bash

## init nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

function logging() {
  echo -e "\n++++ npmv: $1"
}

function get_node_version() {
  version=$1
  re='^[0-9]+$'
  if [[ $version =~ $re ]] ; then
    echo $version
  else
    PACKAGE_FILE=$(cat "$(pwd)/package.json" 2> /dev/null | grep "\"node\": " -m 1)
    PACKAGE_VERSION=$(echo $PACKAGE_FILE | sed -r 's/(\"node\": |\"| )//g')
    if ! [[ "$PACKAGE_VERSION" == "" ]] ; then
      echo ${PACKAGE_VERSION/v/}
      return
    fi

    CURRENT_VERSION=$(nvm current)
    echo ${CURRENT_VERSION/v/}
  fi
}

function set_env_vars() {
  version=$1
  version_split=(${version//./ })
  version_major=${version_split[0]}
  if [ $(echo "${version_major} > 17" | bc) -eq 1 ]; then
    export NODE_OPTIONS=--openssl-legacy-provider
  fi
}

function get_executable_args() {
  args_split=(${1// / })
  version=${args_split[0]}
  all_args=$1
  re='^[0-9]+$'
  if [[ $version =~ $re ]] ; then
    echo ${all_args/$version /}
  else
    echo $all_args
  fi
}

args_split=(${2// / })
NODE_VERSION=$(get_node_version "${args_split[0]}")
if [[ "$NODE_VERSION" == "" ]] ; then
  logging "no current version - exit 1"
  exit 1
fi
EXECUTABLE_ARGS=$(get_executable_args "${2}")
EXECUTABLE_NAME="${1}"

echo "node version: ${NODE_VERSION}"
echo "${EXECUTABLE_NAME} args: ${EXECUTABLE_ARGS}"
echo "workspace: $(pwd)"

cat << EOF
> oh my nvm! <
EOF

## optional
set_env_vars $NODE_VERSION

## set node version
{
  logging "NVM command: nvm use $NODE_VERSION"
  nvm use $NODE_VERSION
} || {
  logging "NVM command: nvm install $NODE_VERSION"
  nvm install $NODE_VERSION

  logging "NVM command: nvm use $NODE_VERSION"
  nvm use $NODE_VERSION
} || {
  logging "error in nvm - exit 1"
  exit 1
}

## run executable command
{
  logging "$EXECUTABLE_NAME command: $EXECUTABLE_NAME $EXECUTABLE_ARGS"
  eval "$EXECUTABLE_NAME $EXECUTABLE_ARGS"

  exit 0
} || {
  logging "error in $EXECUTABLE_NAME command - exit 1"
  exit 1
}