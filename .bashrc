#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
# >>> BEGIN ADDED BY CNCHI INSTALLER
BROWSER=/usr/bin/firefox
EDITOR=/usr/bin/nvim
# <<< END ADDED BY CNCHI INSTALLER

# ~~ Environment vars for editors & stuff ~~
# The GOPATH var is for using 'go get'
export GOPATH="$HOME/dev/gopath"

# ~~ Make some already useful tools better/easier to use ~~
# "Super cd" - it drops back to home, then uses fzf & dirname to cd anywhere very quickly
# It can be used on both files or directories
alias fcd='cd "$HOME" && _fzfdir=$(fzf) && if [[ -d "$_fzfdir" ]]; then cd "$_fzfdir"; else cd $(dirname "$_fzfdir"); fi'
# Only show issues, enable all check types, and suppress that stupid bug message about no includes path
alias cppcheck='cppcheck -q --enable=all --suppress=missingIncludeSystem'
# Make sure exiftool wipes all info on the target file
alias exiftool='exiftool -overwrite_original -all='

# One letter to launch editor
alias n='nvim'

# ~~ Shortcuts to bootstrap various project types ~~
# Drops my preferred .editorconfig into the current dir
alias geteconf='cp ~/dev/personal-configs/formatter-configs/.editorconfig ./ && echo "Put editorconfig in $(pwd)"'
# Gets the Unlicense license
alias getunlicense='cp ~/dev/personal-configs/licenses/unlicense/LICENSE ./ && echo "Put Unlicense in $(pwd)"'
# Gets the GPL3 license
alias getgpl3='cp ~/dev/personal-configs/licenses/gpl3/LICENSE ./ && echo "Put GPL3 in $(pwd)"'
# Gets my preferred uncrustify config
alias getuncrust='cp ~/dev/personal-configs/formatter-configs/uncrustify.cfg ./ && echo "Put Uncrustify config in $(pwd)"'
# A command to start a new git project which gets stuff that's (almost) always needed
alias gitinit='git init && geteconf && getgpl3'
# A quickstart for new C++ projects | Seperate uncrustify getter since I don't want to hold it in the project-templates/
alias newcpp='cp -r ~/dev/personal-configs/project-templates/cpp/. ./ && getuncrust && gitinit'
alias newaur='cp -r ~/dev/personal-configs/project-templates/aur/. ./ && geteconf'
# This runs cmake/make in 1 command
# It also creates the compile_commands.json needed by Cquery
alias cmakebuild='mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. && ln -sf compile_commands.json ../ && make -j$(nproc) && if [[ -d "$(pwd)/Testing" ]]; then make test; fi; cd ..'
