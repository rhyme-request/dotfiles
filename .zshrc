#------------------------------
# General Settings
# ------------------------------
## Environment variable configuration
##
## LANG
## http://curiousabt.blog27.fc2.com/blog-entry-65.html
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8

## コマンド入力補完
if [ -f ~/.zsh/auto-fu.zsh ]; then
    source ~/.zsh/auto-fu.zsh
    function zle-line-init () {
        auto-fu-init
    }
    zle -N zle-line-init
    zstyle ':completion:*' completer _oldlist _complete
fi

## Control keyとかきいてほしい
bindkey -e

## ssh とかの補完
autoload -U compinit
compinit -u

## cd後自動でlsする
#function chpwd() { ls --color=auto }

## ctags
alias ctags='/usr/local/bin/ctags'

## エディタ(emacs)
#export EDITOR=/usr/bin/vim
TERM=xterm-color; export TERM

## diff
## colordiff: http://www.glidenote.com/archives/1403
alias difc='colordiff -w'
alias dify='diff -y --suppress-common-lines'

## less
## colordiffの結果をパイプでlessとかに渡すとおかしなことになるので、
## -Rを付けるとちゃんとカラー表示される。
export LESS="=R"

## tmux
alias tm='tmux -2'
alias tml='tmux ls'
alias tmk='tmux kill-session -t'
alias tma='tmux attach -t'
alias tmux="TERM=screen-256color-bce tmux"

## mysql(出力エディタはcat)
alias mysql='mysql --pager='cat''

## command edit
alias la='ls -la'

## コマンド履歴
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data


# ------------------------------
# gitブランチとステータスの表示
# ------------------------------
## http://d.hatena.ne.jp/mollifier/20090814/p1
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b)[%a]'

