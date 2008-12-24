#!/bin/sh -e
#
# This shell script tests the build of MPD with various compile-time
# options.
#
# Author: Max Kellermann <max@duempel.org>

PREFIX=/tmp/mpd
rm -rf $PREFIX

export CFLAGS="-Os"

test -x configure || NOCONFIGURE=1 ./autogen.sh

# all features on
./configure --prefix=$PREFIX/full \
    --disable-dependency-tracking --enable-debug --enable-werror \
    --enable-un \
    --enable-ao --enable-mod --enable-mvp
make -j2 install
make distclean

# no UN, no oggvorbis, no flac, enable oggflac
./configure --prefix=$PREFIX/small \
    --disable-dependency-tracking --enable-debug --enable-werror \
    --disable-un \
    --disable-flac --disable-oggvorbis --enable-oggflac
make -j2 install
make distclean

# strip down (disable TCP, disable nearly all plugins)
CFLAGS="$CFLAGS -DNDEBUG" \
./configure --prefix=$PREFIX/tiny \
    --disable-dependency-tracking --disable-debug --enable-werror \
    --disable-tcp \
    --disable-curl \
    --disable-id3 --disable-lsr \
    --disable-ao --disable-alsa --disable-jack --disable-pulse --disable-fifo \
    --disable-shout-ogg --disable-shout-mp3 --disable-lame \
    --disable-ffmpeg --disable-wavpack --disable-mpc --disable-aac \
    --disable-flac --disable-oggvorbis --disable-oggflac --disable-audiofile \
    --with-zeroconf=no
make -j2 install
make distclean

# shout: ogg without mp3
./configure --prefix=$PREFIX/shout_ogg \
    --disable-dependency-tracking --disable-debug --enable-werror \
    --disable-tcp \
    --disable-curl \
    --disable-id3 --disable-lsr \
    --disable-ao --disable-alsa --disable-jack --disable-pulse --disable-fifo \
    --enable-shout-ogg --disable-shout-mp3 --disable-lame \
    --disable-ffmpeg --disable-wavpack --disable-mpc --disable-aac \
    --disable-flac --enable-oggvorbis --disable-oggflac --disable-audiofile \
    --with-zeroconf=no
make -j2 install
make distclean

# shout: mp3 without ogg
./configure --prefix=$PREFIX/shout_mp3 \
    --disable-dependency-tracking --disable-debug --enable-werror \
    --disable-tcp \
    --disable-curl \
    --disable-id3 --disable-lsr \
    --disable-ao --disable-alsa --disable-jack --disable-pulse --disable-fifo \
    --disable-shout-ogg --enable-shout-mp3 --enable-lame \
    --disable-ffmpeg --disable-wavpack --disable-mpc --disable-aac \
    --disable-flac --disable-oggvorbis --disable-oggflac --disable-audiofile \
    --with-zeroconf=no
make -j2 install
make distclean

# oggvorbis + oggflac
./configure --prefix=$PREFIX/oggvorbisflac \
    --disable-dependency-tracking --disable-debug --enable-werror \
    --disable-tcp \
    --disable-curl \
    --disable-id3 --disable-lsr \
    --disable-mp3 \
    --disable-ao --disable-alsa --disable-jack --disable-pulse --disable-fifo \
    --disable-shout-ogg --disable-shout-mp3 --disable-lame \
    --disable-ffmpeg --disable-wavpack --disable-mpc --disable-aac \
    --disable-flac --enable-oggvorbis --enable-oggflac --disable-audiofile \
    --with-zeroconf=no
make -j2 install
make distclean