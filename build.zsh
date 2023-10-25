#!/bin/bash

scriptname="setup.zsh"

if [ -f "$scriptname" ]; then
    rm -f "$scriptname"
fi

{
    echo "#!/bin/zsh"
    echo '
####################################################################################################
#                    WARNING: THIS FILE IS AUTOMATICALLY GENERATED BY A SCRIPT.                    #
#                           ANY MANUAL MODIFICATIONS MAY BE OVERWRITTEN                            #
####################################################################################################
'
    cat scripts/start.zsh
    for file in functions/*.zsh; do
        # Voeg elk bestand toe aan setup.zsh
        cat "$file"
    done
    cat scripts/main.zsh
} >"$scriptname"