precmd () {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

# ------------------------------
# Look And Feel Settings
# ------------------------------
# Terminal Colorの設定
export LSCOLORS=ExFxCxDxBxegedabagacad

# 補完時の色の設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ZLS_COLORSとは？
export ZLS_COLORS=$LS_COLORS

# lsコマンド時、自動で色がつく(ls -Gのようなもの？)
export CLICOLOR=true

# 補完候補に色を付ける
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

### Prompt ###
### Prompt ###
# プロンプトに色を付ける
# http://www.sakito.com/2011/11/zsh.html
autoload -U colors; colors

# 一般ユーザ時
tmp_prompt="%{${fg[cyan]}%}%n%# %{${reset_color}%}"
tmp_prompt2="%{${fg[cyan]}%}%_> %{${reset_color}%}"
tmp_rprompt="%1(v|%F{magenta}%1v%f|)%{${fg[green]}%}[%(5~,%-2~/.../%2~,%~)]%{${reset_color}%}"
tmp_sprompt="%{${fg[yellow]}%}%r is correct? [Yes, No, Abort, Edit]:%{${reset_color}%}"

# rootユーザ時(太字にし、アンダーバーをつける)
if [ ${UID} -eq 0 ]; then
  tmp_prompt="%B%U${tmp_prompt}%u%b"
  tmp_prompt2="%B%U${tmp_prompt2}%u%b"
  tmp_rprompt="%B%U${tmp_rprompt}%u%b"
  tmp_sprompt="%B%U${tmp_sprompt}%u%b"
fi

PROMPT=$tmp_prompt    # 通常のプロンプト
PROMPT2=$tmp_prompt2  # セカンダリのプロンプト(コマンドが2行以上の時に表示される)
RPROMPT=$tmp_rprompt  # 右側のプロンプト
SPROMPT=$tmp_sprompt  # スペル訂正用プロンプト

PATH=/usr/local/bin:/usr/local/share:$PATH
PATH=/usr/local/texlive/2009/bin/universal-darwin:$PATH
PATH=/usr/local/texlive/p2009/bin/i386-apple-darwin10.3.0:$PATH
PATH=/usr/local/bibunsho/bin/i386-darwin:$PATH
export PATH

# ------------------------------
# Programing Setting
# ------------------------------
### Ruby ###

# rbenv
#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"

#gnuplot用のDISPLAY設定
#export DISPLAY=":0"
#open /Applications/Utilities/XQuartz.app
#export DISPLAY=":0"

#アクティブ取られるのがめんどいのでエイリアスで対応
alias x11='open /Applications/Utilities/XQuartz.app'

#glsコマンド(GNUっぽいlsコマンドの導入と色付け）
#alias ls='gls --hide="*.pyc" --color=auto -B'

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### for PostgreSQLの環境変数
export PGDATA=/usr/local/var/postgres

###iTerm2タブ
tab-color() {
    echo -ne "\033]6;1;bg;red;brightness;$1\a"
    echo -ne "\033]6;1;bg;green;brightness;$2\a"
    echo -ne "\033]6;1;bg;blue;brightness;$3\a"
}

tab-reset() {
    echo -ne "\033]6;1;bg;*;default\a"
}

#tab title
#function chpwd() { ls; echo -ne "\033]0;$(pwd | rev | awk -F \/ '{print "/"$1"/"$2}'| rev)\007"}
#tab color
#alias top='tab-color 134 200 0; top; tab-reset'
#chpwd

###Rails server/console
#alias railss="tab-color 255 0 0; bundle exec rails server;echo -ne '\033]0;rails server\007'"
#alias railsc="tab-color 255 0 255; bundle exec rails console;echo -ne '\033]0;rails console\007'"

##rake routes
#alias routesc="tab-color 102 255 255; bundle exec rake routes;echo -ne '\033]0;routes\007'"

##mysql
#alias mysqlc="tab-color 0 0 255;echo -ne '\033]0;mysql\007';mysql -u root -p"

#python
#virtualenv settings
#export WORKON_HOME=$HOME/.virtualenvs
#export PATH=/usr/local/share/python:${PATH}
#. /usr/local/share/python/virtualenvwrapper.sh

#ビープ音いらない
setopt NO_beep

function is_exists() { type "$1" >/dev/null 2>&1; return $?; }
function is_osx() { [[ $OSTYPE == darwin* ]]; }
function is_screen_running() { [ ! -z "$STY" ]; }
function is_tmux_runnning() { [ ! -z "$TMUX" ]; }
function is_screen_or_tmux_running() { is_screen_running || is_tmux_runnning; }
function shell_has_started_interactively() { [ ! -z "$PS1" ]; }
function is_ssh_running() { [ ! -z "$SSH_CONECTION" ]; }

function tmux_automatically_attach_session()
{
    if is_screen_or_tmux_running; then
        ! is_exists 'tmux' && return 1

        if is_tmux_runnning; then
            echo "${fg_bold[red]} _____ __  __ _   ___  __ ${reset_color}"
            echo "${fg_bold[red]}|_   _|  \/  | | | \ \/ / ${reset_color}"
            echo "${fg_bold[red]}  | | | |\/| | | | |\  /  ${reset_color}"
            echo "${fg_bold[red]}  | | | |  | | |_| |/  \  ${reset_color}"
            echo "${fg_bold[red]}  |_| |_|  |_|\___//_/\_\ ${reset_color}"
        elif is_screen_running; then
            echo "This is on screen."
        fi
    else
        if shell_has_started_interactively && ! is_ssh_running; then
            if ! is_exists 'tmux'; then
                echo 'Error: tmux command not found' 2>&1
                return 1
            fi

            if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
                # detached session exists
                tmux list-sessions
                echo -n "Tmux: attach? (y/N/num) "
                read
                if [[ "$REPLY" =~ ^[Yy]$ ]] || [[ "$REPLY" == '' ]]; then
                    tmux attach-session
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                elif [[ "$REPLY" =~ ^[0-9]+$ ]]; then
                    tmux attach -t "$REPLY"
                    if [ $? -eq 0 ]; then
                        echo "$(tmux -V) attached session"
                        return 0
                    fi
                fi
            fi

            if is_osx && is_exists 'reattach-to-user-namespace'; then
                # on OS X force tmux's default command
                # to spawn a shell in the user's namespace
                tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "reattach-to-user-namespace -l $SHELL"'))
                tmux -f <(echo "$tmux_config") new-session && echo "$(tmux -V) created new session supported OS X"
            else
                tmux new-session && echo "tmux created new session"
            fi
        fi
    fi
}
tmux_automatically_attach_session
