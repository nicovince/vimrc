#!/usr/bin/env bash
set -e
SCRIPT="$(basename "$0")"
VIM_FOLDER="$(dirname "$(realpath "$0" --relative-to "$(git rev-parse --show-toplevel)")")"
PACKAGES_FOLDER="${VIM_FOLDER}/pack"

function help()
{
    cat <<EOF
Manage vim plugins as submodules
Usage:
  ${SCRIPT} add <url>
  ${SCRIPT} rm <path>
  ${SCRIPT} list
  ${SCRIPT} update
EOF
}

function plugin_add()
{
    local url
    local name
    local plugin_folder

    url="$1"
    name="$(echo "${url%%.git}" | rev | cut -d '/' -f 1 | rev)"
    plugin_folder="${PACKAGES_FOLDER}/${name}/start/${name}"

    git submodule add "${url}" "${plugin_folder}"
    vim -u NONE -c "helptags ${plugin_folder}/doc" -c q
}

function plugin_rm()
{
    local plugin_path

    plugin_path="$1"
    git rm "${plugin_path}"
}

function plugin_list()
{
    git submodule status | awk '{print $2}' | sed -r 's#(pack/([^/]*).*)#\2\t\1#' | column -ts $'\t'
}

function plugin_update()
{
    git submodule foreach 'git pull'
    find pack -name "doc" -exec vim -u NONE -c "helptags {}" -c q \;
}

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help)
            help
            exit 0
            ;;
        add)
            ACTION="$1"
            URL="$2"
            shift
            ;;

        rm)
            ACTION="$1"
            PLUGIN_PATH="$2"
            shift
            ;;
        list)
            plugin_list
            exit 0
            ;;
        update)
            plugin_update
            exit 0
            ;;
        *)
            echo "unknown option $1"
            help
            exit 1
            ;;
    esac
    shift
done

if [ "${ACTION}" = "add" ]; then
    plugin_add "${URL}"
elif [ "${ACTION}" = "rm" ]; then
    plugin_rm "${PLUGIN_PATH}"
fi
