#!/bin/sh

logit() {
    echo "[$(date +"%Y-%m-%dT%H:%M:%S")] - ${*}"
}

install_brave() {
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

    sudo apt update

    sudo apt install brave-browser -y
}

install_code() {
    logit "Install Visual Studio Code manually"
}

install_docker() {
    sudo apt install docker.io -y
    sudo apt install docker-compose -y
}

install_git() {
    sudo apt install git -y
}

install_idea() {
    logit "Install Intellij manually"
}

install_kind() {
    # For AMD64 / x86_64
    [ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-amd64
    # For ARM64
    [ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.22.0/kind-linux-arm64
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
}

install_nvm() {
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    nvm install lts/iron
}

install_oh_my_zsh() {
    sudo apt install zsh -y
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_sdk() {
    curl -s "https://get.sdkman.io" | bash
    source "$HOME/.sdkman/bin/sdkman-init.sh"
    sdk install java 17.0.10-tem
}

setup() {
    sudo apt update
    install_git
    install_docker
    install_kind
    install_nvm
    install_sdk
    install_oh_my_zsh
}

setup
