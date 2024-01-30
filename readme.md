# WSL Setup

A script i wrote to quickly setup wsl instance.

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
├─ .vimrc
├─ .zshrc
├─ lsd_0.23.1_amd64.deb
└─ README.md
```


- `.p10k.zsh`: [p10k](https://github.com/romkatv/powerlevel10k) config file.
- `.vimrc`: vim config file.
- `.zshrc/`: zsh config file.
- `lsd_0.23.1_amd64.deb`: debian package for [lsd](https://github.com/lsd-rs/lsd).
- `README.md`: This README file.

## Installation

### Prerequisites
Before going ahead, make sure you computer is running a Linux based os.
### Getting Started

- First of all you have to clone the repo by running:
```
git clone https://github.com/fanto98/wsl-setup.git
```

- Then change to the directory:
```
cd ./wsl-setup
```

## Usage

For setting up the vm you have to run the `setup.sh` script in the **Home Directory**.

- Copy `setup.sh` to the home directory: `cp setup.sh ~`
- Make `setup.sh` executable: `chmod u-x setup.sh`
- Run the scrip: `./setup.sh`

## Contributing

Feel free to fork the project, add new scripts or improve existing ones, and yeah, just make it you own 😊.

## Coming Features
- [x] Add a `remove.sh` script for cleaning the home dir.
- [ ] Add option to ask user the list of softwares / sdk he wants to install


## License

This project is licensed under the [MIT License](LICENSE).