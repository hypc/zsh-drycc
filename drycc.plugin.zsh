drycc() {
  if [[ "$*" == *"--help"* ]]; then
    command drycc "$@"
  elif [[ "$1" == "login" ]]; then
    if [[ -f ~/.drycc/client.json ]]; then
      cur_controller=$(cat ~/.drycc/client.json | jq -r '.controller | split("://") | .[1]')
      cp ~/.drycc/client.json ~/.drycc/$cur_controller.client.json
    fi
    command drycc "$@"
  elif [[ "$1" == "use" ]]; then
    if [[ -f ~/.drycc/client.json ]]; then
      cur_controller=$(cat ~/.drycc/client.json | jq -r '.controller | split("://") | .[1]')
      cp ~/.drycc/client.json ~/.drycc/$cur_controller.client.json
    fi
    target_controller=$2
    if [[ "$target_controller" == "current" ]]; then
      :
    elif [[ -f ~/.drycc/$target_controller.client.json ]]; then
      cp ~/.drycc/$target_controller.client.json ~/.drycc/client.json
    fi
  else
    command drycc "$@"
  fi
}
