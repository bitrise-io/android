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

RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f android-sdk-tools.zip

ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

# ------------------------------------------------------
# --- Install Android SDKs and other build packages

# Other tools and resources of Android SDK
#  you should only install the packages you need!
# To get a full list of available options you can use:
#  sdkmanager --list

# Accept "android-sdk-license" before installing components, no need to echo y for each component
# License is valid for all the standard components in versions installed from this file
# Non-standard components: MIPS system images, preview versions, GDK (Google Glass) and Android Google TV require separate licenses, not accepted there
RUN mkdir -p ${ANDROID_HOME}/licenses
RUN echo 8933bad161af4178b1185d1a37fbf41ea5269c55 > ${ANDROID_HOME}/licenses/android-sdk-license

# Platform tools
RUN sdkmanager "platform-tools"

# SDKs
# Please keep these in descending order!
RUN sdkmanager "platforms;android-25"
RUN sdkmanager "platforms;android-24"
RUN sdkmanager "platforms;android-23"
RUN sdkmanager "platforms;android-22"
RUN sdkmanager "platforms;android-21"
RUN sdkmanager "platforms;android-20"
RUN sdkmanager "platforms;android-19"
RUN sdkmanager "platforms;android-17"
RUN sdkmanager "platforms;android-15"
RUN sdkmanager "platforms;android-10"

# build tools
# Please keep these in descending order!
RUN sdkmanager "build-tools;25.0.2"
RUN sdkmanager "build-tools;24.0.3"
RUN sdkmanager "build-tools;23.0.3"
RUN sdkmanager "build-tools;22.0.1"
RUN sdkmanager "build-tools;21.1.2"
RUN sdkmanager "build-tools;20.0.0"
RUN sdkmanager "build-tools;19.1.0"
RUN sdkmanager "build-tools;17.0.0"

# Android System Images, for emulators
# Please keep these in descending order!
RUN sdkmanager "system-images;android-25;google_apis;armeabi-v7a"
RUN sdkmanager "system-images;android-24;default;armeabi-v7a"
RUN sdkmanager "system-images;android-22;default;armeabi-v7a"
RUN sdkmanager "system-images;android-21;default;armeabi-v7a"
RUN sdkmanager "system-images;android-19;default;armeabi-v7a"
RUN sdkmanager "system-images;android-17;default;armeabi-v7a"
RUN sdkmanager "system-images;android-15;default;armeabi-v7a"

# Extras
RUN sdkmanager "extras;android;m2repository"
RUN sdkmanager "extras;google;m2repository"
RUN sdkmanager "extras;google;google_play_services"

# Constraint Layout
# Please keep these in descending order!
RUN sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
RUN sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1"

# google apis
# Please keep these in descending order!
RUN sdkmanager "add-ons;addon-google_apis-google-23"
RUN sdkmanager "add-ons;addon-google_apis-google-22"
RUN sdkmanager "add-ons;addon-google_apis-google-21"

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
# --- Pre-install Ionic and Cordova CLIs

RUN npm install -g ionic cordova


# ------------------------------------------------------
# --- Install Fastlane

RUN gem install fastlane --no-document
RUN fastlane --version

# ------------------------------------------------------
# --- Install Google Cloud SDK
# https://cloud.google.com/sdk/downloads
#  Section: apt-get (Debian and Ubuntu only)
#
# E.g. for "Using Firebase Test Lab for Android from the gcloud Command Line":
#  https://firebase.google.com/docs/test-lab/command-line
#

RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk-`lsb_release -c -s` main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
RUN sudo apt-get update -qq
RUN sudo apt-get install -y -qq google-cloud-sdk

ENV GCLOUD_SDK_CONFIG /usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json

# gcloud config doesn't update config.json. See the official Dockerfile for details:
#  https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/Dockerfile
RUN /usr/bin/gcloud config set --installation component_manager/disable_update_check true
RUN sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' $GCLOUD_SDK_CONFIG

RUN /usr/bin/gcloud config set --installation core/disable_usage_reporting true
RUN sed -i -- 's/\"disable_usage_reporting\": false/\"disable_usage_reporting\": true/g' $GCLOUD_SDK_CONFIG


# ------------------------------------------------------
# --- Install additional packages

# Required for Android ARM Emulator
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libqt5widgets5
ENV QT_QPA_PLATFORM offscreen
ENV LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:${ANDROID_HOME}/tools/lib64


# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID v2017_03_14_1
CMD bitrise -version
