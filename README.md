## Preview 👀

![Preview of Terminal](https://user-images.githubusercontent.com/29407019/99193512-81b49e00-278a-11eb-9844-273df11536f4.png)

## Powered By ⚡

- `zsh` _shell_
- [`oh-my-zsh`](https://github.com/ohmyzsh/ohmyzsh) _zsh plugin manager_
- [`powerlevel10K`](https://github.com/romkatv/powerlevel10k) _zsh theme_

## Plugins 🔌

- [git](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [docker](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker)
- [docker-compose](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/docker-compose)
- [virtualenv](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/virtualenv)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)

## Installation 💻

#### Linux 🐧/ MacOS 🍎

1.  ##### First things first, install `zsh`, `git`, (`curl`/`wget`/`fetch`).
    ##### For `Ubuntu` 🐧
    ```bash
    sudo apt update -y && sudo apt install zsh git curl -y
    ```
    ##### For `MacOS` 🍎
    ```bash
    brew install zsh git curl
    ```
2.  ##### Fetch and run [`install.sh`](https://github.com/Asim-Tahir/dotfiles/blob/main/install.sh) script

    ##### via `curl`
    ```bash
    sh -c "$(curl -fsSL https://raw.github.com/Asim-Tahir/dotfiles/main/install.sh)"
    ```

    ##### via `wget`
    ```bash
    sh -c "$(wget https://raw.github.com/Asim-Tahir/dotfiles/main/install.sh -O -)"
    ```

    ##### via `fetch`
    ```bash
    sh -c "$(fetch -o - https://raw.github.com/Asim-Tahir/dotfiles/main/install.sh)"
    ```

    #### Windows 🖥️
    *ASAP add installation script for Windows PowerShell >= `5.0`*

    <!-- NOT READY YET -->
    <!-- #### PowerShell
    ```powershell
    iwr -URI https://raw.github.com/Asim-Tahir/dotfiles/main/install.ps1 -OutFile install.ps1 | powershell -c -noprofile -executionpolicy bypass -
    ``` -->

    <br/>

<!-- - `docker` and `docker-compose` support. Easily display dotfiles.
  #### `docker`
  ```bash
  docker run --rm -it asimtahir/dotfiles sh
  ```
  #### `docker-compose`
  ```bash
  docker-compose up --rm -it
  ```
 -->
