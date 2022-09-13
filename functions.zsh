function ml() { mkdir -p "$(dirname "$1")" && rsync -aP --no-links "$1" "$2" && ln -sf "$2" "$1" }

function listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

function gitpruneremote() {
    if [ $# -eq 1 ]; then
	REMOTE=$1
	git branch -r | grep ${REMOTE}/ | grep -Ev 'master$|integration$' | sed "s|^  ${REMOTE}/|:|" | xargs git push --no-verify ${REMOTE}
    else
        echo "Usage: pruneremote [remote]"
    fi
}

function gittidy() {
    git branch | grep -Ev "master|integration|develop|interim" | xargs git branch -D
}
