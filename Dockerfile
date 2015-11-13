FROM bitriseio/docker-bitrise-base:latest

ENV ANDROID_HOME /opt/android-sdk-linux


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq

# Base (non android specific) tools
# -> should be added to bitriseio/docker-bitrise-base

# Dependencies to execute Android builds
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-7-jdk libc6-i386 lib32stdc++6 lib32gcc1 lib32ncurses5 lib32z1


# ------------------------------------------------------
# --- Download Android SDK tools into $ANDROID_HOME

RUN cd /opt && wget -q https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz -O android-sdk.tgz
RUN cd /opt && tar -xvzf android-sdk.tgz
RUN cd /opt && rm -f android-sdk.tgz

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

# ------------------------------------------------------
# --- Install Android SDKs and other build packages

# Other tools and resources of Android SDK
#  you should only install the packages you need!
# To get a full list of available options you can use:
#  android list sdk --no-ui --all --extended
RUN echo y | android update sdk --no-ui --all --filter \
  platform-tools,extra-android-support

# google apis
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter \
  addon-google_apis-google-23,addon-google_apis-google-22,addon-google_apis-google-21

# SDKs
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter \
  android-23,android-22,android-21,android-20,android-19,android-17,android-15,android-10
# build tools
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter \
  build-tools-23.0.2,build-tools-22.0.1,build-tools-21.1.2,build-tools-20.0.0,build-tools-19.1.0,build-tools-17.0.0

# Android System Images, for emulators
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter \
  sys-img-armeabi-v7a-android-23,sys-img-armeabi-v7a-android-22,sys-img-armeabi-v7a-android-21,sys-img-armeabi-v7a-android-19,sys-img-armeabi-v7a-android-17,sys-img-armeabi-v7a-android-16,sys-img-armeabi-v7a-android-15

# Extras
RUN echo y | android update sdk --no-ui --all --filter \
  extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services


# ------------------------------------------------------
# --- Android NDK

# download
RUN mkdir /opt/android-ndk-tmp
RUN cd /opt/android-ndk-tmp && wget -q http://dl.google.com/android/ndk/android-ndk-r10e-linux-x86_64.bin
# uncompress
RUN cd /opt/android-ndk-tmp && chmod a+x ./android-ndk-r10e-linux-x86_64.bin
RUN cd /opt/android-ndk-tmp && ./android-ndk-r10e-linux-x86_64.bin
# move to it's final location
RUN cd /opt/android-ndk-tmp && mv ./android-ndk-r10e /opt/android-ndk
# remove temp dir
RUN rm -rf /opt/android-ndk-tmp
# set the related ENV
ENV ANDROID_NDK_HOME /opt/android-ndk
# add to PATH
ENV PATH ${PATH}:${ANDROID_NDK_HOME}


# ------------------------------------------------------
# --- Install Gradle from PPA

# Gradle PPA
RUN add-apt-repository ppa:cwchien/gradle
RUN apt-get update
RUN apt-get -y install gradle
RUN gradle -v

# ------------------------------------------------------
# --- Install Maven 3 from PPA

RUN apt-get purge maven maven2
RUN add-apt-repository ppa:andrei-pozolotin/maven3
RUN apt-get update
RUN apt-get -y install maven3
RUN mvn --version

# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID 5
CMD bitrise -version
