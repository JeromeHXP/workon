# Declare a workon command
eval "workon() { source ~/.workon/workon.sh $1; }"
# Configure autocomplete for workon
_virtualenv_list() { 
            COMPREPLY=(
                $(compgen -W "`cat ~/.workon/workonrc | cut -d'=' -f1 | grep -v '^$'`" -- "${COMP_WORDS[COMP_CWORD]}")
            ); 
    }
complete -F _virtualenv_list workon