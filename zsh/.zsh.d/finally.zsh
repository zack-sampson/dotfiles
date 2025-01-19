# file to be run after all other config files are run

# make sure user overrides come first on PATH

if [[ -d "${HOME}/bin" ]]; then
    PATH=$HOME/bin:$PATH
fi
