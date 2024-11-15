export RSTUDIO_WHICH_R=/opt/homebrew/bin/R
export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_ENV_HINTS="1"
# fpath+=$ZSH/zsh-completions.git/src
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi
# fpath+=~/.conda/conda-zsh-completion
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
### PATH - DONT COPY MY PATH - COPY YOUR OWN
# export PATH=$HOME/bin:/usr/local/bin:/snap/bin:/opt/bin:$PATH

### ZSH HOME
export ZSH=$HOME/.zsh_plugins

### ---- history config -------------------------------------
export HISTFILE=$ZSH/.zsh_history

# How many commands zsh will load to memory.
export HISTSIZE=20000

# How many commands history will save on file.
export SAVEHIST=20000

alias mitmproxy="mitmproxy --set console_mouse=false"
# alias srcfumount="umount ~/srcf/public; umount ~/srcf/private"
# alias srcfmount="srcfumount; sshfs -o allow_other,default_permissions td471@shell.srcf.net:/public/home/td471 ~/srcf/public; sshfs -o allow_other,default_permissions td471@shell.srcf.net:/home/td471 ~/srcf/private;"
# # If you come from bash you might have to change your $PATH.
# # export PATH=$HOME/bin:/usr/local/bin:$PATH
# zstyle ":completion:*:commands" rehash 1
# # Path to your oh-my-zsh installation.
# export ZSH="/Users/idkwhotomis/.oh-my-zsh"
PROMPT_EOL_MARK=''
alias sudo="nocorrect sudo -E"
#
# #hyper - m : open -aFirefox "https://www.vle.cam.ac.uk/login/index.php"
#
# # Set name of the theme to load --- if set to "random", it will
# # load a random theme each time oh-my-zsh is loaded, in which case,
# # to know which specific one was loaded, run: echo $RANDOM_THEME
# # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# For some terminals, this may be the correct escape sequence for Ctrl + Left/Right
bindkey '^[[1;5D' backward-word  # Ctrl + Left
bindkey '^[[1;5C' forward-word   # Ctrl + Right

# # Checks if working tree is dirty
# parse_git_dirty() {
#   local STATUS=''
#   local FLAGS
#   FLAGS=('--porcelain')
#   if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
#     if [[ $POST_1_7_2_GIT -gt 0 ]]; then
#       FLAGS+='--ignore-submodules=dirty'
#     fi
#     if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
#       FLAGS+='--untracked-files=no'
#     fi
#     STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
#   fi
#   if [[ -n $STATUS ]]; then
#     echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
#   else
#     echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
#   fi
# }
# # get the name of the branch we are on
# function git_prompt_info() {
#   if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
#     ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
#     ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
#     echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
#   fi
# }
# ZSH Theme - Preview: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes#gallifrey
autoload -U colors && colors
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
host_color="%(!.%{$fg[red]%}.%{$fg[green]%})"
setopt prompt_subst

source $ZSH/git.zsh

PROMPT='${host_color}%m%{$reset_color%} %2~ $(git_prompt_info2)%{$reset_color%}%B»%b '
RPROMPT='$GITSTATUS_PROMPT'
RPS1="${return_code}"
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
# Disable syntax highlighting temporarily
# zle -N self-insert
# Prevent Zsh from interpreting pasted content as special commands
zle_highlight=('paste:none')
# Update the prompt on directory change
# autoload -U add-zsh-hook
# add-zsh-hook chpwd update_prompt
#
# # Function to update the prompt
# update_prompt() {
#   # Force prompt to be recalculated
#   PROMPT=$PROMPT
# }
# unset return_code host_color


