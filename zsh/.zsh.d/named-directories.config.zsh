# set named directory aliases to match contexts
# not sure how to do this dynamically if new contexts are created...
find $HOME/contexts -mindepth 1 -maxdepth 1 -type d |
while read dir ; do
  eval $(basename $dir)="${dir}"
done
