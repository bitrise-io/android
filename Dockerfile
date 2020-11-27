FROM quay.io/bitriseio/bitrise-base:alpha

ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
# Preserved for backwards compatibility
ENV ANDROID_HOME /opt/android-sdk-linux

# ------------------------------------------------------
# --- Install required tools

RUN add-apt-repository ppa:openjdk-r/ppa
RUN dpkg --add-architecture i386

# Base (non android specific) tools
# -> should be added to bitriseio/docker-bitrise-base

# Dependencies to execute Android builds
RUN apt-get update -qq
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y openjdk-8-jdk openjdk-11-jdk libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 net-tools

# Keystore format has changed since JAVA 8 https://bugs.launchpad.net/ubuntu/+source/openjdk-9/+bug/1743139
RUN mv /etc/ssl/certs/java/cacerts /etc/ssl/certs/java/cacerts.old \
    && keytool -importkeystore -destkeystore /etc/ssl/certs/java/cacerts -deststoretype jks -deststorepass changeit -srckeystore /etc/ssl/certs/java/cacerts.old -srcstoretype pkcs12 -srcstorepass changeit \
    && rm /etc/ssl/certs/java/cacerts.old

# Select JAVA 8  as default
RUN sudo update-java-alternatives --jre-headless --set java-1.8.0-openjdk-amd64
RUN sudo update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac

# ------------------------------------------------------
# --- Download Android Command line Tools into $ANDROID_SDK_ROOT

RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip -O android-commandline-tools.zip \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && unzip -q android-commandline-tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools \
    && rm android-commandline-tools.zip

ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/tools/bin

# ------------------------------------------------------
# --- Install Android SDKs and other build packages

# Other tools and resources of Android SDK
#  you should only install the packages you need!
# To get a full list of available options you can use:
#  sdkmanager --list

# Accept licenses before installing components, no need to echo y for each component
# License is valid for all the standard components in versions installed from this file
# Non-standard components: MIPS system images, preview versions, GDK (Google Glass) and Android Google TV require separate licenses, not accepted there
RUN yes | sdkmanager --licenses

RUN touch /root/.android/repositories.cfg

# Emulator and Platform tools
RUN yes | sdkmanager "emulator" "platform-tools"

# SDKs
# Please keep these in descending order!
# The `yes` is for accepting all non-standard tool licenses.

RUN yes | sdkmanager --update --channel=3
# Please keep all sections in descending order!
RUN yes | sdkmanager \
    "platforms;android-30" \
    "platforms;android-29" \
    "platforms;android-28" \
    "platforms;android-27" \
    "platforms;android-26" \
    "platforms;android-25" \
    "platforms;android-24" \
    "platforms;android-23" \
    "platforms;android-22" \
    "platforms;android-21" \
    "platforms;android-19" \
    "platforms;android-17" \
    "platforms;android-15" \
    "build-tools;30.0.2" \
    "build-tools;30.0.0" \
    "build-tools;29.0.3" \
    "build-tools;29.0.2" \
    "build-tools;29.0.1" \
    "build-tools;29.0.0" \
    "build-tools;28.0.3" \
    "build-tools;28.0.2" \
    "build-tools;28.0.1" \
    "build-tools;28.0.0" \
    "build-tools;27.0.3" \
    "build-tools;27.0.2" \
    "build-tools;27.0.1" \
    "build-tools;27.0.0" \
    "build-tools;26.0.2" \
    "build-tools;26.0.1" \
    "build-tools;25.0.3" \
    "build-tools;24.0.3" \
    "build-tools;23.0.3" \
    "build-tools;22.0.1" \
    "build-tools;21.1.2" \
    "build-tools;19.1.0" \
    "build-tools;17.0.0" \
    "system-images;android-30;google_apis;x86" \
    "system-images;android-29;google_apis;x86" \
    "system-images;android-28;google_apis;x86_64" \
    "system-images;android-26;google_apis;x86" \
    "system-images;android-25;google_apis;armeabi-v7a" \
    "system-images;android-24;default;armeabi-v7a" \
    "system-images;android-22;default;armeabi-v7a" \
    "system-images;android-19;default;armeabi-v7a" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" \
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.1" \
    "add-ons;addon-google_apis-google-23" \
    "add-ons;addon-google_apis-google-22" \
    "add-ons;addon-google_apis-google-21"

