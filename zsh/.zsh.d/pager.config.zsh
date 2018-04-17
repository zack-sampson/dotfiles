if command -v kak-pager > /dev/null 2>&1 ; then
  export PAGER=kak-pager
  alias less=$PAGER
fi
if command -v kak-man-pager > /dev/null 2>&1 ; then
  export MANPAGER=kak-man-pager
fi
