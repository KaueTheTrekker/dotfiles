define-command dmenu-files -docstring 'Open one or many files' %{ evaluate-commands %sh{
    FILES=$(rg --hidden --files | dmenu)
    for file in $FILES; do
        printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$file" | kak -p "$kak_session"
    done
} }

define-command dmenu-files-in-folder -docstring 'Open one or many files in a recent folder' %{ evaluate-commands %sh{
    FOLDER=$(cat "$HOME/.z" | sed 's/|/\t/g' | sort -rnk2 | awk '{print $1}' | sed "s|$HOME|~|g" | dmenu | sed "s|~|$HOME|g")
    if [ -n "$FOLDER" ]; then
        FILES=$(rg --hidden --files "$FOLDER" | sed "s|$FOLDER/||g" | dmenu)
        for file in $FILES; do
            printf 'eval -client %%{%s} edit %%{%s}\n' "$kak_client" "$FOLDER/$file" | kak -p "$kak_session"
        done
    fi
} }

define-command dmenu-buffers -docstring 'Switch to a buffer' %{ evaluate-commands %sh{
    BUFFER=$(eval set -- "$kak_buflist"; for buf in "$@"; do echo "$buf"; done | dmenu)
    [ -n "$BUFFER" ] && echo "eval -client '$kak_client' 'buffer $BUFFER'" | kak -p "$kak_session"
} }
