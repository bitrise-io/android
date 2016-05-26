FROM bitriseio/docker-bitrise-base:2016_05_14_1

ENV ANDROID_HOME /opt/android-sdk-linux


# ------------------------------------------------------
# --- Install required tools

RUN apt-get update -qq

# Base (non android specific) tools
# -> should be added to bitriseio/docker-bitrise-base

# Dependencies to execute Android builds
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
RUN echo y | android update sdk --no-ui --all --filter platform-tools
RUN echo y | android update sdk --no-ui --all --filter extra-android-support

# google apis
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-23
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-22
RUN echo y | android update sdk --no-ui --all --filter addon-google_apis-google-21

# SDKs
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter android-N
RUN echo y | android update sdk --no-ui --all --filter android-23
RUN echo y | android update sdk --no-ui --all --filter android-22
RUN echo y | android update sdk --no-ui --all --filter android-21
RUN echo y | android update sdk --no-ui --all --filter android-20
RUN echo y | android update sdk --no-ui --all --filter android-19
RUN echo y | android update sdk --no-ui --all --filter android-17
RUN echo y | android update sdk --no-ui --all --filter android-15
RUN echo y | android update sdk --no-ui --all --filter android-10

# build tools
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter build-tools-24.0.0-preview
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.3
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.2
RUN echo y | android update sdk --no-ui --all --filter build-tools-23.0.1
RUN echo y | android update sdk --no-ui --all --filter build-tools-22.0.1
RUN echo y | android update sdk --no-ui --all --filter build-tools-21.1.2
RUN echo y | android update sdk --no-ui --all --filter build-tools-20.0.0
RUN echo y | android update sdk --no-ui --all --filter build-tools-19.1.0
RUN echo y | android update sdk --no-ui --all --filter build-tools-17.0.0

# Android System Images, for emulators
# Please keep these in descending order!
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-23
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-22
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-21
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-19
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-17
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-16
RUN echo y | android update sdk --no-ui --all --filter sys-img-armeabi-v7a-android-15

# Extras
RUN echo y | android update sdk --no-ui --all --filter extra-android-m2repository
RUN echo y | android update sdk --no-ui --all --filter extra-google-m2repository
RUN echo y | android update sdk --no-ui --all --filter extra-google-google_play_services


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
# --- Install Fastlane

RUN gem install fastlane --no-document
RUN fastlane --version

# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID 2016_05_26_1
CMD bitrise -version
