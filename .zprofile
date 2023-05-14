# 1Password SSH
export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"

# Homebrew shell env
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_CASK_OPTS=--require-sha
export HOMEBREW_NO_INSECURE_REDIRECT=1
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm shell env
eval "$(fnm env --use-on-cd)"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv > /dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
export PIPX_DEFAULT_PYTHON="$HOME/.pyenv/shims/python"

# cargo
source "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="${HOME}/Library/pnpm"

# disable telemetry
export NEXT_TELEMETRY_DISABLED=1   # Next.js
export CHECKPOINT_DISABLE=1        # Prisma
export DISABLE_TELEMETRY=YES       # diffusers

# go
export GOPROXY="direct"

# paths to add to PATH
typeset -U paths=(
    "$(yarn global bin)"
    "$HOME/.local/bin"
    "$HOME/.deno/bin"
    "$PNPM_HOME"
    "$(brew --prefix ccache)/libexec"
    "${HOME}/go/bin"
)

# turn PATH into a deduplicated array
typeset -U path

# iterate over paths to append
for p in "${paths[@]}"; do
    [[ -d "$p" ]] && \
        path=("$p" "$path[@]")
done
