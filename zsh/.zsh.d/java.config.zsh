if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME=$(/usr/libexec/java_home -v 18)
fi
