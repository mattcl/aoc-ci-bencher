_hyperfine() {
    local i cur prev opts cmds
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    cmd=""
    opts=""

    for i in ${COMP_WORDS[@]}
    do
        case "${i}" in
            hyperfine)
                cmd="hyperfine"
                ;;
            
            *)
                ;;
        esac
    done

    case "${cmd}" in
        hyperfine)
            opts=" -i -h -V -w -m -M -r -p -c -P -D -L -s -S -u -n  --ignore-failure --show-output --help --version --warmup --min-runs --max-runs --runs --prepare --cleanup --parameter-scan --parameter-step-size --parameter-list --style --shell --time-unit --export-asciidoc --export-csv --export-json --export-markdown --command-name  <command>... "
            if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]] ; then
                COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
                return 0
            fi
            case "${prev}" in
                
                --warmup)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -w)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --min-runs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -m)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --max-runs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -M)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --runs)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -r)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --prepare)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -p)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --cleanup)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -c)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --parameter-scan)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -P)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --parameter-step-size)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -D)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --parameter-list)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -L)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --style)
                    COMPREPLY=($(compgen -W "auto basic full nocolor color none" -- "${cur}"))
                    return 0
                    ;;
                    -s)
                    COMPREPLY=($(compgen -W "auto basic full nocolor color none" -- "${cur}"))
                    return 0
                    ;;
                --shell)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -S)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --time-unit)
                    COMPREPLY=($(compgen -W "millisecond second" -- "${cur}"))
                    return 0
                    ;;
                    -u)
                    COMPREPLY=($(compgen -W "millisecond second" -- "${cur}"))
                    return 0
                    ;;
                --export-asciidoc)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --export-csv)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --export-json)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --export-markdown)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                --command-name)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                    -n)
                    COMPREPLY=($(compgen -f "${cur}"))
                    return 0
                    ;;
                *)
                    COMPREPLY=()
                    ;;
            esac
            COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
            return 0
            ;;
        
    esac
}

complete -F _hyperfine -o bashdefault -o default hyperfine
