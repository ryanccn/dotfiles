# completion paths
if command -v brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi
FPATH="$HOME/.zfunc:$FPATH"

# environment variables
export LANG=en_US.UTF-8

export EDITOR="hx"
export PAGER="less"
export LESS="-R"

export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=100
export SAVEHIST=1000

export FZF_DEFAULT_OPTS=" \
--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 \
--color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf \
--color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"

# zsh options
setopt interactivecomments
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt complete_in_word
setopt always_to_end

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# compile completions
comp_cache_path="$HOME/.cache/zsh"
zcompdump_path="$comp_cache_path/zcompdump"

autoload -Uz compinit
compinit -d "$zcompdump_path"
if [[ ! "${zcompdump_path}.zwc" -nt "$zcompdump_path" ]]
then
	zcompile "$zcompdump_path"
fi

[ -f "$HOME/.config/tabtab/zsh/__tabtab.zsh" ] && . "$HOME/.config/tabtab/zsh/__tabtab.zsh" || true

# vivid
vivid_theme="catppuccin-macchiato"

# antidote
source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load "${ZDOTDIR:-$HOME}/.zsh_plugins.txt"

# configure completion styles
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':completion:*' group-name ''

zstyle ':completion:*' use-cache 'true'
zstyle ':completion:*' cache-path "$comp_cache_path"

unset comp_cache_path zcompdump_path

# aliases
alias vim="hx"
alias ls="exa --all --icons"
alias dig="doggo"

alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias ghrvw="gh repo view --web"

alias opr="op run --env-file=.env.1password --"
alias dr="doppler run --"

alias dequarantine="xattr -d com.apple.quarantine"

alias bcpa="brew cleanup --prune=all"
alias puil="pnpm update --interactive --latest"
alias pip-upgrade-all="pip --disable-pip-version-check list --outdated --format=json | python -c \"import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))\" | xargs -n1 pip install -U"

function take() {
  mkdir "$1"
  cd "$1" || return 1
}

function clean_vscode_workspace_storage() {
  for i in "$HOME/Library/Application Support/Code/User/workspaceStorage/"*; do
    if [ -f $i/workspace.json ]; then 
      older="$(python3 -c "import sys, json; print(json.load(open(sys.argv[1], 'r'))['folder'])" $i/workspace.json 2>/dev/null | sed 's#^file://##;s/+/ /g;s/%\(..\)/\\x\1/g;')";
      if [ -n "$folder" ] && [ ! -d "$folder" ]; then
        echo "Removing workspace $(basename $i) for deleted folder $folder of size $(du -sh $i|cut -f1)"; rm -rfv "$i";
      fi
    fi
  done
}

# starship
eval "$(starship init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zoxide
eval "$(zoxide init zsh)"

# direnv
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

# iTerm
[ -e "$HOME/.iterm2_shell_integration.zsh" ] && source "$HOME/.iterm2_shell_integration.zsh"
