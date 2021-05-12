FROM techknowlogick/xgo:base

###########################
# Android Toolchain build #
###########################

ENV ANDROID_NDK         android-ndk-r20b
ENV ANDROID_NDK_PATH    http://dl.google.com/android/repository/$ANDROID_NDK-linux-x86_64.zip
ENV ANDROID_NDK_SUM     d903fdf077039ad9331fb6c3bee78aa46d45527b
ENV ANDROID_NDK_ROOT    /usr/local/$ANDROID_NDK
ENV ANDROID_CHAIN_ARM   arm-linux-androideabi-4.9
ENV ANDROID_CHAIN_ARM64 aarch64-linux-android-4.9
ENV ANDROID_CHAIN_386   x86-4.9
ENV ANDROID_CHAIN_64    x86_64-4.9
ENV ANDROID_CHAIN_LLVM  llvm

RUN \
  $FETCH $ANDROID_NDK_PATH $ANDROID_NDK_SUM && \
  unzip `basename $ANDROID_NDK_PATH` \
    "$ANDROID_NDK/build/*"                                           \
    "$ANDROID_NDK/sources/cxx-stl/llvm-libc++/include/*"       \
    "$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/armeabi*/*" \
    "$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/arm64*/*"   \
    "$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/x86/*"      \
    "$ANDROID_NDK/sources/cxx-stl/llvm-libc++/libs/x86_64/*"   \
    "$ANDROID_NDK/prebuilt/linux-x86_64/*"                           \
    "$ANDROID_NDK/platforms/*/arch-arm/*"                            \
    "$ANDROID_NDK/platforms/*/arch-arm64/*"                          \
    "$ANDROID_NDK/platforms/*/arch-x86/*"                            \
    "$ANDROID_NDK/platforms/*/arch-x86_64/*"                         \
    "$ANDROID_NDK/toolchains/$ANDROID_CHAIN_ARM/*"                   \
    "$ANDROID_NDK/toolchains/$ANDROID_CHAIN_ARM64/*"                 \
    "$ANDROID_NDK/toolchains/$ANDROID_CHAIN_64/*"                    \
    "$ANDROID_NDK/toolchains/$ANDROID_CHAIN_386/*"                   \
    "$ANDROID_NDK/toolchains/$ANDROID_CHAIN_LLVM/*" -d /usr/local > /dev/null && \
  rm -f `basename $ANDROID_NDK_PATH`

# ENV PATH /usr/$ANDROID_CHAIN_ARM/bin:$PATH
# ENV PATH /usr/$ANDROID_CHAIN_ARM64/bin:$PATH
# ENV PATH /usr/$ANDROID_CHAIN_386/bin:$PATH
# ENV PATH /usr/$ANDROID_CHAIN_64/bin:$PATH
ENV PATH $ANDROID_NDK_ROOT/toolchains/llvm/prebuilt/linux-x86_64/bin:$PATH

# golang
ENV GO_VERSION 11512
RUN \
  export ROOT_DIST=https://dl.google.com/go/go1.15.12.linux-amd64.tar.gz && \
  export ROOT_DIST_SHA=bbdb935699e0b24d90e2451346da76121b2412d30930eabcd80907c230d098b7 && \
  \
  $BOOTSTRAP_PURE

# Inject the container entry point, the build script
ADD build.sh /build.sh
ENV BUILD /build.sh
RUN chmod +x $BUILD
