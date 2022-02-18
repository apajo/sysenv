Sysenv
============

### Introduction

[Sysenv](https://github.com/apajo/sysenv) is a helper application for backing up you (system/personal) configuration files.
At it's core, it adds some scripts for easier usage of the [yadm](https://github.com/TheLocehiliosan/yadm/) application (wich also is basically a wrapper for the [git](https://github.com/git/git) applicatation)

### Prerequisites

* Debian distro based OS (with aptitude package manager) (tested on Ubuntu 20.04)
* sudo privileges on your device or system

### Installation

To install run the command:

```shell
$ . <(curl -L https://apajo.github.io/sysenv/install)
```

> you will be prompted for your __repository url__ and __device name__ (or branch in git)

This will install you few applications:
* [sysenv](https://github.com/apajo/sysenv) - helper scripts for [yadm](https://github.com/TheLocehiliosan/yadm/)
* [yadm](https://github.com/TheLocehiliosan/yadm/) - a git wrapper with some extra functionality
* [git](https://github.com/git/git) - for managing your repository

It also adds `syadm` command your shell - it's yadm with sudo privileges (for system file backup)

### Commands

`sysenv [cmd]`

There are several [sysenv](https://github.com/apajo/sysenv) commands available, main ones being:
* __update__ - update the [sysenv](https://github.com/apajo/sysenv) application
* __save__ - save your configuration to the repository
* __load__ - load your configuration from the repository
* __setup__ - setup your repo and branch (or "device name")

### Basic usage

1) Add files to backup:
```shell
$ sysenv add [path_to_your_file]
```

2) Save your files to the repo
```shell
$ sysenv save
```

3) After changing the previously added file, you can simply save the changes with:
```shell
$ sysenv save
```

> Note! As with [git](https://github.com/git/git), after adding files, they will be tracked.

#### Load changes from another device

If you've done any changes to the repository from another device you can load them with:
```shell
$ sysenv load
```

#### Changing repository (and branch)
```bash
$ sysenv setup [url] [device/branch]
```

#### Updating 

Update the sysenv application
```bash
$ sysenv update
```

### Versioning

Choosing version numbers for [sysenv](https://github.com/apajo/sysenv) is done following the [semantic versioning](https://semver.org/)

### Testing

#### Setup

To test sysenv you need to have [Docker](https://github.com/jenkinsci/docker) installed on your system.

Add correct ssh key files to the `test/files/.ssh/` directory.

Add repository url and branch name in `test/files/.install` file.

While in `test` directory, run:
```bash
$ make all
```

or for more help run:
```bash
$ make help
```

#### Run


### Future work

That's it for now! Future work include the following:

* Corss-distro package manager (such as Nix-OS)
