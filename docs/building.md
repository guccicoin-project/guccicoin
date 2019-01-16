## How To Compile

### Linux

#### Prerequisites

You will need the following packages: boost, cmake (3.8 or higher), make, and git.
You will also need either GCC/G++.
You will need GCC-6.0 or higher.

#### GCC setup, on Ubuntu

- `sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y`
- `sudo apt-get update`
- `sudo apt-get install aptitude -y`
- `sudo aptitude install -y build-essential g++-8 gcc-8 git libboost-all-dev python-pip`
- `sudo pip install cmake`
- `export CC=gcc-8`
- `export CXX=g++-8`
- `git clone -b master --single-branch https://github.com/guccicoin-project/guccicoin`
- `cd guccicoin`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./GucciCoind --version`

#### Apple

#### Prerequisites

- Install [cmake](https://cmake.org/). See [here](https://stackoverflow.com/questions/23849962/cmake-installer-for-mac-fails-to-create-usr-bin-symlinks) if you are unable to call `cmake` from the terminal after installing.
- Install the [boost](http://www.boost.org/) libraries. Either compile boost manually or run `brew install boost`.
- Install XCode and Developer Tools.


#### Building

- `git clone -b master --single-branch https://github.com/guccicoin-project/guccicoin`
- `cd guccicoin`
- `mkdir build && cd $_`
- `cmake ..` or `cmake -DBOOST_ROOT=<path_to_boost_install> ..` when building
  from a specific boost install. If you used brew to install boost, your path is most likely `/usr/local/include/boost.`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./GucciCoind --version`

If your version of gcc is too old, you may need to run:

- `brew install gcc@8`
- `export CC=gcc-8`
- `export CXX=g++-8`

### Windows

#### Prerequisites

- Install [Visual Studio 2017 Community Edition](https://www.visualstudio.com/thank-you-downloading-visual-studio/?sku=Community&rel=15&page=inlineinstall)
- When installing Visual Studio, it is **required** that you install **Desktop development with C++**
- Install the latest version of [Boost](https://sourceforge.net/projects/boost/files/boost-binaries/1.68.0/boost_1_68_0-msvc-14.1-64.exe/download) - Currently Boost 1.68.

#### Building

- From the start menu, open 'x64 Native Tools Command Prompt for vs2017'.
- `cd guccicoin` *<- where you git clone to*
- `mkdir build`
- `cd build`
- `set PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin";%PATH%`
- `cmake -G "Visual Studio 15 2017 Win64" .. -DBOOST_ROOT=C:/local/boost_1_68_0` (Or your boost installed dir.)
- `MSBuild TurtleCoin.sln /p:Configuration=Release /m`

The binaries will be in the `src/Release` folder when you are complete.

- `cd src`
- `cd Release`
- `GucciCoind.exe --version`

### Raspberry Pi 3 B+
The following images are known to work. Your operation system image **MUST** be 64 bit.

#### Known working images

- https://github.com/Crazyhead90/pi64/releases
- https://fedoraproject.org/wiki/Architectures/ARM/Raspberry_Pi#aarch64_supported_images_for_Raspberry_Pi_3
- https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-3

Once you have a 64 bit image installed, setup proceeds the same as any Linux distribution. Ensure you have at least 2GB of ram, or the build is likely to fail. You may need to setup swap space.

#### Building

- `git clone -b master --single-branch https://github.com/guccicoin-project/guccicoin`
- `cd guccicoin`
- `mkdir build`
- `cd build`
- `cmake ..`
- `make`

The binaries will be in the `src` folder when you are complete.

- `cd src`
- `./GucciCoind --version`