#!/bin/bash

set -e

USER="$(whoami)"
TEMP_DIR=${DOTFILES_TEMP_DIR:-/tmp/dotfiles}

command_exists() {
    command -v "$@" >/dev/null 2>&1
}

# The [ -t 1 ] check only works when the function is not called from
# a subshell (like in `$(...)` or `(...)`, so this hack redefines the
# function at the top level to always return false when stdout is not
# a tty.
if [ -t 1 ]; then
    is_tty() {
        true
    }
else
    is_tty() {
        false
    }
fi

copy_dotfiles() {
    fmt_debug "copy dotfiles from $BOLD$TEMP_DIR$RESET to $BOLD$HOME$RESET"
    cp -a "$1/.zsh/" "$1/.bashrc" "$1/.p10k.zsh" "$1/.vimrc" "$1/.zshrc" "$2"
}

# Only use colors if connected to a terminal
if is_tty; then
    LIGHTRED=$(printf '\e[0;91m')

    BLACK=$(printf '\e[0;30m')
    RED=$(printf '\e[0;31m')
    GREEN=$(printf '\e[0;32m')
    YELLOW=$(printf '\e[0;33m')
    BLUE=$(printf '\e[0;34m')
    PURPLE=$(printf '\e[0;35m')
    CYAN=$(printf '\e[0;36m')
    WHITE=$(printf '\e[0;37m')
    GRAY=$(printf '\e[0;90m')

    RESET=$(printf '\e[0;0m')
    RESETNL=$(printf '\e[0;0m\n')
    BOLD=$(printf '\e[0;1m')
    ITALIC="$(printf '\e[0;3m')"
    UNDERLINE=$(printf '\e[0;4m')
    REVERSE=$(printf '\e[0;7m')
else
    LIGHTRED=""

    BLACK=""
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    PURPLE=""
    CYAN=""
    WHITE=""
    GRAY=""

    RESET=""
    RESETNL=""
    BOLD=""
    ITALIC=""
    UNDERLINE=""
    REVERSE=""
fi

fmt_underline() {
    is_tty && printf '%s%s%s\n' "$UNDERLINE" "$*" "$RESET" >&1
}

fmt_error() {
    printf '%s[-] %s%s\n' "$BOLD$RED" "$*" "$RESET" >&2
}

fmt_warn() {
    printf '%s[!] %s%s\n' "$BOLD$YELLOW" "$*" "$RESET" >&2
}

fmt_info() {
    printf '%s[+] %s%s\n' "$WHITE" "$*" "$RESET" >&1
}

fmt_debug() {
    printf '%s[#] %s%s\n' "$GRAY" "$*" "$RESET" >&1
}

fmt_raw() {
    echo -e "$*"
}

if [[ -d "$TEMP_DIR" ]]; then
    rm -rf "$TEMP_DIR"
fi

mkdir -p "$TEMP_DIR"

fmt_raw "
+------------------------------------------------------------------------+
| \t\t\t\t $BOLD$YELLOW!!WARNING!!$RESET \t\t\t\t |
|                                                                        |
|    This script overwrite the files located in the $BOLD$HOME$RESET/ directory.    |
| \t\t $GRAY(e.g. $HOME/.bashrc, $HOME/.zshrc etc.)$RESET \t\t |
|                                                                        |
+------------------------------------------------------------------------+
"

echo -n "Do you wanna continue? [y]es/[N]o: "
read -r

if [[ $REPLY = "y" || $REPLY = "yes" || $REPLY = "Yes" || $REPLY = "Y" ]]; then
    # Check zsh
    if ! command_exists zsh; then
        fmt_error "zsh not found, please install zsh" 1>&2
        exit 2
    fi

    if ! command_exists git; then
        fmt_error "git not found, please install git" 1>&2
        exit 3
    fi

    # Check oh-my-zsh
    if ! [[ -d "$HOME/.oh-my-zsh" ]]; then

        # Check curl
        if command_exists curl; then
            fmt_info "oh-my-zsh install via curl"
            # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$TEMP_DIR"/oh-my-zsh.sh)"
            sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        # Check wget
        elif command_exists wget; then
            fmt_info "oh-my-zsh install via wget"
            # sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O "$TEMP_DIR"/oh-my-zsh.sh)"
            sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

        # Check fetch
        elif command_exists fetch; then
            fmt_info "oh-my-zsh install via fetch"
            # sh -c "$(fetch https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -o "$TEMP_DIR"/oh-my-zsh.sh)"
            sh -c "$(fetch -o - https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        else
            fmt_error "Must install at least one of the following:
