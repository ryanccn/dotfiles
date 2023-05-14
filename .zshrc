if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
FPATH="${HOME}/.zfunc:${FPATH}"
autoload -Uz compinit
compinit

source "$(brew --prefix antidote)/share/antidote/antidote.zsh"
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

export LANG=en_US.UTF-8
export EDITOR="hx"

alias vim="hx"
alias ls="exa"

alias ghrvw="gh repo view --web"
alias opr="op run --env-file=.env.1password --"

alias dequarantine="xattr -d com.apple.quarantine"

alias pip-upgrade-all="pip --disable-pip-version-check list --outdated --format=json | python -c \"import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))\" | xargs -n1 pip install -U"

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# iTerm
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
