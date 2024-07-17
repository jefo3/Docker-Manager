#!/usr/bin/env bash
function clean_all_containers() {
  docker stop $(docker ps -q)
  docker rm $(docker ps -aq)
  docker image rmi $(docker images -q) -f
  docker volume prune -f
  docker system prune -f
  docker volume rm $(docker volume list -q)
}

function list_containers() {
  docker ps -a
}

function menu() {
  echo -e " 1 -  List containers \n 2 - Clean All Imagens and Containers \n 3 - Exit"
}

function main() {
  OPTION_SELECTED="0"
  
  echo -e "\033[42;1;37m === Welcome to the Docker Manager! ===\033[0m "
  
  # -ne (not equals)
  while [ "$OPTION_SELECTED" != "3" ]; do
    menu
    read -p $'\033[1;34m Enter your choice: \033[0m' OPTION_SELECTED
    
    case "$OPTION_SELECTED" in
      1)
        list_containers
        ;;
      2)
        clean_all_containers
        ;;
      3)
        echo -e "\033[5;30m Exiting... \033[0m"
    esac
    read -p $'\n\n press any key to continue...'
  done

}


main

