# 1Password SSH
export SSH_AUTH_SOCK="${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# Homebrew shell env
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_NO_INSECURE_REDIRECT=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm shell env
eval "$(fnm env --use-on-cd)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/shims/python"

# yarn
export PATH="$(yarn global bin):$PATH"

# cargo
source "$HOME/.cargo/env"

# local
export PATH="${HOME}/.local/bin:$PATH"

# deno
export PATH="${HOME}/.deno/bin:$PATH"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ccache
export PATH="$(brew --prefix ccache)/libexec:$PATH"

# disable telemetry
export NEXT_TELEMETRY_DISABLED=1   # Next.js
export CHECKPOINT_DISABLE=1        # Prisma
export DISABLE_TELEMETRY=YES       # diffusers

# go
export PATH="${HOME}/go/bin:$PATH"
export GOPROXY="direct"

# zoxide
eval "$(zoxide init zsh)"
