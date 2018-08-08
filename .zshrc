# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH

## Daily Fortune
#/home/chris/.scripts/urxvt_fortune

## Fancy Neofetch above prompt gag
#neofetch --ascii /home/chris/.scripts/ascii_elephant_ascii_co_up_beate_schwichtenberg

## RVM Implementation
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# Path to your oh-my-zsh installation.
export ZSH=/usr/share/oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

ZSH_THEME="bullet-train"
#XDG_CONFIG_HOME="$HOME/.config"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
#source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Dynamic Colors (https://github.com/sos4nt/dynamic-colors)
#export PATH="$HOME/.dynamic-colors/bin:$PATH"

# Edit and or View zsh stuffs
alias zshrc='vim /home/chris/.zshrc'
alias zshhistory='vim /home/chris/.zsh_history'

# Boring stuffs
alias cls='clear'
alias w3md="w3m www.duckduckgo.com"
alias w3mc="w3m /home/chris/.zZz/Coded/Testing/HTML/csmertx.github.io_1.0/index_noscripts.html"
alias ytc='mpsyt'
alias tmp='sudo ranger /tmp/trizen-chris'
alias var='sudo ranger /var/cache/pacman/pkg'
alias cored='sudo ranger /var/lib/systemd/coredump/'
alias pac='sudo pacman'
alias pacc='sudo /usr/lib/i3blocks/pac'
alias pacu='/home/chris/.scripts/pacman_update'
alias pacu2='/home/chris/.scripts/pacman_update2'
alias pace='echo "y" | pacman -Syu > stuff2do4pacman.txt'
alias pacl='vim /home/chris/.scripts/pacman.log'
alias pacl2='vim /home/chris/.scripts/pacman2.log'
alias swapcat='/home/chris/.scripts/catswap'
alias swapcls='sudo swapoff -a && sudo swapon -a'
alias ff='ffmpeg -i'
alias you='youtube-dl'
alias qq='exit'
alias ping1='ping -c 4 209.132.183.105'
alias ping2='ping -c 4 8.8.8.8'
alias dns1='nslookup www.redhat.com'
alias dns2='nslookup www.google.com'
alias trace1='traceroute -A 209.132.183.105'
alias trace2='traceroute -A 8.8.8.8'
alias trace3='traceroute -A'
alias whatip='/home/chris/.scripts/whatisip.sh'
alias rnet='/home/chris/.scripts/restart.sh'
alias rnet2='/home/chris/.scripts/restart2.sh'
alias wifinc='sudo /home/chris/.scripts/i3/wifi_name_change'
alias vpn='/home/chris/.scripts/vpn_switch.sh'
alias vpnc='/home/chris/.scripts/vpn_switch_CLI'
alias py='python'
alias zen='neofetch --ascii /home/chris/.scripts/ascii_elephant_ascii_co_up_beate_schwichtenberg'
alias daily='/home/chris/.gem/ruby/2.5.0/gems/tmuxinator-0.10.1/bin/tmuxinator daily'
alias email='/home/chris/.scripts/email'
alias xresources='xrdb ~/.Xresources'
alias router='telnet 192.168.0.1 && rnet'
alias callog='vim /home/chris/.calcurse/apts'
alias vimrc='vim /home/chris/.vimrc'
alias nwsv='sudov /usr/lib/i3blocks/nws_weather_updated'
alias nwsa='/home/chris/.scripts/print_nwsalert'
alias nwsq='cat /home/chris/.scripts/nws_quality.txt'
alias cpu_bench='/home/chris/.scripts/cpu_bench'
alias flv2mp4='/home/chris/.scripts/flv_to_mp4'
alias mkv2mp4='/home/chris/.scripts/mkv_to_mp4'
alias nextcloudu='sudo /home/chris/.scripts/nextcloudu'
alias up2nc='/home/chris/.scripts/daily_archive'
alias dotb='/home/chris/.scripts/dotfiles'
alias divisible='/home/chris/.scripts/divisible_1_to_40'
alias zathurah='vim /home/chris/.local/share/zathura/input-history'
alias kcallog='/home/chris/.scripts/calorie_day_log'
alias calories='cat /home/chris/.scripts/SkateWeight/calorie_index.txt | grep'
alias caloriese='echo -en "Match? => "; read MATCH; vim -c "+/$MATCH" $(grep -l $MATCH /home/chris/.scripts/SkateWeight/calorie_index.txt)'

