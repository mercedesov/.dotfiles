### =========================================================
### Core behavior
### =========================================================

bindkey -e

unsetopt correct
unsetopt correctall
setopt no_beep
setopt auto_cd
setopt hist_ignore_dups
setopt inc_append_history
setopt extended_history
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt pushd_silent
setopt pushd_to_home
setopt transient_rprompt
setopt notify

HISTFILE=~/.zsh_history
HISTSIZE=20000
SAVEHIST=20000

typeset -U path
DIRSTACKSIZE=60
WORDCHARS="${WORDCHARS:s#/#}"

### =========================================================
### Key bindings (terminfo-safe)
### =========================================================

typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Insert]}" ]] && bindkey "${key[Insert]}" overwrite-mode
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-history
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-history
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

if [[ -n ${terminfo[smkx]} && -n ${terminfo[rmkx]} ]]; then
  zle-line-init()   { echoti smkx }
  zle-line-finish() { echoti rmkx }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

### =========================================================
### Colors — Tokyo Night (pure zsh)
### =========================================================

autoload -U colors
colors

TOKYO_BG='#1a1b26'
TOKYO_FG='#c0caf5'
TOKYO_BLUE='#7aa2f7'
TOKYO_CYAN='#7dcfff'
TOKYO_GREEN='#9ece6a'
TOKYO_YELLOW='#e0af68'
TOKYO_RED='#f7768e'
TOKYO_PURPLE='#bb9af7'


PROMPT='%F{#7aa2f7}%n@%m%f %F{#c0caf5}%~%f '


### =========================================================
### Aliases
### =========================================================

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias rm='rm'

alias ls='ls --color=auto'
alias ll='ls --color -l'
alias la='ls --color -la'
alias lt='ls --sort=time'
alias lat='ls --color -la --sort=time'
alias grep='grep --color=auto'
alias zsh='nvim ~/.zshrc'
alias hypr='nvim ~/.config/hypr/hyprland.conf'
alias source='source ~/.zshrc'
alias v='nvim'
alias ff='NO_COLOR=1 fastfetch'
alias batt='cat /sys/class/power_supply/macsmc-battery/capacity'
alias rh='fc -R'
alias bt='bluetoothctl show | grep -q "Powered: yes" && bluetoothctl power off || bluetoothctl power on'
alias airpods='timeout 3 bluetoothctl info 74:65:0C:1A:92:2F | grep -q "Connected: yes" && bluetoothctl disconnect 74:65:0C:1A:92:2F || bluetoothctl connect 74:65:0C:1A:92:2F'



kb() {
  local v="$1"
  [[ "$v" =~ '^[0-9]+$' ]] || return 1
  (( v < 0 )) && v=0
  (( v > 255 )) && v=255
  echo "$v" | sudo tee /sys/class/leds/kbd_backlight/brightness >/dev/null
}

sleepnow() {
  busctl call org.freedesktop.login1 \
    /org/freedesktop/login1 \
    org.freedesktop.login1.Manager \
    Suspend b true
}

autoload run-help

### =========================================================
### Completion
### =========================================================

autoload -Uz compinit
[[ -d ~/.zcompdumps ]] || mkdir -m 0700 ~/.zcompdumps
compinit -i -d ~/.zcompdumps/${HOST%%.*}-$ZSH_VERSION

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle ':completion:*:descriptions' format '- %d -'
zstyle ':completion:*:corrections' format '- %d - (errors %e)'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

### =========================================================
### Functions
### =========================================================

stfu() {
  "$@" &>/dev/null </dev/null
}

fpath=(~/.zsh/functions $fpath)
autoload -U ~/.zsh/functions/*(:t)

[[ -e ~/.shfuncs ]] && source ~/.shfuncs
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
