# Download and install
```
git clone --recurse-submodules https://github.com/nicovince/vimrc.git $HOME/.vim
echo 'source $HOME/.vim/vimrc.vim' > $HOME/.vimrc
```

Beware, this will overwrite your `~/.vimrc`

Configure email address for repositories cloned on companies workstations:
```
git config --local user.email $(git log -1 5c4f4e3f61f6475ca1d05fc40a57fbfaed66fc5c --pretty=format:"%ae")
```

GhostText plugins needs websocket
```
sudo apt-get install python3-websockets
```

# Make documentation from plugins available
```
find pack -name "doc" -exec vim -u NONE -c "helptags {}" -c q \;
```

# Installing plugins as packages
Create `pack/<plugin>/start` folder, and paste/download/clone the plugin to that directory. Vim's internal package manager will automatically add that folder to the runtimepath.

```help package```
