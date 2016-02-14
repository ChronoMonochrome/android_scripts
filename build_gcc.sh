#!/bin/bash

# Target and build configuration.
TARGET=arm-linux-gnueabi
PREFIX=/home/${USER}/android_tools/arm-linux-gnueabi-5.3

if ! test -d ${PREFIX} ; then
	mkdir -p ${PREFIX}
fi

# Sources to build from.
BINUTILS=binutils-2.25.1
GCC=/home/${USER}/android_tools/gcc-5.3.0/build-arm
HOST="i686-linux-gnu"
BUILD="i686-linux-gnu"

SED=sed

# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# Build a set of compatible Binutils for this architecture.  Need this before
# we can build GCC.
mkdir binutils-build
cd binutils-build
../${BINUTILS}/configure --target=${TARGET} --prefix=${PREFIX} --disable-nls --enable-graphite=yes \
    --disable-interwork --disable-multilib --disable-werror --enable-threads --disable-libgomp --enable-eh-frame-hdr-for-static \
    --with-arch=armv7-a --with-fpu=neon --disable-shared --disable-libmudflap --disable-libitm --enable-gold=default \
    --with-mode=arm --with-endian=little --with-host-libstdcxx='-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' \
    --without-included-gettext --disable-bootstrap --enable-threads=posix --disable-sjlj-exceptions \
   --enable-static --enable-gold --enable-plugins --with-plugin-ld=ld.gold --disable-libstdc__-v3 --enable-initfini-array \
   --disable-interwork --enable-plugin --enable-linker-build-id --disable-libssp --with-float=hard --disable-libsanitizer \
   --host=${HOST} --build=${BUILD} --with-gnu-as --with-gnu-ld --disable-tls --enable-target-optspace \
   --enable-languages=c --disable-ppl-version-check --disable-cloog-version-check --disable-isl-version-check --enable-cloog-backend=isl

make -j2
make -j2 install
cd ..

# Add the new Binutils to the path for use in building GCC and Newlib.
export PATH=$PATH:${PREFIX}:${PREFIX}/bin

# Build and configure GCC with the Newlib C runtime. Note that the 'with-gmp',
# 'with-mpfr' and 'with-libconv-prefix' are needed only for Mac OS X using the
# MacPorts system.

../configure --target=${TARGET} --prefix=${PREFIX} --enable-gold=default --with-sysroot=/ \
    --with-gnu-as --with-gnu-ld --disable-nls --disable-libssp --disable-libstdc__-v3 \
    --disable-gomp --disable-libstcxx-pch --enable-threads --disable-shared --disable-libquadmath \
    --disable-libmudflap --disable-interwork --disable-libobjc --enable-languages=c \
    --with-arch=armv7-a --disable-libgomp --disable-libatomic --disable-tls --enable-target-optspace \
    --with-fpu=neon --with-mode=arm --with-endian=little --disable-sjlj-exceptions --enable-eh-frame-hdr-for-static \
    --disable-libstdc++-v3 --disable-multilib --disable-werror --with-isl --with-float=hard \
    --enable-plugin --with-system-zlib --enable-linker-build-id --disable-libitm --disable-libsanitizer \
    --without-included-gettext --enable-threads=posix --disable-bootstrap --enable-graphite=yes \
    --enable-static --enable-gold --enable-plugins --with-plugin-ld=ld.gold --enable-initfini-array \
   --host=${HOST} --build=${BUILD} --with-host-libstdcxx='-static-libgcc -Wl,-Bstatic,-lstdc++,-Bdynamic -lm' \
  --disable-ppl-version-check --disable-cloog-version-check --disable-isl-version-check --enable-cloog-backend=isl


make -j2
make -j2 install

# Use the following instead if only building and installing GCC (i.e. without Newlib).
#make all-gcc install-gcc 2>&1 | tee -a make.log


# We are done, let the user know were the new compiler and tools are.
echo ""
echo "Cross GCC for ${TARGET} installed to ${PREFIX}"
echo ""
