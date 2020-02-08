# Download and install
```
git clone --recurse-submodules https://github.com/nicovince/vimrc.git $HOME/.vim
echo 'source $HOME/.vim/vimrc.vim' > $HOME/.vimrc
```

Beware, this will overwrite your `~/.vimrc`

# Make documentation from plugins available
```
find pack -name "doc" -exec vim -u NONE -c "helptags {}" -c q \;
```

# Installing plugins as packages
Create `pack/<plugin>/start` folder, and paste/download/clone the plugin to that directory. Vim's internal package manager will automatically add that folder to the runtimepath.

```help package```
