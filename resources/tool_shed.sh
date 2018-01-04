#!/usr/bin/env bash

function msg_info {
   echo -e "\033[1;32m$1\033[0m"
}

function msg_warning {
   echo -e "\033[1;33m$1\033[0m"
}

function msg_error {
   echo -e "\033[1;31m$1\033[0m"
}