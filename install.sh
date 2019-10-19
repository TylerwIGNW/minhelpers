unameOut="$(uname -s)"
case "${unameOut}" in
    Darwin*)
      echo "Installing defaults from Tyler Walker"
      machine=Mac
      xcode-select --install
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      brew cask install iterm2 google-chrome slack
      brew install zsh zsh-completions git nvim python python3 wget cmake macvim node zip docker docker-compose docker-machine xhyve docker-machine-driver-xhyve 
      sudo easy_install pip
      sudo chown root:wheel /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
      sudo chmod u+s /usr/local/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
      pip install --user virtualenv
      curl -O https://akamaicdn.webex.com/client/webexapp.dmg
      curl -O https://zoom.us/client/latest/Zoom.pkg
      curl -O https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-OSX.dmg
      curl -O https://download.docker.com/mac/stable/Docker.dmg
      curl -O https://releases.hashicorp.com/terraform/0.12.12/terraform_0.12.12_darwin_amd64.zip
      curl -O https://releases.hashicorp.com/vault/1.2.3/vault_1.2.3_darwin_amd64.zip
      unzip *.zip -d /usr/local/bin
      curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-267.0.0-darwin-x86_64.tar.gz
      tar -xzvf *.tar.gz
      ./google-cloud-sdk/install.sh
      npm -g install remark
      npm -g install remark-cli
      npm -g install remark-stringify
      npm -g install remark-frontmatter
      npm -g install wcwidth
      npm install --global prettier
      sudo hdiutil attach webexapp.dmg
      sudo installer -package /Volumes/Cisco\ Webex\ Meetings.pkg/Cisco\ Webex\ Meetings.pkg -target /
      sudo hdiutil detach webexapp.dmg
      sudo hdiutil detach /Volumes/Cisco\ Webex\ Meetings.pkg
      sudo hdiutil attach VirtualBox-6.0.14-133895-OSX.dmg
      sudo installer -package /Volumes/VirtualBox/VirtualBox.pkg -target /
      sudo hdiutil detach /Volumes/VirtualBox/
      sudo installer -package Zoom.pkg -target /
      curl -O https://download.virtualbox.org/virtualbox/6.0.14/VirtualBox-6.0.14-133895-OSX.dmg
      sudo hdiutil attach Docker.dmg
      cp -R /Volumes/Docker/Docker.app /Applications/Docker.app
      sudo hdiutil detach /Volumes/Docker/
      rm -rf webexapp.dmg
      rm -rf VirtualBox-6.0.14-133895-OSX.dmg
      rm -rf Zoom.pkg
      curl -sLf https://spacevim.org/install.sh | bash -i
      curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
      curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 \
      chmod +x minikube
      sudo mv minikube /usr/local/bin
      cp .zshrc ~/.zshrc
      ./goinstall.sh
      go get -u github.com/jstemmer/gotags
      cp init.toml ~/.Spacevim.d/init.toml
      open -a iTerm 
			;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     echo "You have made a horrible mistake. Find a better machine" machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac
