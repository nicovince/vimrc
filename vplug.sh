#!/usr/bin/env bash
set -e
VIM_FOLDER="$(dirname "$(realpath "$0" --relative-to "$(git rev-parse --show-toplevel)")")"
PACKAGES_FOLDER="${VIM_FOLDER}/pack"

function help()
{
    cat <<EOF
Manage vim plugins as submodules
Usage:
  plugins.sh add <url>

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
