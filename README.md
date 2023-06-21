# Download and install
```
git clone --recurse-submodules https://github.com/nicovince/vimrc.git $HOME/.vim
echo 'source $HOME/.vim/vimrc.vim' > $HOME/.vimrc
```

Configure email address for repositories cloned on companies workstations:
```
cd $HOME/.vim
git config --local user.email $(git log -1 5c4f4e3f61f6475ca1d05fc40a57fbfaed66fc5c --pretty=format:"%ae")
```

Install git hooks (`pre-commit` must be installed):
```
cd $HOME/.vim
pre-commit install --hook-type pre-commit --hook-type commit-msg
```

# Make documentation from plugins available
```
find pack -name "doc" -exec vim -u NONE -c "helptags {}" -c q \;
```

# Installing plugins
```
./vplug.sh <repository url>
```
This command will download the repository url as a git submodule and generate documentation for that plugin. Plugins are installed under `pack/<plugin>/start/<plugin>`

```help package```
