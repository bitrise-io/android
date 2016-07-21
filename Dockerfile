FROM bitriseio/docker-bitrise-base-alpha:latest

ENV ANDROID_HOME /opt/android-sdk-linux


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq

# Base (non android specific) tools
# -> should be added to bitriseio/docker-bitrise-base

# Dependencies to execute Android builds
RUN dpkg --add-architecture i386
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386


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
# (!!!) Only install one package at a time, as "echo y" will only work for one license!
#       If you don't do it this way you might get "Unknown response" in the logs,
#         but the android SDK tool **won't** fail, it'll just **NOT** install the package.
RUN echo y | android update sdk --no-ui --all --filter platform-tools | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-android-support | grep 'package installed'

# SDKs
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter android-24 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-22 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-21 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-20 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-19 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-17 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-15 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter android-10 | grep 'package installed'

# build tools
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.3 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-22.0.1 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-21.1.2 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-20.0.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-19.1.0 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter build-tools-17.0.0 | grep 'package installed'

# Android System Images, for emulators
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-24 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-22 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-21 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-19 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-17 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-15 | grep 'package installed'

# Extras
RUN echo y | android update sdk --no-ui --all --filter extra-android-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter extra-google-google_play_services | grep 'package installed'

# google apis
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-23 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-22 | grep 'package installed'
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-21 | grep 'package installed'


# ------------------------------------------------------
# --- Install Gradle from PPA

# Gradle PPA
RUN apt-get update
RUN apt-get -y install gradle
RUN gradle -v

# ------------------------------------------------------
# --- Install Maven 3 from PPA

RUN apt-get purge maven maven2
RUN apt-get update
RUN apt-get -y install maven
RUN mvn --version

# ------------------------------------------------------
# --- Install Fastlane

RUN gem install fastlane --no-document
RUN fastlane --version

# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID 2016_06_18_1
CMD bitrise -version
