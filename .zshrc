# p10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# autocompletions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
FPATH="${HOME}/.zfunc:${FPATH}"
autoload -Uz compinit
compinit

# antidote
source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# environment variables
export LS_COLORS="$(vivid generate catppuccin-macchiato)"
export LANG=en_US.UTF-8
export EDITOR="hx"

# aliases
alias vim="hx"
alias ls="exa"

alias glol="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias ghrvw="gh repo view --web"

alias opr="op run --env-file=.env.1password --"

alias dequarantine="xattr -d com.apple.quarantine"

alias pip-upgrade-all="pip --disable-pip-version-check list --outdated --format=json | python -c \"import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))\" | xargs -n1 pip install -U"

# starship
eval "$(starship init zsh)"

# p10k
# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# zoxide
eval "$(zoxide init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# direnv
command -v direnv &> /dev/null && eval "$(direnv hook zsh)"

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
