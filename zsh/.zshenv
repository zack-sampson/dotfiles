export PATH=${PATH}:/opt/ts/bin

case "$(uname -s)" in
    Linux*)     export ZLS_OS=Linux;;
    Darwin*)    export ZLS_OS=Mac;;
    CYGWIN*)    export ZLS_OS=Cygwin;;
    MINGW*)     export ZLS_OS=MinGw;;
    *)          export ZLS_OS="UNKNOWN:${unameOut}"
esac
