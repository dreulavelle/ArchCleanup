# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
prompt_context() {}

# Fix Characters (for pasting)
if [[ $TERM = dumb ]]; then
  unset zle_bracketed_paste
fi

neofetch

# Plugins
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Print working directory in title
case $TERM in
  xterm*)
    precmd () {print -Pn "\e]0;%~\a"}
    ;;
esac

# My Personal Alias' 
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -GpF --color=auto'
alias ll='ls -l --color=auto'
alias all='ls -a --color=auto'
alias nano='mousepad'
alias pac='sudo pacman'
alias pacupdate='sudo pacman -Syyu'
alias kodi='thunar $user\.kodi'

# USE WITH CAUTION!!
alias delete='rm -rf'

# Useful for GPU Temps (Only for Nvidia)
alias gputemp="print $(nvidia-smi | grep "P8" | awk ' { print $3 } ')"
alias cputemp="print $(sensors coretemp-isa-0000 | grep Package | awk ' { print $4-1 } ')C"

# Highly recommended to add these
alias neoconfig="nano ~/.config/neofetch/config.conf"
alias zshconfig="nano ~/.zshrc"
alias bshconfig="nano ~/.bashrc"