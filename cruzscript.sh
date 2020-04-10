GO_VERSION="1.14.2"
OS=`uname -s`
HOME_DIR=$HOME
GO_HOME=$HOME_DIR/go
GO_ROOT=/usr/local/go
ARCH=`uname -m`

function usage {
    printf "./installGO.sh -v <version> \n"
    printf "Example: ./installGO.sh -v 1.7.3 \n"
    exit 1
}

while getopts ":v:" opt; do
  case $opt in
    v) GO_VERSION="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    echo 
    usage
    ;;
  esac
done 

# Function to install golang and setup the env.
function install {
    echo
    echo "...... [ Scanning ]"
    # Check if there's any older version of GO installed on the machine. 
    if [ -d /usr/local/go ]; then 
        echo "...... [ Found an older version of GO ]"
        printf "Would you like to remove it? [y/N]: "
        read ans
        case "$ans" in 
            "y"|"yes"|"Y"|"Yes"|"YES") sudo rm -rf /usr/local/go;;
            *) echo "...... [ Exiting ]"; exit 0;;
        esac
    fi
    # If the operating system is 64-bit Linux
    if [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ]; then
        PACKAGE=go$GO_VERSION.linux-amd64.tar.gz
        pushd /tmp > /dev/null
            echo
            echo "...... [ Downloading ]"
            wget https://storage.googleapis.com/golang/$PACKAGE
            if [ $? -ne 0 ]; then 
                echo "Failed to Download the package! Exiting."
                exit 1
            fi
            echo "...... [ Installing ]"
            sudo tar -C /usr/local -xzf $PACKAGE
            rm -rf $PACKAGE
        popd > /dev/null
        echo "...... [ Installed ]"
        setup
        echo "...... [ Open a new terminal tab to start using GO ]"
        exit 0
    fi

    # If the operating system is 64-bit MacOS
    if [ "$OS" == "Darwin" ] && [ "$ARCH" == "x86_64" ]; then 
        PACKAGE=go$GO_VERSION.darwin-amd64.pkg
        pushd /tmp  > /dev/null
            echo
            echo "...... [ Downloading ]"
            wget https://storage.googleapis.com/golang/$PACKAGE
            if [ $? -ne 0 ]; then 
                echo "Failed to Download the package! WTF!"
                exit 1
            fi
            echo "...... [ Installing ]"
            sudo /usr/sbin/installer -pkg $PACKAGE -target /
            rm -rf $PACKAGE
        popd > /dev/null
        echo "...... [ Installed ]"
        setup
        echo "...... [ Open a new terminal tab to start using GO ]"
        exit 0
    fi

    # Couldn't determine the machine arch or the operating system. So error out mate!'
    errorout
}

function setup {
    # Create GOHOME and the required directories
    if [ ! -d $GO_HOME ]; then
        mkdir $GO_HOME
        mkdir -p $GO_HOME/{src,pkg,bin}
    else
        mkdir -p $GO_HOME/{src,pkg,bin}
    fi

    if [ "$OS" == "Linux" ] && [ "$ARCH" == "x86_64" ]; then
        grep -q -F 'export GOPATH=$HOME/go' $HOME/.bashrc || echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc
        grep -q -F 'export GOROOT=/usr/local/go' $HOME/.bashrc || echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc
        grep -q -F 'export PATH=$PATH:$GOROOT/bin' $HOME/.bashrc || echo 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.bashrc
        grep -q -F 'export PATH=$PATH:$GOPATH/bin' $HOME/.bashrc || echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc  
    fi

    if [ "$OS" == "Darwin" ] && [ "$ARCH" == "x86_64" ]; then
        grep -q -F 'export GOPATH=$HOME/go' $HOME/.bash_profile || echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
        grep -q -F 'export GOROOT=/usr/local/go' $HOME/.bash_profile || echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
        grep -q -F 'export PATH=$PATH:$GOROOT/bin' $HOME/.bash_profile || echo 'export PATH=$PATH:$GOROOT/bin' >> $HOME/.bash_profile
        grep -q -F 'export PATH=$PATH:$GOPATH/bin' $HOME/.bash_profile || echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bash_profile
    fi
    echo
    echo "...... [You're ready to Go :)]"
}

function errorout {
    echo "Cannot determine your operating system or you ain't running a 64-bit machine."
    echo "You are on 64-bit Linux/MacOS and this script is still failing? Write to @RaviTezu(Twitter)"
    exit 1
}

source ~/.bashrc

mkdir -p $GOPATH/src/github.com/infobloxopen; cd $GOPATH/src/github.com/infobloxopen
git clone git@github.com:infobloxopen/terraform-provider-infoblox
cd $GOPATH/src/github.com/infobloxopen/terraform-provider-infoblox
export GO111MODULE="on"
make build