# source $ZSH/fast-syntax-highlighting/F-Sy-H.plugin.zsh
source $ZSH/conda.plugin.zsh/conda.plugin.zsh
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH_THEME="gallifrey"
export DYLD_FALLBACK_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_FALLBACK_LIBRARY_PATH"
eval $(thefuck --alias frick)
# # Set list of themes to pick from when loading at random
# # Setting this variable when ZSH_THEME=random will cause zsh to load
# # a theme from this variable instead of looking in $ZSH/themes/
# # If set to an empty array, this variable will have no effect.
# # ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
#
# # Uncomment the following line to use case-sensitive completion.
# # CASE_SENSITIVE="true"
# # Uncomment the following line to use hyphen-insensitive completion.
# # Case-sensitive completion must be off. _ and - will be interchangeable.
# # HYPHEN_INSENSITIVE="true"
#
# # Uncomment the following line to disable bi-weekly auto-update checks.
# # DISABLE_AUTO_UPDATE="true"
#
# # Uncomment the following line to automatically update without prompting.
# # DISABLE_UPDATE_PROMPT="true"
#
# # Uncomment the following line to change how often to auto-update (in days).
# # export UPDATE_ZSH_DAYS=13
#
# # Uncomment the following line if pasting URLs and other text is messed up.
# # DISABLE_MAGIC_FUNCTIONS="true"
#
# # Uncomment the following line to disable colors in ls.
# # DISABLE_LS_COLORS="true"
#
# # Uncomment the following line to disable auto-setting terminal title.
# # DISABLE_AUTO_TITLE="true"
#
# # Uncomment the following line to enable command auto-correction.
# # ENABLE_CORRECTION="true"
#
# # Uncomment the following line to display red dots whilst waiting for completion.
# # Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# # See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# # COMPLETION_WAITING_DOTS="true"
#
# # Uncomment the following line if you want to disable marking untracked files
# # under VCS as dirty. This makes repository status check for large repositories
# # much, much faster.
# # DISABLE_UNTRACKED_FILES_DIRTY="true"
#
# # Uncomment the following line if you want to change the command execution time
# # stamp shown in the history command output.
# # You can set one of the optional three formats:
# # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# # or set a custom format using the strftime function format specifications,
# # see 'man strftime' for details.
# # HIST_STAMPS="mm/dd/yyyy"
#
# # Would you like to use another custom folder than $ZSH/custom?
# # ZSH_CUSTOM=/path/to/new-custom-folder
#
# # Which plugins would you like to load?
# # Standard plugins can be found in $ZSH/plugins/
# # Custom plugins may be added to $ZSH_CUSTOM/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(git zsh-syntax-highlighting extract)
#
# source $ZSH/oh-my-zsh.sh
#
# pasteinit() {
#   OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
#   zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
# }
#
# pastefinish() {
#   zle -N self-insert $OLD_SELF_INSERT
# }
#
# #   Update all Wallpapers
# function wallpaper() {
#     sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$1'" && killall Dock 
# }
#
autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors '=(#i)'.'*'${(s.:.)LS_COLORS}
zstyle ':completion:*' special-dirs false
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
# # if [[ $ITERM_PROFILE != "dropdown" ]]; then alias clear="clear;pfetch"; pfetch; fi
alias clear="clear;snoopyfetch"
snoopyfetch
# # User configuration
alias ls="ls -Ga --color=auto"
alias vim="nvim"
setopt globdots
export PATH=$PATH:$(go env GOPATH)/bin
#
# # export MANPATH="/usr/local/man:$MANPATH"
#
# # You may need to manually set your language environment
# # export LANG=en_US.UTF-8
#
# # Preferred editor for local and remote sessions
# # if [[ -n $SSH_CONNECTION ]]; then
# #   export EDITOR='vim'
# # else
# #   export EDITOR='mvim'
# # fi
#
# # Compilation flags
# # export ARCHFLAGS="-arch x86_64"
# alias pullnotes="ls -d ~/notes/*/ | xargs -I{} git -C {} pull"
# # Set personal aliases, overriding those provided by oh-my-zsh libs,
# # plugins, and themes. Aliases can be placed here, though oh-my-zsh
# # users are encouraged to define aliases within the ZSH_CUSTOM folder.
# # For a full list of active aliases, run `alias`.
# #
# # Example aliases
# # alias zshconfig="mate ~/.zshrc"
# # alias ohmyzsh="mate ~/.oh-my-zsh"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#
## Put this in your .zshrc or in a file sourced by it
function init_conda() {
    __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if ! (( ${+CONDA_DEFAULT_ENV} )); then
        # if [ $? -eq 0 ]; then
        #     eval "$__conda_setup"
        # else
        if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/anaconda3/bin:$PATH"
        fi
        # fi
        conda activate py312
    else
        oldenv="$CONDA_DEFAULT_ENV"
        # if [ $? -eq 0 ]; then
        #     eval "$__conda_setup"
        # else
        if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/opt/homebrew/anaconda3/bin:$PATH"
        fi
        # fi
        conda activate $oldenv
    fi
    unset __conda_setup
}

# Call the function asynchronously, immediately after prompt loads
# init_conda &
# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if ! (( ${+CONDA_DEFAULT_ENV} )); then
#     # if [ $? -eq 0 ]; then
#     #     eval "$__conda_setup"
#     # else
#     if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#     fi
#     # fi
#     conda activate py312
# else
#     oldenv="$CONDA_DEFAULT_ENV"
#     # if [ $? -eq 0 ]; then
#     #     eval "$__conda_setup"
#     # else
#     if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/homebrew/anaconda3/bin:$PATH"
#     fi
#     # fi
#     conda activate $oldenv
# fi
# unset __conda_setup
# # <<< conda initialize <<<
#
# # Created by `pipx` on 2024-07-25 18:18:05
export PATH="$PATH:/Users/idkwhotomis/.local/bin"
#
precmd() {
    rehash
}
#
# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/opt/homebrew/opt/micromamba/bin/micromamba';
export MAMBA_ROOT_PREFIX='/Users/idkwhotomis/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
micromamba activate base
alias mamba=micromamba
# <<< mamba initialize <<<
