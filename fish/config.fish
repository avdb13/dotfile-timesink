if status is-interactive
end

set PATH $HOME/.cargo/bin $PATH

# pnpm
set -gx PNPM_HOME "/home/mikoto/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
