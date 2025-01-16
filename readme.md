# WSL Setup

A script i wrote to quickly setup wsl instance as well as git bash windows shell.

## Table of Contents
- [WSL Setup](#wsl-setup)
  - [Table of Contents](#table-of-contents)
  - [Project Structure](#project-structure)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Getting Started](#getting-started)
  - [Usage](#usage)
  - [Contributing](#contributing)
  - [Coming Features](#coming-features)
  - [License](#license)

## Project Structure

```
project-root/
├─ .p10k.zsh
├─ clean-dl.sh
├─ .zshrc
├─ .wezterm.lua
├─ fancontroll.json
└─ README.md
```


- `.p10k.zsh`: [p10k](https://github.com/romkatv/powerlevel10k) config file.
- `clean-dl.sh`: bash script for cleaning up my Windows ***Downloads*** directory
- `.zshrc/`: [zsh](https://en.wikipedia.org/wiki/Z_shell) config file.
- `.wezterm.lua`: [wezterm](https://wezfurlong.org/wezterm/index.html) config file.
- `fancontroll.json`: [fancontroll](https://getfancontrol.com/)
- `README.md`: This README file.

## Installation

### Prerequisites
The script is made to suit my needs so it has to be customize for what you are looking for. Check out the `setup.sh` script and modify it depending on your needs :).

### Getting Started

- First of all you have to clone the repo by running:
```
git clone https://github.com/fanto98/setup.git
```

- Then change to the directory:
```
cd ./setup
```

## Usage

For setting up the vm you have to run the `setup.sh` script in the **Home Directory**.

- Copy `setup.sh` to the home directory: `cp setup.sh ~`
- Make `setup.sh` executable: `chmod u+x setup.sh`
- Run the scrip: `./setup.sh`

## Contributing

Feel free to fork the project, add new scripts or improve existing ones, and yeah, just make it you own 😊.

## Coming Features
- [x] Add a `remove.sh` script for cleaning the home dir.
- [ ] Add option to ask user the list of softwares / sdk he wants to install


## License

This project is licensed under the [MIT License](LICENSE).
