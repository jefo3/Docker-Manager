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

function view_logs() {
  # Get the name of the containers listed by docker
  NAME_CONTAINER=$(docker ps -a --format '{{.Names}}' )

  NAMES_ARRAY=($NAME_CONTAINER)

  
  # Present the list of names for selection using 'select'
  CONTAINER_SELECTED="Select the container you want to see the logs:"
  select NAME in "${NAMES_ARRAY[@]}"; do
    if [ -n "$NAME" ]; then
      docker logs $NAME -f
      break
    else
      echo "Invalid option. Please select again."
    fi
  done
}

function menu() {
  echo -e " 1 -  List containers \n 2 - Clean All Imagens and Containers \n 3 - View Logs \n q - Exit"
}

function main() {
  OPTION_SELECTED="0"
  
  echo -e "\033[42;1;37m === Welcome to the Docker Manager! ===\033[0m "
  
  # -ne (not equals)
  while [ "$OPTION_SELECTED" != "q" ]; do
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
        view_logs
        ;;
      q)
        echo -e "\033[5;30m Exiting... \033[0m"
    esac
    read -p $'\n\n press any key to continue...'
  done

}


main

