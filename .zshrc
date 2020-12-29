# Trim working dir to 1/4 the screen width
function prompt_workingdir () {
  local pwdmaxlen=$(($COLUMNS/3))
  local trunc_symbol="..."
  if [[ $PWD == $HOME* ]]; then
    newPWD="~${PWD#$HOME}"
  else
    newPWD=${PWD}
  fi
  if [ ${#newPWD} -gt $pwdmaxlen ]; then
    local pwdoffset=$(( ${#newPWD} - $pwdmaxlen + 3 ))
    newPWD="${trunc_symbol}${newPWD:$pwdoffset:$pwdmaxlen}"
  fi
  echo $newPWD
}

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

# autojump
[[ -s /Users/harblh/.autojump/etc/profile.d/autojump.sh ]] && source /Users/harblh/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# function evaluation in prompt
setopt prompt_subst

# auto cd
setopt auto_cd

# better tab navigation
setopt noautomenu
setopt nomenucomplete

# colors?
autoload -U colors && colors

# left prompt host
PROMPT='[%B%F{green}$(hostname -s)%f%b]'
# left prompt dir
PROMPT+='[%B%F{blue}$(prompt_workingdir)%f%b]> '

# right prompt git
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
RPROMPT="%F{yellow}\$vcs_info_msg_0_%f"
zstyle ':vcs_info:git:*' formats '%b'

alias mk='make -j 28'
alias mkd='METHOD=devel mk'
alias mkdb='METHOD=dbg mk'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/harblh/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/harblh/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/harblh/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/harblh/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
