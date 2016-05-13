---
layout: default
title: Download
order: 1
---
CyberHose is only available as source at this time.  The best solution is to clone the repository onto you Pi and compile it with `clang`.

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