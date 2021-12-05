# CHANGELOG for Dotfiles

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).


## [Unreleased]
- `docker` and `docker-compose` support. Easily display command prompt with no installation required.
  #### `docker`
  ```bash
  docker run --rm -it asimtahir/dotfiles sh
  ```
  #### `docker-compose`
  ```bash
  docker-compose up --rm -it
  ```

## [0.3.0] - 05 December 2021

### Features

- Easily setup via [`install.sh`](https://github.com/Asim-Tahir/dotfiles/blob/main/install.sh). Just follow the script instructions.

  #### Linux 🐧/ MacOS 🍎

  1. ##### First things first, install `zsh`, `git`, (`curl`/`wget`/`fetch`).
      ##### For `Ubuntu` 🐧
      ```bash
      sudo apt update -y && sudo apt install zsh git curl -y
      ```
      ##### For `MacOS` 🍎
      ```bash
      brew install zsh git curl
      ```
  2. ##### Fetch and run [`install.sh`](https://github.com/Asim-Tahir/dotfiles/blob/main/install.sh) script

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
      *ASAP add installation script for Windows PowerShell.*
<br/>

## [0.2.0] - 5 May 2021

### Removed

- `.oh-my-zsh` folder removed. Must be installed separately. [Follow installation instruction](https://github.com/Asim-Tahir/dotfiles#oh-my-zsh)

### Added

- [`docker-compose` completion added](.zsh/completion/_docker-compose)

