
if [ "$PS1" ]; then
  set_prompt () {
    Last_Command=$? # Must come first!
    Blue='\[\e[01;34m\]'
    White='\[\e[01;37m\]'
    Red='\[\e[01;31m\]'
    YellowBack='\[\e[01;43m\]'
    Green='\[\e[01;32m\]'
    Yellow='\[\e[01;33m\]'
    Black='\[\e[01;30m\]'
    Reset='\[\e[00m\]'
    FancyX='\342\234\227'
    Checkmark='\342\234\223'

    if [[ $Last_Command == 0 ]]; then
      PS1="$Green$Checkmark "
    else
      PS1="$Red$FancyX "
    fi

    if [[ $EUID == 0 ]]; then
        PS1+="$Black $YellowBack ȜƔðþƛƪȢƢɅǽƱǷ 𝘝∂.∂.∂ $Reset $Red \\u@\\h"
    else
        PS1+="$Black $YellowBack ℳubBøx 𝘝∂.∂.∂ $Reset $Green \\u@\\h"
    fi
    PS1+="$Blue\\w \\\$$Reset "
  }

  PROMPT_COMMAND='set_prompt'
fi

