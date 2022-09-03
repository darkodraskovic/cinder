# utilities

validate_exit() {
    if [ $? != 0 ]; then
        exit 1
    fi
}

# state variabls

TARGET=
ROOT_DIR="~/Development/cinder/"
COMPILE_CMD="make"
CONFIGURE=false
BUILD=false
RUN=false

while getopts "t:cbr" option; do
    case $option in
        t)
            TARGET=$OPTARG
            ;;
        c)
            CONFIGURE=true
            ;;        
        b)
            BUILD=true
            ;;        
        r)
            RUN=true
            ;;        
    esac
done

EXE_NAME=./$TARGET

WIN=false
if [ "$OSTYPE" = "msys" ]; then
    WIN=true
    ROOT_DIR="c:/Users/darko/Development/cinder/"
    
    SLN=app.sln
    if [ -z $TARGET ]; then
        TARGET=${SLN}
    else 
        TARGET=${TARGET}.vcxproj
        EXE_NAME=${EXE_NAME}.exe
    fi
    COMPILE_CMD="MSBuild.exe -target:Build /property:Configuration=Release"
fi

if [ $CONFIGURE = true ]; then
    echo "INFO: configure Make(Linux)/MSBuild(Windows)"
    cd ${ROOT_DIR}/build
    cmake ..
    validate_exit
    
    if [ $WIN == true ]; then
        echo "INFO: configure Ninja(Widows)"    
        cd $ROOT_DIR/ninja/
        cmake -G"Ninja" ..
        validate_exit
    fi
    mv compile_commands.json ..
fi

if [ $BUILD = true ]; then
    echo "COMPILE_CMD: ${COMPILE_CMD} ${TARGET}"
    cd $ROOT_DIR/build
    $COMPILE_CMD $TARGET
    validate_exit
fi

if [ $RUN = true ]; then
    echo "EXE_NAME: ${EXE_NAME}"    
    cd $ROOT_DIR/bin
    $EXE_NAME
fi
