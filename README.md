deepdream-box
================

## Introduction
This project builds environment for easy to use deepdream.


## Requirements
* VirtualBox
* Vagrant

## Usage

```
host $ git clone https://github.com/maruware/deepdream-box.git
host $ cd deepdream-box
host $ vagrant up
host $ vagrant ssh
```

```
vagrant@deepdream-box:~$ ipython notebook --profile=nbserver
```

on Host Machine Web browser
1. Open http://localhost:3000/
2. Select deepdream
3. Select dream.ipynb
