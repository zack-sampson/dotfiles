for dir in bin sbin ; do
  if [[ -d "/opt/homebrew/${dir}" ]]; then
    export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/sbin
  fi
done
