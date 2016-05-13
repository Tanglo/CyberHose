---
layout: default
title: Download
order: 1
---
When CyberHose first becomes availble it will be as source only.  To get the source you can clone the CyberHose repository using git.  To clone in to the current directory run the following from your shell:

 ```
git clone https://github.com/Tanglo/CyberHose.git
```

Alternatively download a [tarball](https://github.com/Tanglo/CyberHose/tarball/master "CyberHose tarball") or [zip file](https://github.com/Tanglo/CyberHose/zipball/master "CyberHose zip file") of the latest source.

 

#### Dependancies
CyberHose is written in objective-c and uses the GnuStep framework.  You will need clang, gnustep and the gnustep develmopment tools to compile CyberHose.  Assuming you are running Raspbian on your Pi you can get these pacakges from the shell with the following commands.

__Clang__

 ```
sudo apt-get install clang
```

__GNUStep__

 ```
sudo apt-get install gnustep
```

__GNUStep development tools__

 ```
sudo apt-get install gnustep-devel
```