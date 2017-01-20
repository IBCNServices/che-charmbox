
function show_juju_env {
  local currentEnv
  currentEnv=`~/.juju_context.py`
  printf "%s" "$currentEnv"
}

export PS1="[\[\e[38;5;70m\]\$(show_juju_env)\[\e[0m\]] ${PS1}";