# ------------------------------------------------------
# --- Install Gradle from PPA

# Gradle PPA
ENV GRADLE_VERSION=6.3
ENV PATH=$PATH:"/opt/gradle/gradle-6.3/bin/"
RUN wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -P /tmp \
    && unzip -d /opt/gradle /tmp/gradle-*.zip \
    && chmod +775 /opt/gradle \
    && gradle --version \
    && rm -rf /tmp/gradle*

# ------------------------------------------------------
# --- Install Maven 3 from PPA

RUN apt-get purge maven maven2 \
 && apt-get update \
 && apt-get -y install maven \
 && mvn --version

# Reselect JAVA 8  as default
RUN sudo update-java-alternatives --jre-headless --set java-1.8.0-openjdk-amd64
RUN sudo update-alternatives --set javac /usr/lib/jvm/java-8-openjdk-amd64/bin/javac
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# ------------------------------------------------------
# --- Pre-install jq
RUN sudo apt-get install jq

# ------------------------------------------------------
# --- Pre-install Ionic and Cordova CLIs

RUN npm install -g ionic cordova


# ------------------------------------------------------
# --- Install Fastlane

RUN gem install fastlane --no-document \
 && fastlane --version

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
RUN sudo apt-get update -qq \
 && sudo apt-get install -y -qq google-cloud-sdk

ENV GCLOUD_SDK_CONFIG /usr/lib/google-cloud-sdk/lib/googlecloudsdk/core/config.json

# gcloud config doesn't update config.json. See the official Dockerfile for details:
#  https://github.com/GoogleCloudPlatform/cloud-sdk-docker/blob/master/Dockerfile
RUN /usr/bin/gcloud config set --installation component_manager/disable_update_check true \
 && sed -i -- 's/\"disable_updater\": false/\"disable_updater\": true/g' $GCLOUD_SDK_CONFIG \
 && /usr/bin/gcloud config set --installation core/disable_usage_reporting true \
 && sed -i -- 's/\"disable_usage_reporting\": false/\"disable_usage_reporting\": true/g' $GCLOUD_SDK_CONFIG

# ------------------------------------------------------
# --- Install Firebase Tools (Firebase CLI)
# https://github.com/firebase/firebase-tools
#
# It's required for using Firebase App Distribution.
#  https://firebase.google.com/products/app-distribution
#

RUN npm install -g firebase-tools

# ------------------------------------------------------
# --- Install additional packages

# Required for Android ARM Emulator
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libqt5widgets5
ENV QT_QPA_PLATFORM offscreen
ENV LD_LIBRARY_PATH ${ANDROID_SDK_ROOT}/emulator/lib64:${ANDROID_SDK_ROOT}/emulator/lib64/qt/lib

# -------------------------------------------------------
# Tools to parse apk/aab info in deploy-to-bitrise-io step
ENV APKINFO_TOOLS /opt/apktools
RUN mkdir ${APKINFO_TOOLS}
RUN wget -q https://github.com/google/bundletool/releases/download/0.10.3/bundletool-all-0.10.3.jar -O ${APKINFO_TOOLS}/bundletool.jar
RUN cd /opt \
    && wget -q https://dl.google.com/dl/android/maven2/com/android/tools/build/aapt2/3.5.0-5435860/aapt2-3.5.0-5435860-linux.jar -O aapt2.jar \
    && unzip -q aapt2.jar aapt2 -d ${APKINFO_TOOLS} \
    && rm aapt2.jar

# ------------------------------------------------------
# --- Cleanup and rev num

# Cleaning
RUN apt-get clean

ENV BITRISE_DOCKER_REV_NUMBER_ANDROID v2020_09_22_1
CMD bitrise -version
