setxkbmap -option 'ctrl:nocaps'

if ps aux | grep xcape | grep -v grep >/dev/null ; then
  xcape -t 75 -e 'Control_L=Escape'
fi