alias //='locate'
alias updatedb='sudo updatedb'

# Hop to dirs with Ranger
alias ra='ranger'
alias rc='ranger /home/chris/.config'
alias rms='ranger /mnt/Storage/'
alias rmsa='ranger /mnt/Storage/Documents/configs/archives'
alias rmsm='ranger /mnt/Storage/Music'
alias rmsmp='ranger /mnt/Storage/Music/Podcasts'
alias rmsv='ranger /mnt/Storage/Videos'
alias rmsd='ranger /mnt/Storage/Documents'
alias rd='ranger /home/chris/Downloads'
alias rg='ranger /home/chris/Games'
alias rgd='ranger /home/chris/Games/Emulation/DOS'
alias rs='ranger /home/chris/.scripts/'
alias rt='ranger /home/chris/tmp/'
alias rtm='ranger /home/chris/tmp/mans'
alias rp='ranger /home/chris/Pictures/'
alias rz='ranger /home/chris/.zZz/'
alias rma='ranger /Mi3/'
alias rmc='ranger /run/media/chris/'

# Sudo the things
alias sudor='sudo ranger'
alias sudov='sudo vim'
alias sudoc='sudo chmod +x'

# Other Boring Stuffs
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'
alias klemonbar='killall lemonbar'

# Custom Scripts
alias nwsq='cat /home/chris/.scripts/i3/nws_quality.txt'
alias id3tags='/home/chris/.scripts/id3tags'
alias pmp3='/home/chris/.scripts/pmp3'
alias mmp3='/home/chris/.scripts/mmp3'
alias dcache='rm -rf /home/chris/.cache/qutebrowser/webengine/Cache/'
alias slackusb='sudo ~/.scripts/iso2usb.sh'
alias mntiso='sudo ~/.scripts/mntiso'
alias tvguide='/home/chris/.scripts/tvguide/tvguide'
alias tvguide_list='sudo /home/chris/.scripts/tvguide/tvguide_list'
alias speedtest='/home/chris/.scripts/speedtest'
alias vlclog='vim /home/chris/vlc_history.txt'
alias podlog='vim /home/chris/pod_history.txt'
alias mp4togif='/home/chris/.scripts/mp4togif'
alias news='/home/chris/.scripts/news'
alias ytrss='newsbeuter'
alias fer='/home/chris/.scripts/file_ext_rename'
alias html2pdf='/home/chris/.scripts/html2pdf'
alias coinflip='/home/chris/.scripts/CoinFlip'
alias line_total='/home/chris/.scripts/line_total'

# variable for redirecting man files
rtm="/home/chris/tmp/mans"

# variable for github clone dir
rt="/home/chris/tmp"

# Virtualbox VMs
alias debian="VBoxManage startvm Debian"
alias netbsd="VBoxManage startvm NetBSD"
alias freebsd="VBoxManage startvm FreeBSD"

# DOSBox
alias dos='dosbox -c "mount c /home/chris/Games/Emulation/DOS C:"'

# Paths
export PAGER='vim'
export VISUAL='vim'
export EDITOR='vim'
export PROMPT_COMMAND='history -a'
export PATH="$HOME/.cargo/bin:$PATH"

# bspwm nitpicks
XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME

# MPD
MPD_HOST="/home/chris/.config/mpd/mpd.socket"

# Fix the things in style
if [[ $(tty) = /dev/tty2 ]] ; then
    fbterm
fi