- curl
- wget
- fetch
"
            exit 4
        fi
    else
        fmt_info "$HOME/.oh-my-zsh found, skipping."
    fi


    # Check git
    # if ! command_exists git; then
    #     fmt_warn "git not installed" 1>&2
    #     fmt_warn "using curl/wget." 1>&2

    #     mkdir -p "$TEMP_DIR"

    #     # Check curl
    #     if command_exists curl; then
    #         fmt_info "Asim-Tahir-dotfiles.tar.gz fetch via curl"
    #         curl -LJO https://github.com/Asim-Tahir/dotfiles/tarball/main/latest -o "$TEMP_DIR/Asim-Tahir-dotfiles.tar.gz" 1>/dev/null

    #     # Check wget
    #     elif command_exists wget; then
    #         fmt_info "Asim-Tahir-dotfiles.tar.gz fetch via wget"
    #         wget https://github.com/Asim-Tahir/dotfiles/tarball/main/latest -O "$TEMP_DIR/Asim-Tahir-dotfiles.tar.gz" 1>/dev/null

    #     else
    #         fmt_error "curl and wget not installed, first install git or curl or wget." 1>&2
    #         exit 2
    #     fi

    #     # Check tar
    #     if command_exists tar; then
    #         fmt_info "Asim-Tahir-dotfiles.tar.gz extract via tar"
    #         tar -xvf "$TEMP_DIR/Asim-Tahir-dotfiles.tar.gz" -C "$TEMP_DIR"

    #         # remove tar file if exists
    #         [[ -f $TEMP_DIR/Asim-Tahir-dotfiles.tar.gz ]] && rm -f "$TEMP_DIR/Asim-Tahir-dotfiles.tar.gz"

    #         # rename folder from inside tar file
    #         for f in "$TEMP_DIR"/Asim-Tahir-dotfiles*; do
    #             [[ -d "$f" ]] && mv "$f" "$TEMP_DIR/Asim-Tahir-dotfiles"
    #             break
    #         done

    #         copy_dotfiles "$TEMP_DIR/Asim-Tahir-dotfiles" "$HOME"
    #     else
    #         fmt_warn "tar not installed, extraction skipped."
    #         exit 3
    #     fi

    # else
    if [[ -z $DOTFILES_DEBUG ]]; then
        fmt_warn "DEBUG mode enabled, dotfiles copied from $PWD"
        copy_dotfiles "$PWD" "$HOME"
    else
        git clone https://github.com/Asim-Tahir/dotfiles.git "$TEMP_DIR"/
        fmt_info "cloning dotfiles to \"$TEMP_DIR/\" via git"
        copy_dotfiles "$TEMP_DIR" "$HOME"
    fi

    # fi

    # Check powerlevel10k
    if ! [[ -d ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
        fmt_warn "powerlevel10k not installed, installing"
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    else
        fmt_info "powerlevel10k already installed"
    fi

    # Check zsh-autosuggestions plugin
    if ! [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
        fmt_warn "zsh-autosuggestions plugin not installed, installing"
        git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    else
        fmt_info "zsh-autosuggestions already installed, skipping"
    fi

    # Check zsh-syntax-highlighting plugin
    if ! [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
        fmt_warn "zsh-syntax-highlighting plugin not installed, installing"
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
    else
        fmt_info "[+] zsh-syntax-highlighting already installed, skipping"
    fi

    # shellcheck source=/dev/null
    source "$HOME/.bashrc"
    # shellcheck source=/dev/null
    source "$HOME/.zshrc"

    # Remove $TEMP_DIR folder
    [[ -d $TEMP_DIR ]] && rm -rf "$TEMP_DIR"
else
    fmt_warn "exiting without installing"
    exit 1
fi
